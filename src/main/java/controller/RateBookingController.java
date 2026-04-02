package controller;

import java.io.IOException;
import java.sql.Timestamp;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

// Import các DAO và Model cần thiết
import dao.bookingDAO;
import dao.roomDAO;
import dao.room_ratingDAO;
import dao.room_typeDAO;
import model.booking;
import model.room;
import model.room_rating;
import model.room_type;

// Annotation chung cho cả hai hành động
@WebServlet("/rate-booking")
public class RateBookingController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    // Giả định: Sử dụng ID trạng thái booking cho "Đã đánh giá" là 7
    private static final int RATED_BOOKING_STATUS_ID = 7;

    // --- 1. XỬ LÝ GET (HIỂN THỊ TRANG ĐÁNH GIÁ) ---
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");

        try {
            // Lấy bookingId từ request (ví dụ: /review?id=123)
            String idParam = req.getParameter("id");
            if (idParam == null) {
                resp.sendRedirect(req.getContextPath() + "/my-bookings?error=missing_id");
                return;
            }
            int bookingId = Integer.parseInt(idParam);

            // Lấy thông tin từ DAO
            booking bookingToRate = bookingDAO.getIns().selectById(bookingId);
            
            if (bookingToRate == null) {
                resp.sendRedirect(req.getContextPath() + "/my-bookings?error=notfound");
                return;
            }

            room roomToRate = roomDAO.getIns().selectById(bookingToRate.getRoom_id());
            room_type roomType = room_typeDAO.getIns().selectById(roomToRate.getRt_id());

            // Đặt các đối tượng vào request scope
            req.setAttribute("booking", bookingToRate);
            req.setAttribute("room", roomToRate);
            req.setAttribute("roomType", roomType);

            // Chuyển tiếp đến trang JSP (Đảm bảo tên file JSP đúng: rate-booking.jsp)
            req.getRequestDispatcher("/customer/rating.jsp").forward(req, resp);

        } catch (NumberFormatException e) {
            System.err.println("Lỗi ReviewController (GET): ID không hợp lệ.");
            resp.sendRedirect(req.getContextPath() + "/my-bookings?error=invalid_id");
        } catch (Exception e) {
            System.err.println("Lỗi ReviewController (GET): " + e.getMessage());
            e.printStackTrace();
            resp.sendRedirect(req.getContextPath() + "/my-bookings?error=server_error_get");
        }
    }

    // --- 2. XỬ LÝ POST (GỬI ĐÁNH GIÁ) ---
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");

        try {
            // Lấy dữ liệu từ form
            int bookingId = Integer.parseInt(req.getParameter("bookingId"));
            int ratingStars = Integer.parseInt(req.getParameter("rating"));
            String reviewContent = req.getParameter("reviewContent");
            
            boolean isAnonymous = (req.getParameter("isAnonymous") != null);

            // Tạo đối tượng room_rating
            room_rating newRating = new room_rating();
            newRating.setBooking_id(bookingId);
            newRating.setRate_star(ratingStars);
            newRating.setRate_description(reviewContent);
            newRating.setRate_time(new Timestamp(System.currentTimeMillis()));
            newRating.setRate_type(isAnonymous ? 1 : 0); // 1 = Ẩn danh, 0 = Công khai

            // Lưu đánh giá vào CSDL
            room_ratingDAO ratingDao = room_ratingDAO.getIns();
            int result = ratingDao.insert(newRating);

            if (result > 0) {
                // Cập nhật trạng thái của booking thành "Đã đánh giá"
                bookingDAO bookingDao = bookingDAO.getIns();
                bookingDao.updateBookingStatus(bookingId, RATED_BOOKING_STATUS_ID); 

                // Chuyển hướng thành công
                resp.sendRedirect(req.getContextPath() + "/my-bookings?rate=success");
            } else {
                // Lỗi khi insert
                resp.sendRedirect(req.getContextPath() + "/my-bookings?rate=error&msg=insert_failed");
            }

        } catch (NumberFormatException e) {
            System.err.println("Lỗi ReviewController (POST): Dữ liệu ID/Rating không hợp lệ.");
            resp.sendRedirect(req.getContextPath() + "/my-bookings?rate=error&msg=invalid_data");
        } catch (Exception e) {
            System.err.println("Lỗi ReviewController (POST): " + e.getMessage());
            e.printStackTrace();
            resp.sendRedirect(req.getContextPath() + "/my-bookings?rate=error&msg=server_error_post");
        }
    }
}