package controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.compress.harmony.unpack200.bytecode.forms.NewClassRefForm;

import dao.bookingDAO;
import dao.customerDAO;
import dao.floorDAO;
import dao.paymentDAO;
import dao.roomDAO;
import dao.room_typeDAO;
import dao.unavailable_dateDAO;
import model.booking;
import model.customer;
import model.floor;
import model.payment;
import model.room;
import model.room_type;
import model.unavailable_date;
import util.VnPayUtil;

@WebServlet("/admin-booking")

public class AdminBookingController extends HttpServlet{	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		resp.setCharacterEncoding("UTF-8");
		resp.setContentType("text/html; charset=UTF-8");
		
		ArrayList<room_type> list = room_typeDAO.getIns().selectAll();
		ArrayList<floor> fl_list = floorDAO.getIns().selectAll();
		ArrayList<room> r_list = new ArrayList<>();
		
		String fl_raw = req.getParameter("floor_id");
		String rt_raw = req.getParameter("rt_id");

		
		
		if (fl_raw != null && rt_raw != null && !fl_raw.isEmpty() && !rt_raw.isEmpty()) {
            int floorId = Integer.parseInt(fl_raw);
            int rtId = Integer.parseInt(rt_raw);

            // chú ý đúng thứ tự theo DAO của bạn
             r_list= roomDAO.getIns().getAvailableRooms(rtId, floorId);
        }
		
		req.setAttribute("list_fl", fl_list);
		req.setAttribute("list_room", r_list);
		req.setAttribute("list_room_type_all", list);
		req.getRequestDispatcher("admin/ad_booking.jsp").forward(req, resp);
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		resp.setCharacterEncoding("UTF-8");
		resp.setContentType("text/html; charset=UTF-8");

		// Lấy customer_id ngay từ đầu để dùng cho việc chuyển hướng nếu có lỗi
		

		try {
			// 1. Lấy dữ liệu từ form
			// (Tên tham số "name" trong thẻ <input> của bạn phải khớp)
			
			
			String firstName = req.getParameter("firstname");
			String lastName = req.getParameter("lastname");
			String email = req.getParameter("email");
			String phone = req.getParameter("cus_phone");
			String cccd = req.getParameter("cus_cccd");
			
			int room_id = Integer.parseInt(req.getParameter("room_id"));
			String startDate_raw = req.getParameter("arrival_date"); // Giả sử name="start_date"
			String endDate_raw = req.getParameter("departure_date");     // Giả sử name="end_date"
			String requirements = req.getParameter("requirements"); // Giả sử name="requirements"
			
			
			// Giả sử tổng tiền được tính toán ở client (bằng JavaScript)
			// và gửi lên trong một thẻ input hidden name="booking_total"
			String total_raw = req.getParameter("booking_total"); 

			// 2. Chuyển đổi và xử lý dữ liệu
			java.sql.Date start_date = java.sql.Date.valueOf(startDate_raw);
			java.sql.Date end_date = java.sql.Date.valueOf(endDate_raw);
			java.math.BigDecimal booking_total = new java.math.BigDecimal(total_raw);
			java.sql.Timestamp booking_time = new java.sql.Timestamp(System.currentTimeMillis());

			
			customer newCustomer =new customer();
			newCustomer.setCus_firstname(firstName);
			newCustomer.setCus_lastname(lastName);
			newCustomer.setCus_email(email);
			newCustomer.setCus_phone(phone);
			newCustomer.setCus_cccd(cccd);
			newCustomer.setAcc_id(0);
			customerDAO.getIns().insert(newCustomer);
			
			// 3. Tạo đối tượng booking
			booking newBooking = new booking();
			newBooking.setBooking_time(booking_time);       // Thời gian đặt là ngay bây giờ
			newBooking.setBooking_start_date(start_date);
			newBooking.setBooking_end_date(end_date);
			newBooking.setBooking_requirements(requirements);
			newBooking.setBooking_total(booking_total);
			newBooking.setPayment_time(null);               // Chưa thanh toán
			newBooking.setRoom_id(room_id);
			
			newBooking.setBs_id(5); 
			
			String payment = req.getParameter("payment_method");
			int payId = "vnpay".equals(payment) ? 1 : 0;
			newBooking.setPay_id(payId);

			// 1 = "đang chờ xác nhận" (theo yêu cầu trước)
			newBooking.setCus_id(newCustomer.getCus_id());
			
			
			// 4. Gọi DAO để insert
			// getIns() sẽ tạo một đối tượng DAO mới và lấy Connection mới
			int kq = bookingDAO.getIns().insert(newBooking);
			
			

			// 5. Xử lý kết quả
			if (kq > 0) {
				booking booking= bookingDAO.getIns().getLastInsertedBooking();
				unavailable_date ud= new unavailable_date();
				ud.setUd_start(start_date);
				ud.setUd_end(end_date);
				ud.setRoom_id(room_id);
				ud.setBooking_id(booking.getBooking_id());
				unavailable_dateDAO.getIns().insert(ud);
				
				if(newBooking.getPay_id() == 1) {
					long amountLong = (long) (booking.getBooking_total().doubleValue() * 100);
					
					// ** GỌI HÀM TIỆN ÍCH VNPAY **
					String paymentUrl = VnPayUtil.createPaymentUrl(req, amountLong, booking.getBooking_id());

					resp.sendRedirect(paymentUrl);
					return; // Quan trọng: dừng xử lý sau khi redirect VNPAY		
				}
				else {
					payment pay =paymentDAO.getIns().selectById(0);
	                int new_pay_times=pay.getPay_times()+1;
	                
	                java.math.BigDecimal current_pay_total = pay.getPay_total();
	                java.math.BigDecimal booking_amount = booking.getBooking_total();

	                // Sử dụng phương thức .add() để cộng hai đối tượng BigDecimal
	                java.math.BigDecimal new_total = current_pay_total.add(booking_amount);
	                //room room=roomDAO.getIns().selectById(booking.getRoom_id());
	                
	                
	                booking.setPayment_time(new java.sql.Timestamp(System.currentTimeMillis()));
                	pay.setPay_times(new_pay_times);
                	pay.setPay_total(new_total);
                	booking.setBs_id(2);
	                bookingDAO.getIns().update(booking);
	                paymentDAO.getIns().update(pay);
					
					
					resp.sendRedirect(req.getContextPath() + "/cash-payment?id="+booking.getBooking_id());
				}
					
			} else {
				// Đặt phòng thất bại (lỗi DB)
				System.out.println("Booking thất bại (DB) cho cus_id: " + newCustomer.getCus_id());
				// Chuyển hướng về trang đặt phòng với thông báo lỗi
				resp.sendRedirect(req.getContextPath() + "/admin-booking" + "&error=dbfail");
			}

		} catch (Exception e) {
			e.printStackTrace();
			// Lỗi chuyển đổi dữ liệu (ngày tháng, số... không hợp lệ)
			System.out.println("Booking thất bại " );
			// Chuyển hướng về trang đặt phòng với thông báo lỗi
			resp.sendRedirect(req.getContextPath() + "/admin-booking" +  "&error=invaliddata");
		}
	}
}
