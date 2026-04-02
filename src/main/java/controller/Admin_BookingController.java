package controller;

import java.io.IOException;
import java.math.BigDecimal;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.booking;
import model.cus_wallet;
import model.customer;
import model.room;
import dao.accountDAO;
import dao.bookingDAO;
import dao.cus_walletDAO;
import dao.customerDAO;
import dao.roomDAO;
import dao.unavailable_dateDAO;

// Map Servlet này tới một URL dễ quản lý trong Admin
@WebServlet("/booking-management")
public class Admin_BookingController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    /**
     * LƯU Ý: 
     * Do cách thiết kế bookingDAO (lấy connection trong constructor và đóng trong mỗi hàm),
     * chúng ta KHÔNG thể lưu trữ 'bookingDao' làm biến instance.
     * Chúng ta phải gọi bookingDAO.getIns() BÊN TRONG mỗi hàm (doGet, handleAction)
     * để đảm bảo có connection mới cho mỗi yêu cầu.
     */
    public Admin_BookingController() {
        super();
        // Không khởi tạo DAO ở đây
    }

    /**
     * Xử lý hiển thị danh sách tất cả các đơn đặt phòng
     */
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");
        
        String action = req.getParameter("action");
        
        if (action != null && !action.isEmpty()) {
            handleAction(req, resp, action);
            return; // Dừng xử lý doGet sau khi handleAction (vì nó đã redirect)
        }
        
        // --- BẮT ĐẦU THAY ĐỔI: Xử lý Lọc theo DAO đã có ---
        String filterStatus = req.getParameter("filterStatus");
        ArrayList<booking> bookingList;
        
        // 1. Lấy bookingDAO instance MỚI
        bookingDAO bDao = bookingDAO.getIns(); 

        if (filterStatus != null && !filterStatus.isEmpty() && !filterStatus.equals("all")) {
            try {
                int statusId = Integer.parseInt(filterStatus);
                // 2. Dùng selectByCondition thay vì selectAllByStatus
                String condition = "bs_id = " + statusId;
                bookingList = bDao.selectByCondition(condition); 
            } catch (NumberFormatException e) {
                System.err.println("Trạng thái lọc không hợp lệ: " + filterStatus);
                // Nếu lỗi, lấy tất cả
                // Phải gọi getIns() LẦN NỮA vì selectByCondition có thể đã đóng connection
                bookingList = bookingDAO.getIns().selectAll();
            }
        } else {
            // Mặc định: Lấy tất cả
            bookingList = bDao.selectAll();
        }
        // Tại thời điểm này, connection của 'bDao' đã bị đóng (do selectAll/selectByCondition)
        // --- KẾT THÚC THAY ĐỔI ---

        // 3. Lấy roomDAO instance MỚI để lấy danh sách phòng
        // (Giả định roomDAO có cùng cấu trúc connection-handling)
        roomDAO rDao = roomDAO.getIns();
        ArrayList<room> roomList = rDao.selectAll();
        
        req.setAttribute("roomList", roomList);
        req.setAttribute("bookingList", bookingList);
        
        req.getRequestDispatcher("/admin/booking_management.jsp").forward(req, resp);
    }

    /**
     * Xử lý các yêu cầu thay đổi trạng thái (Xác nhận, Hủy, Xóa logic)
     */
    private void handleAction(HttpServletRequest req, HttpServletResponse resp, String action) throws IOException {
        String bookingId_raw = req.getParameter("id");
        if (bookingId_raw == null || bookingId_raw.isEmpty()) {
            resp.sendRedirect(req.getContextPath() + "/booking-management?error=missingid");
            return;
        }

        try {
            int bookingId = Integer.parseInt(bookingId_raw);
            int newBsId = 0; 
            int result = 0;
            String message = "";
            String messageType = "msg";
            
            // 1. Lấy bookingDAO instance MỚI cho hành động này
            bookingDAO bDao = bookingDAO.getIns();
            booking b; // Khai báo biến booking

            switch (action) {
                case "confirm":
                    newBsId = 2; // 2 = Đã xác nhận
                    
                    // --- BẮT ĐẦU THAY ĐỔI: Dùng selectById + update ---
                    // Phải dùng 2 instance DAO riêng biệt vì selectById sẽ đóng connection
                    b = bookingDAO.getIns().selectById(bookingId); // DAO 1: Lấy và đóng
                    if (b != null) {
                        b.setBs_id(newBsId); // Sửa trạng thái
                        result = bookingDAO.getIns().update(b); // DAO 2: Cập nhật và đóng
                    }
                    // --- KẾT THÚC THAY ĐỔI ---
                    
                    if(result>0) {
                    	room r= roomDAO.getIns().selectById(b.getRoom_id());
                    	int booking_time=r.getRoom_booking_time()+1;
                    	
                    	r.setRoom_booking_time(booking_time);
                    	roomDAO.getIns().update(r);
                    	
                    	
                    }
                    
                    message = (result > 0) ? "Xác nhận thành công !" : "Xác nhận thất bại.";
                    
                    
                    if (result <= 0) messageType = "error";
                    break;
                    
                case "cancel":
                    newBsId = 4; 
                    
                    
                    // --- BẮT ĐẦU THAY ĐỔI: Dùng selectById + update ---
                    b = bookingDAO.getIns().selectById(bookingId); // DAO 1: Lấy và đóng
                    if (b != null) {
                        b.setBs_id(newBsId); // Sửa trạng thái
                        result = bookingDAO.getIns().update(b); // DAO 2: Cập nhật và đóng
                        if(b.getPayment_time() != null) {
                        	 customer cus = customerDAO.getIns().selectById(b.getCus_id());
                             int acc_id=cus.getAcc_id();
                             cus_wallet cw=cus_walletDAO.getInstance().getWalletByAccountId(acc_id);
                             BigDecimal newBalance = cw.getBalance().add(b.getBooking_total());
                             cw.setBalance(newBalance);
                             cus_walletDAO.getInstance().update(cw);
                        }
                        unavailable_dateDAO.getIns().deleteByBookingId(bookingId);
                    }
                    // --- KẾT THÚC THAY ĐỔI ---
                    
                    message = (result > 0) ? " Hủy thành công !" : "Hủy  thất bại.";
                     if (result <= 0) messageType = "error";
                    break;
                    
                case "delete":
                    // Hàm delete(b) đã có sẵn trong DAO
                    b = new booking();
                    b.setBooking_id(bookingId);
                    unavailable_dateDAO.getIns().deleteByBookingId(bookingId);
                    result = bDao.delete(b);
                    // Dùng instance đã tạo ở đầu hàm
                    message = (result > 0) ? "Xóa thành công !" : "Xóa thất bại.";
                     if (result <= 0) messageType = "error";
                    break;
                    
                default:
                    messageType = "error";
                    message = "Action không hợp lệ.";
                    break;
            }
            
            // Chuyển hướng về trang danh sách với thông báo
            String filterStatus = req.getParameter("filterStatus");
            String redirectUrl = req.getContextPath() + "/booking-management?" + messageType + "=" + java.net.URLEncoder.encode(message, "UTF-8");
            
            if (filterStatus != null && !filterStatus.isEmpty()) {
                redirectUrl += "&filterStatus=" + filterStatus;
            }
            
            resp.sendRedirect(redirectUrl);
            
        } catch (NumberFormatException e) {
            System.err.println("ID không hợp lệ: " + e.getMessage());
            resp.sendRedirect(req.getContextPath() + "/booking-management?error=invalidid");
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // Chuyển tất cả POST sang GET để xử lý
        doGet(req, resp);
    }
}