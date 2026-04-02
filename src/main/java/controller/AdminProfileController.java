package controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;



import model.user;
import dao.userDAO;

public class AdminProfileController extends HttpServlet{	
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
				 user u = userDAO.getInstance().selectById(id);
				
				if (u != null) {
					req.setAttribute("u", u);
					req.getRequestDispatcher("/admin/admin_profile.jsp").forward(req, resp);
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

