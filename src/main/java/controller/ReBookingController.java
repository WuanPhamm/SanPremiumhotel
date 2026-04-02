package controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.bookingDAO;
import dao.customerDAO;
import dao.floorDAO;
import dao.roomDAO;
import dao.room_typeDAO;
import model.booking;
import model.customer;
import model.floor;
import model.room;
import model.room_type;

@WebServlet("/re_booking")
public class ReBookingController extends HttpServlet {

	private static final long serialVersionUID = 1L;

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		resp.setCharacterEncoding("UTF-8");
		resp.setContentType("text/html; charset=UTF-8");
		
				
		String id_raw = req.getParameter("cus_id");
		if (id_raw != null) {
			try {
				int id = Integer.parseInt(id_raw);
				 customer cus = customerDAO.getIns().selectById(id);
				
				if (cus != null) {
					
					String b_raw = req.getParameter("book_id");
					
					
					int b_id = Integer.parseInt(b_raw);
					
					booking booking=bookingDAO.getIns().selectById(b_id);
					
					
					room room =roomDAO.getIns().selectById(booking.getRoom_id());
					room_type rType =room_typeDAO.getIns().selectById(room.getRt_id());
					floor fl = floorDAO.getIns().selectById(room.getFloor_id());
					req.setAttribute("fl", fl);
					req.setAttribute("room", room);
					req.setAttribute("rt", rType);
					req.setAttribute("cus", cus);
					req.getRequestDispatcher("/customer/re_booking.jsp").forward(req, resp);
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
	
}
