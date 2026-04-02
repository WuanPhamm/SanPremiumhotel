package controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Date;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.bookingDAO;
import dao.roomDAO;
import dao.room_typeDAO;
// customerDAO không cần thiết nếu bạn chỉ lấy từ session
// import dao.customerDAO; 
import model.booking;
import model.customer;
import model.room;
import model.room_type;

/**
 * Controller này quản lý trang "Quản lý đặt phòng" của khách hàng.
 * Nó xử lý cả việc hiển thị (doGet) và các hành động (doPost/doGet-với-param).
 * * Logic Trạng thái (bs_id):
 * 1 = Đã thanh toán
 * 2 = Đã xác nhận
 * 3 = Đang chờ hủy
 * 4 = Đã hủy
 * 5 = Chưa thanh toán
 */
@WebServlet("/my-bookings")
public class Cus_Room_ManageController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");
        resp.setContentType("text/html; charset=UTF-8");

        HttpSession session = req.getSession();
        
        // --- 1. LẤY KHÁCH HÀNG TỪ SESSION ---
        // Đây là cách đúng. Không lấy customer ID từ request parameter.
        customer cus = (customer) session.getAttribute("customer"); 

        // --- 2. KIỂM TRA ĐĂNG NHẬP ---
        if (cus == null) {
            // Nếu chưa đăng nhập, chuyển hướng về trang đăng nhập
            resp.sendRedirect(req.getContextPath() + "/login"); // Hoặc trang đăng nhập của bạn
            return; // Dừng thực thi ngay lập tức
        }

        // --- 3. KIỂM TRA HÀNH ĐỘNG (Cancel, Pay, ...) ---
        String action = req.getParameter("action");
        
        if (action != null) {
            // Nếu CÓ action, gọi hàm xử lý hành động
            // 'cus' bây giờ đã được đảm bảo là có thật (đã đăng nhập)
            handleAction(req, resp, cus, action);
        } else {
            // Nếu KHÔNG có action, gọi hàm hiển thị danh sách đặt phòng
            showBookings(req, resp, cus);
        }
    }

    /**
     * Phương thức này xử lý việc lấy và phân loại các đơn đặt phòng để hiển thị
     */
    private void showBookings(HttpServletRequest req, HttpServletResponse resp, customer cus) 
            throws ServletException, IOException {
        
        bookingDAO dao = bookingDAO.getIns();
        // Lấy tất cả booking của khách hàng này
        String condition = "cus_id = " + cus.getCus_id();
        List<booking> allBookings = dao.selectByCondition(condition);

        // Tạo các danh sách để phân loại
        List<booking> upcomingList = new ArrayList<>();
        List<booking> pendingList = new ArrayList<>();
        List<booking> completedList = new ArrayList<>();
        List<booking> cancelledList = new ArrayList<>();
        List<booking> ratedList = new ArrayList<>();

        for (booking b : allBookings) {
            int status = b.getBs_id();
            
            switch (status) {
                case 5: // 5 = Chưa thanh toán
                    pendingList.add(b);
                    break;
                case 4: // 4 = Đã hủy
                    cancelledList.add(b);
                    break;
                
                // Các trạng thái này là "đang hoạt động" hoặc "đã xong"
                case 1: // 1 = Đã thanh toán- chờ xác nhận
                case 2: // 2 = Đã xác nhận
                case 3: // 3 = Đang chờ hủy
                    
                    upcomingList.add(b);
                    break;
                case 6:
                	completedList.add(b);
                	break;
                case 7:
                	
                	ratedList.add(b);
                	break;
                default:
                    break;
            }
        }
        
        Collections.reverse(ratedList);
        Collections.reverse(upcomingList);
        Collections.reverse(pendingList);
        Collections.reverse(completedList);
        Collections.reverse(cancelledList);
        // --- 3. GỬI DANH SÁCH LÊN JSP ---
        req.setAttribute("upcomingBookings", upcomingList);
        req.setAttribute("pendingBookings", pendingList);
        req.setAttribute("completedBookings", completedList);
        req.setAttribute("cancelledBookings", cancelledList);
        req.setAttribute("ratedBookings", ratedList);
        // --- 4. FORWARD TỚI TRANG JSP ---
        // Sửa tên file JSP thành tên bạn dùng trong code cũ (cus_room_manage.jsp)
        // Hoặc đổi thành my_bookings.jsp nếu bạn dùng tên file đó
        req.getRequestDispatcher("/customer/cus_room_management.jsp").forward(req, resp);
    }

    /**
     * Phương thức này xử lý các hành động như Hủy, Thanh toán...
     */
    private void handleAction(HttpServletRequest req, HttpServletResponse resp, customer cus, String action) 
            throws IOException {
        
        bookingDAO dao = bookingDAO.getIns();
        
        try {
            // 'id' ở đây là ID của ĐƠN ĐẶT PHÒNG (booking_id), không phải cus_id
            int bookingId = Integer.parseInt(req.getParameter("id"));

            // *** QUAN TRỌNG: Kiểm tra xem booking này có đúng là của khách hàng đang đăng nhập không
            booking b = dao.selectById(bookingId);
            if (b == null || b.getCus_id() != cus.getCus_id()) {
                // Nếu không, không cho phép thực hiện và quay lại trang
                resp.sendRedirect(req.getContextPath() + "/my-bookings");
                return;
            }
            
            // Xử lý action
            switch (action) {
                case "cancel":
                    // Chuyển trạng thái sang "Đang chờ hủy" (bs_id = 3)
                    if (b.getBs_id() == 5 || b.getBs_id() == 2 || b.getBs_id() == 1) {
                         dao.updateBookingStatus(bookingId, 3);
                    }
                    break;
                
                case "pay":
                    // Chuyển hướng đến trang thanh toán (ví dụ: checkout)
                    req.getSession().setAttribute("bookingIdToPay", bookingId);
                    resp.sendRedirect(req.getContextPath() + "/checkout"); // Trang thanh toán của bạn
                    return; // Dừng lại vì đã redirect
            }

        } catch (NumberFormatException e) {
            System.out.println("Invalid booking ID for action: " + req.getParameter("id"));
        }
        
        // Sau khi thực hiện hành động, tải lại trang (Redirect-After-Post)
        resp.sendRedirect(req.getContextPath() + "/my-bookings");
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // Chuyển tất cả request POST sang doGet để xử lý
        doGet(req, resp);
    }
}