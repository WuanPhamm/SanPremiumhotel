package controller;

import java.io.IOException;
import java.math.BigDecimal;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


import javax.servlet.annotation.MultipartConfig; // Cần import này
import javax.servlet.http.Part; // Cần import này
import java.io.File; // Cần import này

import dao.room_typeDAO;
import model.room_type;

@MultipartConfig(
		fileSizeThreshold = 1024 * 1024 * 2, // 2MB
		maxFileSize = 1024 * 1024 * 10,      // 10MB
		maxRequestSize = 1024 * 1024 * 50    // 50MB
	)
public class Room_TypeController extends HttpServlet {

	private static final long serialVersionUID = 1L;

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		resp.setCharacterEncoding("UTF-8");

		String action = req.getParameter("action");

		if ("delete".equals(action)) {
			delete(req, resp);
			return;
		}

		// mặc định GET = list tất cả
		ArrayList<room_type> list = room_typeDAO.getIns().selectAll();
		req.setAttribute("list_room_type_all", list);
		req.getRequestDispatcher("/admin/roomtype_management.jsp").forward(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		resp.setCharacterEncoding("UTF-8");

		String action = req.getParameter("action");

		if ("add".equals(action)) {
			add(req, resp);
		} else if ("edit".equals(action)) {
			edit(req, resp);
		}
	}

	private void add(HttpServletRequest req, HttpServletResponse resp) throws IOException {
		room_type rt = new room_type();

		rt.setRt_name(req.getParameter("rt_name"));
		rt.setRt_description(req.getParameter("rt_description"));
		rt.setRt_price(new BigDecimal(req.getParameter("rt_price")));
		rt.setRt_max_people(Integer.parseInt(req.getParameter("rt_max_people")));
		rt.setRt_area(Integer.parseInt(req.getParameter("rt_area")));
		rt.setRt_special(req.getParameter("rt_special"));
		
		String newImgUrl = req.getParameter("current_img_url"); // Mặc định là URL cũ
		try {
			Part filePart = req.getPart("rt_new_img_file"); // Tên trường file từ JSP
			
			if (filePart != null && filePart.getSize() > 0) {
				String fileName = filePart.getSubmittedFileName();
				
				// Lấy đường dẫn tuyệt đối của thư mục uploads
				String uploadPath = getServletContext().getRealPath("") + File.separator + "newuploads";
				File uploadDir = new File(uploadPath);
				if (!uploadDir.exists()) {
					uploadDir.mkdir();
				}
				
				// Tạo tên file duy nhất (nên thêm timestamp hoặc UUID)
				String uniqueFileName = System.currentTimeMillis() + "_" + fileName;
				String filePath = uploadPath + File.separator + uniqueFileName;
				
				// Lưu file
				filePart.write(filePath);
				
				// Cập nhật URL mới (đường dẫn tương đối)
				newImgUrl = req.getContextPath() + "/newuploads/" + uniqueFileName; 
			}
		} catch (Exception e) {
			// Xử lý lỗi khi upload file
			e.printStackTrace();
			resp.sendRedirect(req.getContextPath() + "/room_type?message=uploadfail");
			return;
		}
		
		// 3. Cập nhật URL ảnh mới
		rt.setRt_img_url(newImgUrl);
		
		

		int kq = room_typeDAO.getIns().insert(rt);

		resp.sendRedirect(req.getContextPath() + "/room_type?message=" + (kq > 0 ? "success" : "fail"));
	}

	private void edit(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException { // THÊM ServletException
		int rt_id = 0;
		try {
			rt_id = Integer.parseInt(req.getParameter("rt_id"));
		} catch (NumberFormatException e) {
			resp.sendRedirect(req.getContextPath() + "/room_type?message=invalidid");
			return;
		}
		
		room_type rt = room_typeDAO.getIns().selectById(rt_id);

		if (rt == null) {
			resp.sendRedirect(req.getContextPath() + "/room_type?message=notfound");
			return;
		}

		// 1. Lấy tất cả các trường dữ liệu text
		rt.setRt_name(req.getParameter("rt_name"));
		rt.setRt_description(req.getParameter("rt_description"));
		
		try {
			rt.setRt_price(new BigDecimal(req.getParameter("rt_price")));
			rt.setRt_max_people(Integer.parseInt(req.getParameter("rt_max_people")));
			rt.setRt_area(Integer.parseInt(req.getParameter("rt_area")));
		} catch (NumberFormatException e) {
			// Xử lý lỗi nhập liệu không hợp lệ
			resp.sendRedirect(req.getContextPath() + "/room_type?message=invaliddata");
			return;
		}
		
		rt.setRt_special(req.getParameter("rt_special"));
		
		// 2. Xử lý File Upload
		String newImgUrl = req.getParameter("current_img_url"); // Mặc định là URL cũ

		try {
			Part filePart = req.getPart("rt_new_img_file"); // Tên trường file từ JSP
			
			if (filePart != null && filePart.getSize() > 0) {
				String fileName = filePart.getSubmittedFileName();
				
				// Lấy đường dẫn tuyệt đối của thư mục uploads
				String uploadPath = getServletContext().getRealPath("") + File.separator + "uploads";
				File uploadDir = new File(uploadPath);
				if (!uploadDir.exists()) {
					uploadDir.mkdir();
				}
				
				// Tạo tên file duy nhất (nên thêm timestamp hoặc UUID)
				String uniqueFileName = System.currentTimeMillis() + "_" + fileName;
				String filePath = uploadPath + File.separator + uniqueFileName;
				
				// Lưu file
				filePart.write(filePath);
				
				// Cập nhật URL mới (đường dẫn tương đối)
				newImgUrl = req.getContextPath() + "/uploads/" + uniqueFileName; 
			}
		} catch (Exception e) {
			// Xử lý lỗi khi upload file
			e.printStackTrace();
			resp.sendRedirect(req.getContextPath() + "/room_type?message=uploadfail");
			return;
		}
		
		// 3. Cập nhật URL ảnh mới
		rt.setRt_img_url(newImgUrl);

		int kq = room_typeDAO.getIns().update(rt);

		resp.sendRedirect(req.getContextPath() + "/room_type?message=" + (kq > 0 ? "success" : "fail"));
	}

    


	private void delete(HttpServletRequest req, HttpServletResponse resp) throws IOException {
		String raw = req.getParameter("rt_id"); 
	
        // SỬA LẠI: Kiểm tra cả null VÀ chuỗi rỗng
		if (raw == null || raw.trim().isEmpty()) {
			resp.sendRedirect(req.getContextPath() + "/room_type?message=missing_id");
			return;
		}
	
		try {
			int id = Integer.parseInt(raw); // Đặt trong try-catch
			room_type rt = new room_type();
			rt.setRt_id(id);
	
			int kq = room_typeDAO.getIns().delete(rt);
	
			resp.sendRedirect(req.getContextPath() + "/room_type?message=" + (kq > 0 ? "success" : "fail"));
			
		} catch (NumberFormatException e) {
            // Xử lý nếu ai đó cố tình gửi ID không phải là số (ví dụ: ?rt_id=abc)
			resp.sendRedirect(req.getContextPath() + "/room_type?message=invalid_id");
		}
	}
}
