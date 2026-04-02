package controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.*;
import model.*;

public class CustomerController extends HttpServlet{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		resp.setCharacterEncoding("UTF-8");
		resp.setContentType("text/html; charset=UTF-8");
		ArrayList<customer> list = customerDAO.getIns().selectAll();
			
		req.setAttribute("list_all", list);
		
		req.getRequestDispatcher("/admin/cus_management.jsp").forward(req, resp);
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		resp.setCharacterEncoding("UTF-8");
		resp.setContentType("text/html; charset=UTF-8");
		String action = req.getParameter("action");

		if("add".equals(action)){
			addCus(req, resp);
		}
		else if("delete".equals(action)){
			delCus(req, resp);
		}
		else if("edit".equals(action)){
			editCus(req, resp);
		}
	}
	
	private void addCus(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException{
	    String customer_firstname = req.getParameter("customer_firstname");
	    String customer_lastname = req.getParameter("customer_lastname");
	    String customer_dob = req.getParameter("customer_date_of_birth");
	    int customer_gender = Integer.parseInt(req.getParameter("customer_gender"));
	    String customer_phone = req.getParameter("customer_phone_number");
	    String customer_email = req.getParameter("customer_email");
	    String customer_address = req.getParameter("customer_address");
	    String customer_cccd = req.getParameter("customer_cccd");
	    String customer_avt_url = req.getParameter("customer_avatar_url");
	    int acc_id = Integer.parseInt(req.getParameter("account_id"));

	    // Tạo đối tượng customertomer
	    customer customer = new customer();
	    //customer.setCus_id(0);
	    customer.setCus_firstname(customer_firstname);
	    customer.setCus_lastname(customer_lastname);
	    	    
	    try {
            // Chuyển đổi ngày sinh từ String về java.sql.Date
            if (customer_dob != null && !customer_dob.isEmpty()) {
                java.sql.Date dateOfBirth = java.sql.Date.valueOf(customer_dob);
                customer.setCus_dob(dateOfBirth);
            }
        } catch (IllegalArgumentException e) {
            // Handle invalid date
            e.printStackTrace();
        }
	    
	    customer.setCus_gender(customer_gender);
	    customer.setCus_phone(customer_phone);
	    customer.setCus_email(customer_email);
	    customer.setCus_address(customer_address);
	    customer.setCus_cccd(customer_cccd);
	    customer.setCus_avt_url(customer_avt_url);
	    customer.setAcc_id(acc_id);

	    int kq = customerDAO.getIns().insert(customer);

	    String message = (kq > 0) ? "success" : "fail";
	    resp.sendRedirect(req.getContextPath() + "/customers?message=" + message);
	}

	
	private void delCus(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {
		int cus_id = Integer.parseInt(req.getParameter("customer_id"));
		
		String message = "";
		int kq = 0;
		
		customer cus = customerDAO.getIns().selectById(cus_id);
		if(cus != null)
			kq = customerDAO.getIns().delete(cus);

		if (kq > 0) {
		    message = "success";
		} else {
		    message = "fail";
		}
		resp.sendRedirect(req.getContextPath() + "/customers?message=" + message);
	}
	
	private void editCus(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {
		int cus_id = Integer.parseInt(req.getParameter("customer_id"));
		
		 String cus_firstname = req.getParameter("customer_firstname");
		    String cus_lastname = req.getParameter("customer_lastname");
		    String cus_dob = req.getParameter("customer_date_of_birth");
		    int cus_gender = Integer.parseInt(req.getParameter("customer_gender"));
		    String cus_phone = req.getParameter("customer_phone_number");
		    String cus_email = req.getParameter("customer_email");
		    String cus_address = req.getParameter("customer_address");
		    String cus_cccd = req.getParameter("customer_cccd");
		    String cus_avt_url = req.getParameter("customer_avatar_url");
		
		customer cus = customerDAO.getIns().selectById(cus_id);
		
	    cus.setCus_firstname(cus_firstname);
	    cus.setCus_lastname(cus_lastname);
	    try {
            // Chuyển đổi ngày sinh từ String về java.sql.Date
            if (cus_dob != null && !cus_dob.isEmpty()) {
                java.sql.Date dateOfBirth = java.sql.Date.valueOf(cus_dob);
                cus.setCus_dob(dateOfBirth);
            }
        } catch (IllegalArgumentException e) {
            // Handle invalid date
            e.printStackTrace();
        }
	    cus.setCus_gender(cus_gender);
	    cus.setCus_phone(cus_phone);
	    cus.setCus_email(cus_email);
	    cus.setCus_address(cus_address);
	    cus.setCus_cccd(cus_cccd);
		
		int kq = 0;
		kq = customerDAO.getIns().update(cus);
		
		String message = "";
		if (kq > 0) {
		    message = "success";
		} else {
		    message = "fail";
		}
		resp.sendRedirect(req.getContextPath() + "/customers?message=" + message);
	}

}

