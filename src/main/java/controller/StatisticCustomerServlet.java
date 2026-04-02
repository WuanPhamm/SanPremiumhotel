package controller;

import java.io.IOException;
import java.sql.Date;
import java.time.LocalDate;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.customerDAO;
import model.CustomerStatisticDTO;

@WebServlet("/customer_report")
public class StatisticCustomerServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        customerDAO dao = new customerDAO();

        String startStr = request.getParameter("startDate");
        String endStr = request.getParameter("endDate");

        Date startDate;
        Date endDate;

        if (startStr != null && !startStr.isEmpty() && endStr != null && !endStr.isEmpty()) {
            // Nếu người dùng đã chọn ngày
            startDate = Date.valueOf(startStr);
            endDate = Date.valueOf(endStr);
        } else {
            // Mặc định: Lấy dữ liệu 30 ngày gần nhất
            LocalDate now = LocalDate.now();
            LocalDate start = now.minusDays(30); 
            
            startDate = Date.valueOf(start);
            endDate = Date.valueOf(now);
        }

        // 2. Gọi DAO với tham số ngày
        // Lưu ý: Đảm bảo bạn đã cập nhật DAO nhận tham số Date như bước 1
        ArrayList<CustomerStatisticDTO> topRevenue = dao.getTopCustomerByRevenue(5, startDate, endDate);
        ArrayList<CustomerStatisticDTO> topBooking = dao.getTopCustomerByBookingCount(5, startDate, endDate);

        // 3. Đẩy dữ liệu ra JSP
        request.setAttribute("topRevenueList", topRevenue);
        request.setAttribute("topBookingList", topBooking);
        
        // Đẩy lại ngày để hiển thị trên ô input của form
        request.setAttribute("startDate", startDate);
        request.setAttribute("endDate", endDate);
        request.getRequestDispatcher("/admin/customer_statistic.jsp").forward(request, response);
    }
}