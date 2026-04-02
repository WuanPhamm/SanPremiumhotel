package controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.roomDAO;
import dao.room_ratingDAO;
import dao.room_typeDAO;
import model.room_rating;
import model.room_type;

public class Cus_HomeController extends HttpServlet{	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		resp.setCharacterEncoding("UTF-8");
		resp.setContentType("text/html; charset=UTF-8");
		
		
		int room_number =roomDAO.getIns().countRooms();
		double avg_star= room_ratingDAO.getIns().getAverageRating();
		avg_star = Math.round(avg_star * 10.0) / 10.0;
		int cus_satified=room_ratingDAO.getIns().countRatingStar3Up();
		
		int d=0;
		int cus_satified_percent=0;
		List<room_rating> room_ratings=room_ratingDAO.getIns().selectAll();
		for (room_rating room_rating : room_ratings) {
			d++;
		}
		if(d>0) {
			cus_satified_percent = (int) Math.round((cus_satified * 100.0) / d);
		}
		
		
		List<room_type> rTypes=room_typeDAO.getIns().selectAll();
		
		req.setAttribute("room_number", room_number);
		req.setAttribute("avg_star", avg_star);
		req.setAttribute("cus_sastified", cus_satified);
		req.setAttribute("percent", cus_satified_percent);
		req.setAttribute("r_type", rTypes);
		req.getRequestDispatcher("customer/trangchu.jsp").forward(req, resp);
	}
}
