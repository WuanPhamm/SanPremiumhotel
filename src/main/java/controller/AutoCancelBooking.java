package controller; // Hoặc package của bạn

import java.io.IOException;
import java.util.Date;
import java.util.List;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;

import dao.bookingDAO;
import dao.unavailable_dateDAO;
import model.booking;
import model.unavailable_date;

/**
 * Filter này tự động kiểm tra và hủy các đơn đặt phòng "Chưa thanh toán" (bs_id = 5)
 * đã tồn tại quá 6 tiếng.
 * Nó chỉ chạy kiểm tra 10 phút một lần để tối ưu hiệu suất.
 */
@WebFilter("/*") // Áp dụng cho tất cả các request
public class AutoCancelBooking implements Filter {

    // Thời gian chờ giữa các lần kiểm tra (10 phút)
    private static final long CHECK_INTERVAL_MS = 10 * 60 * 1000; 
    
    // Thời gian hết hạn của đơn đặt phòng (6 tiếng)
    private static final long EXPIRY_TIME_MS = 6 * 60 * 60 * 1000;
    
    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        // Có thể để trống
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        
        ServletContext context = request.getServletContext();
        
        // Lấy thời điểm kiểm tra cuối cùng từ Application Scope
        Long lastCheck = (Long) context.getAttribute("lastCheckTime");
        long now = System.currentTimeMillis();

        // Chỉ kiểm tra nếu chưa từng kiểm tra, hoặc đã đến lúc kiểm tra (quá 10 phút)
        if (lastCheck == null || (now - lastCheck) > CHECK_INTERVAL_MS) {
            
            // System.out.println("BookingExpiryFilter: Đang chạy kiểm tra..."); // Dùng để debug
            
            // Tính mốc thời gian 6 tiếng trước
            Date expiryTime = new Date(now - EXPIRY_TIME_MS);
            
            // Gọi DAO để cập nhật
            // 5 = Chưa thanh toán, 4 = Đã hủy
            bookingDAO dao = bookingDAO.getIns();
            int cancelledCount = dao.cancelExpiredBookings(5, 4, expiryTime);
            
            if (cancelledCount > 0) {
            	String condition = "bs_id=4";
            	List<booking> bookings=bookingDAO.getIns().selectByCondition(condition);
            	
            	for (booking booking : bookings) {
					unavailable_dateDAO.getIns().deleteByBookingId(booking.getBooking_id());
				}
            	
                 System.out.println("BookingExpiryFilter: Đã tự động hủy " + cancelledCount + " đơn đặt phòng quá hạn.");
            }

            // Cập nhật lại thời điểm kiểm tra cuối cùng
            context.setAttribute("lastCheckTime", now);
        }

        // Cho phép request tiếp tục đi đến Servlet/JSP
        chain.doFilter(request, response);
    }

    @Override
    public void destroy() {
        // Có thể để trống
    }
}