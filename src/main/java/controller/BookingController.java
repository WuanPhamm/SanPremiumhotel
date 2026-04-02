package controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import model.booking;
import model.booking_status;
import model.customer;
import model.floor;
import model.room;
import model.room_type;
import model.unavailable_date;
import dao.bookingDAO;
import dao.customerDAO;
import dao.floorDAO;
import dao.roomDAO;
import dao.room_typeDAO;
import dao.unavailable_dateDAO;

public class BookingController extends HttpServlet{	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		resp.setCharacterEncoding("UTF-8");
		resp.setContentType("text/html; charset=UTF-8");
		
				
		String id_raw = req.getParameter("id");
		if (id_raw != null) {
			try {
				int id = Integer.parseInt(id_raw);
				 customer cus = customerDAO.getIns().selectById(id);
				
				if (cus != null) {
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
					req.setAttribute("cus", cus);
					req.getRequestDispatcher("/customer/booking.jsp").forward(req, resp);
				} else {
					resp.getWriter().println("Không tìm thấy người dùng với ID = " + id);
				}
			} catch (NumberFormatException e) {
				resp.getWriter().println("ID không hợp lệ!");
			}
		} else {
			resp.getWriter().println("Thiếu tham số ID!");
		}
	}
	
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		String action = req.getParameter("action");

		if ("".equals(action) || action == null) {
			return;
		}

		switch (action) {
		case "book": {
			cusBooking(req, resp);
			break;
		}
		case "confirm": {
			confirmBooking(req, resp);
			break;
		}
		
		}
	}
	
	protected void cusBooking(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		resp.setCharacterEncoding("UTF-8");
		resp.setContentType("text/html; charset=UTF-8");


		String customerId_raw = req.getParameter("customer_id");
		try {
			// 1. Lấy dữ liệu từ form
			// (Tên tham số "name" trong thẻ <input> của bạn phải khớp)
			int customer_id = Integer.parseInt(customerId_raw);
			
			
			
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

			// 3. Tạo đối tượng booking
			booking newBooking = new booking();
			newBooking.setBooking_time(booking_time);       // Thời gian đặt là ngay bây giờ
			newBooking.setBooking_start_date(start_date);
			newBooking.setBooking_end_date(end_date);
			newBooking.setBooking_requirements(requirements);
			newBooking.setBooking_total(booking_total);
			newBooking.setPayment_time(null);               // Chưa thanh toán
			newBooking.setRoom_id(room_id);
			newBooking.setPay_id(1); 
			newBooking.setBs_id(5);  // 1 = "đang chờ xác nhận" (theo yêu cầu trước)
			newBooking.setCus_id(customer_id);
			
			
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
				resp.sendRedirect(req.getContextPath() + "/pre_payment?id=" + newBooking.getBooking_id() + "&success=true");
			} else {
				// Đặt phòng thất bại (lỗi DB)
				System.out.println("Booking thất bại (DB) cho cus_id: " + customer_id);
				// Chuyển hướng về trang đặt phòng với thông báo lỗi
				resp.sendRedirect(req.getContextPath() + "/booking?id=" + customer_id + "&error=dbfail");
			}

		} catch (Exception e) {
			e.printStackTrace();
			// Lỗi chuyển đổi dữ liệu (ngày tháng, số... không hợp lệ)
			System.out.println("Booking thất bại (dữ liệu) cho cus_id: " + customerId_raw);
			// Chuyển hướng về trang đặt phòng với thông báo lỗi
			resp.sendRedirect(req.getContextPath() + "/booking?id=" + customerId_raw + "&error=invaliddata");
		}
	}
	protected void confirmBooking(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		resp.setCharacterEncoding("UTF-8");
		resp.setContentType("text/html; charset=UTF-8");

		
	}
	
}
