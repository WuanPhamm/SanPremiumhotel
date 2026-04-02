package controller;

import java.io.File;

import java.io.IOException;
import java.sql.Date;
import javax.servlet.*;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.*;

import dao.accountDAO;
import dao.customerDAO;
import dao.userDAO;
import model.account;
import model.customer;
import model.user;
import util.PasswordEncoderUtil;

@MultipartConfig(
	    fileSizeThreshold = 1024 * 1024 * 2, // 2MB
	    maxFileSize = 1024 * 1024 * 10,      // 10MB
	    maxRequestSize = 1024 * 1024 * 50    // 50MB
	)
public class Admin_EditProfileController extends HttpServlet {
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
        else if ("u_avt".equals(action)) {
            updateAvatar(req, resp);
        }
    }

    // Cập nhật thông tin cá nhân
 // Cập nhật thông tin cá nhân (ĐÃ SỬA LẠI LOGIC)
    protected void updateInfor(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        HttpSession session = request.getSession();
        
        // 1. Lấy 'account' từ session (giống như updatePass)
        // Đây là nguồn đáng tin cậy hơn là lấy 'user'
        account acc = (account) session.getAttribute("account");

        if (acc == null) {
            response.sendRedirect("login.jsp"); // Nếu chưa đăng nhập
            return;
        }

        // Dùng account_id để lấy user_id, phòng trường hợp cần redirect khi lỗi
        user userForRedirect = userDAO.getInstance().getUserByAccountId(acc.getAcc_id());
        if (userForRedirect == null) {
            response.sendRedirect("login.jsp"); // Lỗi, không tìm thấy user
            return;
        }
        int userIdForRedirect = userForRedirect.getUser_id();

        try {
            // 2. Lấy đối tượng 'user' MỚI NHẤT từ CSDL
            // KHÔNG dùng 'user' từ session nữa
            user userToUpdate = userDAO.getInstance().getUserByAccountId(acc.getAcc_id());

            if (userToUpdate == null) {
                // Lỗi không tìm thấy user
                response.sendRedirect(request.getContextPath() + "/profile-admin?id=" + userIdForRedirect + "&message=fail_info");
                return;
            }

            // 3. Lấy tất cả thông tin từ form
            String fullname = request.getParameter("user_fullname");
            String phone = request.getParameter("user_phone_number");
            String email = request.getParameter("user_email");
            String address = request.getParameter("user_address");
            String genderStr = request.getParameter("user_gender");
            int gender = (genderStr != null && !genderStr.isEmpty()) ? Integer.parseInt(genderStr) : 0;
            String dobStr = request.getParameter("user_dob");
            Date dob = (dobStr != null && !dobStr.isEmpty()) ? Date.valueOf(dobStr) : null;

            // 4. Cập nhật thông tin vào đối tượng 'userToUpdate' (vừa lấy từ CSDL)
            userToUpdate.setUser_fullname(fullname);
            userToUpdate.setUser_dob(dob);
            userToUpdate.setUser_gender(gender);
            userToUpdate.setUser_phone_number(phone);
            userToUpdate.setUser_email(email);
            userToUpdate.setUser_address(address);
            
            

            // 6. Lưu đối tượng đã cập nhật vào CSDL
            int result = userDAO.getInstance().update(userToUpdate);
            
            // 7. Cập nhật lại session với đối tượng 'user' mới nhất
            session.setAttribute("user", userToUpdate); 

            String message = (result > 0) ? "success_info" : "fail_info";
            response.sendRedirect(request.getContextPath() + "/profile-admin?id=" + userToUpdate.getUser_id() + "&message=" + message);

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/profile-admin?id=" + userIdForRedirect + "&message=fail_info");
        }
    }
    // Cập nhật mật khẩu
    private void updatePass(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String password = req.getParameter("password");
        String newPassword = req.getParameter("newpassword");
        String renewPassword = req.getParameter("renewpassword");

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

        // Lấy lại user theo acc_id
        user u = userDAO.getInstance().getUserByAccountId(acc.getAcc_id());
        resp.sendRedirect(req.getContextPath() + "/profile-admin?id=" + u.getUser_id() + "&message=" + message);
    }
    
    private void updateAvatar(HttpServletRequest request, HttpServletResponse response) 
	        throws ServletException, IOException {
	    
	    HttpSession session = request.getSession();
	    user u = (user) session.getAttribute("user");

	    if (u == null) {
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
	        String uploadDir = getServletContext().getRealPath("/") + "assets/img/user"; 
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
	        String newAvatarUrl = request.getContextPath() + "/assets/img/user/" + uniqueFileName;
	        u.setUser_avatar_url(newAvatarUrl);
	       
	        // 6. Cập nhật vào DB
	       
	        int result = userDAO.getInstance().updateAvatarUrl(u.getUser_id(), newAvatarUrl);
	        
	        // (Giả sử bạn có phương thức updateAvatarUrl trong customerDAO)

	        if (result > 0) {
	            session.setAttribute("user", u); // Cập nhật session
	            message = "success_info";
	        }

	    } catch (Exception e) {
	        e.printStackTrace();
	        message = "fail_info";
	    }

	    // Chuyển hướng về trang profile
	    response.sendRedirect(request.getContextPath() +"/profile-admin?id=" + u.getUser_id() + "&message=" + message);
	}
}
