package controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Collections;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.*;

import org.apache.commons.math3.distribution.IntegerDistribution;

import dao.bookingDAO;
import dao.customerDAO;
import dao.roomDAO;
import dao.room_ratingDAO;
import dao.room_typeDAO;
import model.booking;
import model.customer;
import model.room;
import model.room_rating;
import model.room_type;

public class Cus_RoomTypeDetailController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		
		req.setCharacterEncoding("UTF-8");
		resp.setCharacterEncoding("UTF-8");
		resp.setContentType("text/html; charset=UTF-8");
		
		// Lấy id từ URL
		String id_raw = req.getParameter("id");
		if (id_raw != null) {
			try {
				int id = Integer.parseInt(id_raw);
				room_type rt = room_typeDAO.getIns().selectById(id);
				
				
				if (rt != null) {
					req.setAttribute("rt", rt);
					int d=0;
					int sum=0;
					double star=0;
					int count=0;
					List<room_rating> allRatings= new ArrayList<room_rating>();
					List<customer> allCus= new ArrayList<customer>();
					String condition = "rt_id = " + rt.getRt_id();
					List<room> allRooms = roomDAO.getIns().selectByCondition(condition);
					
					for (room room : allRooms) {
						String condition2 = "room_id = " + room.getRoom_id();
						List<booking> allBookings= bookingDAO.getIns().selectByCondition(condition2);
						
						for (booking b : allBookings) {
							
							room_rating room_rating = room_ratingDAO.getIns().selectByBookingId(b.getBooking_id());
							customer customer =customerDAO.getIns().selectById(b.getCus_id());
							if(room_rating !=null) {
								allRatings.add(room_rating);
								if (room_rating.getRate_type()==1) {
									customer.setCus_firstname("Khách hàng");
									customer.setCus_lastname("ẩn danh");
									customer.setCus_avt_url("images/anhdaidien.jpg");
								}
								allCus.add(customer);
								d +=1;
								sum += room_rating.getRate_star();
								
							}
							
						}
						
					}
					
					if(d > 0) { 
						double avg = (double) sum / d;      // Ép kiểu để chia thực
					    star = Math.round(avg * 10.0) / 10.0;  // Làm tròn 1 chữ số sau dấu phẩy
					     count=(int) Math.round(avg);
					} else {
					    
					    star = 0;
					}
					
					Collections.reverse(allRatings);
					Collections.reverse(allCus);
					req.setAttribute("star", star);
					req.setAttribute("count", count);
					req.setAttribute("rate_times", d);
					req.setAttribute("allRate", allRatings);
					req.setAttribute("allCus", allCus);
					req.getRequestDispatcher("/customer/room_detail.jsp").forward(req, resp);
				} else {
					resp.getWriter().println("Không tìm thấy loại phòng với ID = " + id);
				}
			} catch (NumberFormatException e) {
				resp.getWriter().println("ID không hợp lệ!");
			}
		} else {
			resp.getWriter().println("Thiếu tham số ID!");
		}
	}
}
