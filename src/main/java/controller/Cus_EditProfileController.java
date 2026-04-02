package controller;

import java.io.IOException;
import java.sql.Date;
import javax.servlet.*;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.*;

import dao.accountDAO;
import dao.customerDAO;
import model.account;
import model.customer;
import util.PasswordEncoderUtil;


@MultipartConfig(
	    fileSizeThreshold = 1024 * 1024 * 2, // 2MB
	    maxFileSize = 1024 * 1024 * 10,      // 10MB
	    maxRequestSize = 1024 * 1024 * 50    // 50MB
	)
public class Cus_EditProfileController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		req.setCharacterEncoding("UTF-8");
		resp.setCharacterEncoding("UTF-8");
		resp.setContentType("text/html; charset=UTF-8");

		String action = req.getParameter("action");

		if ("u_pw".equals(action)) {
			updatePass(req, resp);
		} else if ("u_inf".equals(action)) {
			updateInfor(req, resp);
		}
		else if ("u_avt".equals(action)) { // <--- Thêm logic mới này
	        updateAvatar(req, resp);
	    }
	}

	protected void updateInfor(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		request.setCharacterEncoding("UTF-8");
		HttpSession session = request.getSession();
		customer cus = (customer) session.getAttribute("customer");

		if (cus == null) {
			response.sendRedirect("login.jsp");
			return;
		}

		try {
			String firstname = request.getParameter("cus_firstname");
			String lastname = request.getParameter("cus_lastname");
			String phone = request.getParameter("cus_phone");
			String email = request.getParameter("cus_email");
			String address = request.getParameter("cus_address");
			String cccd = request.getParameter("cus_cccd");
			String genderStr = request.getParameter("cus_gender");
			int gender = (genderStr != null && !genderStr.isEmpty()) ? Integer.parseInt(genderStr) : 0;
			String dobStr = request.getParameter("cus_dob");
			Date dob = (dobStr != null && !dobStr.isEmpty()) ? Date.valueOf(dobStr) : null;

			cus.setCus_firstname(firstname);
			cus.setCus_lastname(lastname);
			cus.setCus_dob(dob);
			cus.setCus_gender(gender);
			cus.setCus_phone(phone);
			cus.setCus_email(email);
			cus.setCus_address(address);
			cus.setCus_cccd(cccd);

			int result = customerDAO.getIns().update(cus);

			session.setAttribute("customer", cus);

			String message = (result > 0) ? "success_info" : "fail_info";
			response.sendRedirect(request.getContextPath() + "/accdetail?id=" + cus.getCus_id() + "&message=" + message);

		} catch (Exception e) {
			e.printStackTrace();
			response.sendRedirect(request.getContextPath() + "/accdetail?id=" + cus.getCus_id() + "&message=fail_info");
		}
	}

	private void updatePass(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String password = req.getParameter("password");
		String newPassword = req.getParameter("newPassword");
		String renewPassword = req.getParameter("renewPassword");

		HttpSession session = req.getSession();
		account acc = (account) session.getAttribute("account");

		String message = "fail_pw";
		
		

		if (acc != null && PasswordEncoderUtil.matches(password, acc.getAcc_password())) {
			if (newPassword.equals(renewPassword)) {
				
				String hashedPassword = PasswordEncoderUtil.encode(newPassword);
				acc.setAcc_password(hashedPassword);
				int kq = accountDAO.getIns().update(acc);
				if (kq == 1) {
					message = "success_pw";
				}
			}
		}

		customer cus = customerDAO.getIns().getCustomerByAccountId(acc.getAcc_id());
		resp.sendRedirect(req.getContextPath() + "/accdetail?id=" + cus.getCus_id() + "&message=" + message);
	}
	
	
	// Trong Cus_EditProfileController.java

	private void updateAvatar(HttpServletRequest request, HttpServletResponse response) 
	        throws ServletException, IOException {
	    
	    HttpSession session = request.getSession();
	    customer cus = (customer) session.getAttribute("customer");

	    if (cus == null) {
	        response.sendRedirect("login.jsp");
	        return;
	    }
	    
	    String message = "fail_info";
	    
	    try {
	        // 1. Lấy phần file (Part) từ request
	        Part filePart = request.getPart("avatarFile");
	        String fileName = filePart.getSubmittedFileName(); // Tên file gốc
	        
	        // 2. Định nghĩa thư mục lưu trữ (thư mục phải tồn tại trên Server)
	        // Đây là ví dụ, bạn cần đảm bảo đường dẫn này đúng trong project của mình
	        String uploadDir = getServletContext().getRealPath("/") + "assets/images/customer_avatars"; 
	        java.io.File uploadDirectory = new java.io.File(uploadDir);
	        if (!uploadDirectory.exists()) {
	            uploadDirectory.mkdirs(); // Tạo thư mục nếu chưa tồn tại
	        }

	        // 3. Tạo tên file duy nhất để tránh trùng lặp
	        String uniqueFileName = System.currentTimeMillis() + "_" + fileName;
	        String filePath = uploadDir + java.io.File.separator + uniqueFileName;
	        
	        // 4. Ghi file vào server
	        filePart.write(filePath);

	        // 5. Cập nhật đường dẫn mới vào đối tượng customer
	        // Lưu ý: Đường dẫn URL là đường dẫn tương đối (từ context root)
	        String newAvatarUrl = request.getContextPath() + "/assets/images/customer_avatars/" + uniqueFileName;
	        cus.setCus_avt_url(newAvatarUrl); 

	        // 6. Cập nhật vào DB
	        int result = customerDAO.getIns().updateAvatarUrl(cus.getCus_id(), newAvatarUrl); 
	        // (Giả sử bạn có phương thức updateAvatarUrl trong customerDAO)

	        if (result > 0) {
	            session.setAttribute("customer", cus); // Cập nhật session
	            message = "success_info";
	        }

	    } catch (Exception e) {
	        e.printStackTrace();
	        message = "fail_info";
	    }

	    // Chuyển hướng về trang profile
	    response.sendRedirect(request.getContextPath() + "/accdetail?id=" + cus.getCus_id() + "&message=" + message);
	}
}
