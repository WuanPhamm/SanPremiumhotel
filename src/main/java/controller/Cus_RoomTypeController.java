package controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.*;
import model.*;


public class Cus_RoomTypeController extends HttpServlet {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		resp.setCharacterEncoding("UTF-8");
		resp.setContentType("text/html; charset=UTF-8");
		
		ArrayList<room_type> list = new ArrayList<>();
		ArrayList<Integer> list_star = new ArrayList<>();
		
		list = room_typeDAO.getIns().selectAll();
		
		if(list !=null) {
			
			for (room_type rt : list) {
				int d=0;
				int sum=0;
				int star=0;
				
				String condition = "rt_id = " + rt.getRt_id();
				List<room> allRooms = roomDAO.getIns().selectByCondition(condition);
			
				for (room room : allRooms) {
					String condition2 = "room_id = " + room.getRoom_id();
					List<booking> allBookings= bookingDAO.getIns().selectByCondition(condition2);
					
					for (booking b : allBookings) {
						
						room_rating room_rating = room_ratingDAO.getIns().selectByBookingId(b.getBooking_id());
						
						if(room_rating !=null) {
							d +=1;
							sum += room_rating.getRate_star();
							
						}
						
					}
					
				}
				
				if(d > 0) { 
					double avg = (double) sum / d;      // Ép kiểu để chia thực
					 star = (int) Math.round(avg);
				} else {
				    
				    star = 0;
				}
				list_star.add(star);
				
			}
			req.setAttribute("list_room_type_all", list);
			req.setAttribute("list_star", list_star);
		}


		
		
		req.getRequestDispatcher("/customer/rooms.jsp").forward(req, resp);
	}
	
	

}
