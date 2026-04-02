package controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.accountDAO;
import model.account;
import util.PasswordEncoderUtil;

public class RegisterController extends HttpServlet{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.getRequestDispatcher("customer/registration.jsp").forward(req, resp);
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String action = req.getParameter("action");

		if("reg".equals(action)){
			registerAcc(req, resp);
		}
	}
	
	private void registerAcc(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {
		String username = req.getParameter("username");
		String password = req.getParameter("password");

		int kq = accountDAO.getIns().findByUsername(username);
		if (kq == 0) {	
			String hashedPassword = PasswordEncoderUtil.encode(password);
			
			
			
			account acc = new account(0, username, hashedPassword, 1, null, null, null, 0, 2);
			accountDAO.getIns().insert(acc);
			
			acc = accountDAO.getIns().findByUsernameAndPassword(username, password);

			req.setAttribute("noti", "Tạo tài khoản thành công");
			req.getRequestDispatcher("customer/registration.jsp").forward(req, resp);
		} else {
			req.setAttribute("error", "Tài khoản đã tồn tại");
			req.getRequestDispatcher("customer/registration.jsp").forward(req, resp);
		}
	}
}
