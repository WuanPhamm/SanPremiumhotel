package controller;

import java.io.IOException;
import java.sql.Date;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.RoomtypeStatisticalDAO;
import model.RoomTypeStat;

@WebServlet("/rt_report")
public class RoomTypeStatistical extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        
        RoomtypeStatisticalDAO dao = new RoomtypeStatisticalDAO();
        
        // 1. Nhận tham số từ form
        String fromStr = request.getParameter("from");
        String toStr = request.getParameter("to");
        
        Date fromDate = null;
        Date toDate = null;

        // 2. Chuyển đổi String sang sql.Date
        try {
            if (fromStr != null && !fromStr.isEmpty()) {
                fromDate = Date.valueOf(fromStr);
            }
            if (toStr != null && !toStr.isEmpty()) {
                toDate = Date.valueOf(toStr);
            }
        } catch (IllegalArgumentException e) {
            System.out.println("Lỗi định dạng ngày: " + e.getMessage());
        }

        // 3. Gọi DAO với tham số ngày
        ArrayList<RoomTypeStat> listStats = dao.getTopBookedRoomTypes(fromDate, toDate);
        
        // 4. Đẩy dữ liệu sang JSP
        request.setAttribute("list_stats", listStats);
        
        // 5. Lưu lại giá trị ngày để hiển thị lại trên input (giữ trạng thái form)
        request.setAttribute("fromDate", fromStr);
        request.setAttribute("toDate", toStr);
        
        request.getRequestDispatcher("/admin/roomtype_report.jsp").forward(request, response);
    }
    
    // Nếu form gửi method POST thì gọi sang doGet để xử lý chung
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}