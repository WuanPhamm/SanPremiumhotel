package controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.accountDAO;
import dao.customerDAO;
import dao.userDAO;
import model.account;
import model.customer;
import model.user;
import util.PasswordEncoderUtil;

public class LoginController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	// Hiển thị trang đăng nhập
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.getRequestDispatcher("customer/login.jsp").forward(req, resp);
	}

	// Xử lý đăng nhập
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String username = req.getParameter("username");
		String password = req.getParameter("password");

		account acc = accountDAO.getIns().findAccByUsername(username);
		// Kiểm tra username/password (ví dụ đơn giản, bạn có thể thay bằng check từ DB)
		if (acc != null && acc.getRole_id() == 1 && PasswordEncoderUtil.matches(password, acc.getAcc_password())) {
			
			user u = userDAO.getInstance().getUserByAccountId(acc.getAcc_id());
			accountDAO.getIns().updateLastLogin(acc);
			
			HttpSession session = req.getSession();			
			session.setAttribute("account", acc);
			session.setAttribute("user", u);
			
			resp.sendRedirect(req.getContextPath() + "/home");
		}
		else if (acc != null && acc.getRole_id() == 2 && PasswordEncoderUtil.matches(password, acc.getAcc_password())) {
			
			customer cus = customerDAO.getIns().getCustomerByAccountId(acc.getAcc_id());
			accountDAO.getIns().updateLastLogin(acc);
			
			HttpSession session = req.getSession();			
			session.setAttribute("account", acc);
			session.setAttribute("customer", cus);
			
			resp.sendRedirect(req.getContextPath() + "/trangchu");
		} 
		else {
			req.setAttribute("error", "Sai tên đăng nhập hoặc mật khẩu!");
			req.getRequestDispatcher("customer/login.jsp").forward(req, resp);
		}
	}
}
