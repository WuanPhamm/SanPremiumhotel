package controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.*;
import model.*;


public class FloorController extends HttpServlet {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		resp.setCharacterEncoding("UTF-8");
		resp.setContentType("text/html; charset=UTF-8");
		
		ArrayList<floor> list = new ArrayList<>();
		
		list = floorDAO.getIns().selectAll();
		
		req.setAttribute("list_floor_all", list);
		
		req.getRequestDispatcher("/admin/floor_management.jsp").forward(req, resp);
	}
	
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		resp.setCharacterEncoding("UTF-8");
		resp.setContentType("text/html; charset=UTF-8");
		
		String action = req.getParameter("action");

		if("edit".equals(action)){
			editFloor(req, resp);
		}
	}
	
	private void editFloor(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {
		int kq = 0;
		
		int floor_id = Integer.parseInt(req.getParameter("floor_id"));
		String floor_description = req.getParameter("floor_description");
		
		floor f = floorDAO.getIns().selectById(floor_id);
		f.setFloor_description(floor_description);
		
		kq = floorDAO.getIns().update(f);
		
		String message;
		if (kq > 0) {
		    message = "success";
		} else {
		    message = "fail";
		}
		resp.sendRedirect(req.getContextPath() + "/floors?message=" + message);
	}

}
