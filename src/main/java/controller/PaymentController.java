package controller;

import java.io.IOException;


import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.bookingDAO;
import dao.customerDAO;
import dao.roomDAO;
import dao.room_typeDAO;
import model.booking;
import model.customer;
import model.room;
import model.room_type;

@WebServlet("/pre_payment")
public class PaymentController extends HttpServlet{	
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
				
				 booking book = bookingDAO.getIns().selectById(id);
				 
				if (book != null) {
					
					customer customer= customerDAO.getIns().selectById(book.getCus_id());
					room room = roomDAO.getIns().selectById(book.getRoom_id());
					room_type room_type=room_typeDAO.getIns().selectById(room.getRt_id());
					
					req.setAttribute("rt", room_type);
					req.setAttribute("cus", customer);
					req.setAttribute("book", book);
					req.getRequestDispatcher("/customer/payment.jsp").forward(req, resp);
				} else {
					resp.getWriter().println("Không tìm thấy đơn đặt với ID = " + id);
				}
			} catch (NumberFormatException e) {
				resp.getWriter().println("ID không hợp lệ!");
			}
		} else {
			resp.getWriter().println("Thiếu tham số ID!");
		}
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException,IOException {
		
				}
	
	
	
	
	
}
