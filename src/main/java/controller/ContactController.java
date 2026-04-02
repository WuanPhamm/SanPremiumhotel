package controller;

import java.io.IOException;
import java.sql.Timestamp;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.ContactMessageDAO;
import model.ContactMessage;

@WebServlet("/contact")

public class ContactController extends HttpServlet{	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		resp.setCharacterEncoding("UTF-8");
		resp.setContentType("text/html; charset=UTF-8");
		
		req.getRequestDispatcher("customer/contact.jsp").forward(req, resp);
	}
	
	
	 @Override
	    protected void doPost(HttpServletRequest request, HttpServletResponse response)
	            throws ServletException, IOException {

	        request.setCharacterEncoding("UTF-8");
	        
	        System.out.println("Đã vào hàm doPost của ContactController");
	        // 1. Lấy dữ liệu từ form
	        String name = request.getParameter("name");
	        String email = request.getParameter("email");
	        String subject = request.getParameter("subject");
	        String message = request.getParameter("message");

	        // 2. Tạo Timestamp hiện tại
	        Timestamp now = new Timestamp(System.currentTimeMillis());

	        // 3. Tạo đối tượng ContactMessage đúng chuẩn
	        ContactMessage msg = new ContactMessage(); 
	        msg.setFullName(name);
	        msg.setEmail(email);
	        msg.setSubject(subject);
	        msg.setMessage(message);
	        msg.setCreatedAt(now); // Set Timestamp ở đây
	        // 4. Gọi DAO (dùng insert)
	        ContactMessageDAO dao = ContactMessageDAO.getIns();
	        boolean success = dao.insert(msg) > 0;

	        // 5. Set Session để hiển thị thông báo
	        HttpSession session = request.getSession();
	        if (success) {
	            session.setAttribute("contact_status", "success");
	            session.setAttribute("contact_message",
	                    "Cảm ơn bạn! Ý kiến của bạn đã được gửi thành công.");
	        } else {
	            session.setAttribute("contact_status", "error");
	            session.setAttribute("contact_message",
	                    "Rất tiếc, đã có lỗi xảy ra. Vui lòng thử lại sau.");
	        }

	        // 6. Redirect theo mô hình PRG
	        response.sendRedirect(request.getContextPath() + "/contact");

	    }
}
