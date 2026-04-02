package controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.room_ratingDAO;
import model.room_rating;

@WebServlet("/ratings")

public class Ad_RatingController extends HttpServlet{	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		resp.setCharacterEncoding("UTF-8");
		resp.setContentType("text/html; charset=UTF-8");
		
		room_ratingDAO dao = new room_ratingDAO();
		ArrayList<room_rating> list = dao.selectAll(); // Lấy tất cả đánh giá
		req.setAttribute("list_rating", list);     // Gửi sang JSP với tên "list_rating"
		req.getRequestDispatcher("admin/rating_management.jsp").forward(req, resp);
	}
	
	@Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // Thiết lập encoding cho request
        request.setCharacterEncoding("UTF-8");
        
        String action = request.getParameter("action");
        String message = "fail"; // Biến lưu trạng thái thao tác

        // Xử lý XÓA ĐÁNH GIÁ
        if ("delete".equals(action)) {
            try {
                // Lấy ID từ form deleteModal
                int rateId = Integer.parseInt(request.getParameter("rate_id"));
                
                // Tạo đối tượng cần xóa (chỉ cần ID)
                room_rating ratingToDelete = new room_rating();
                ratingToDelete.setRate_id(rateId);
                
                room_ratingDAO dao = room_ratingDAO.getIns();
                
                // Thực hiện xóa
                int result = dao.delete(ratingToDelete);
                
                if (result > 0) {
                    message = "success";
                }
                
            } catch (NumberFormatException e) {
                System.err.println("Lỗi định dạng ID khi xóa đánh giá: " + e.getMessage());
            } catch (Exception e) {
                 System.err.println("Lỗi DB khi xóa đánh giá: " + e.getMessage());
            }
        }
        
        // Redirect về trang quản lý với thông báo (message=success hoặc message=fail)
        // Sử dụng request.getContextPath() để đảm bảo URL gốc chính xác
        response.sendRedirect(request.getContextPath() + "/ratings?message=" + message);
    }
}
