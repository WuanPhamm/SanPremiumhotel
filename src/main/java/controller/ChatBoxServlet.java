package controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.roomDAO;
import dao.room_typeDAO; // Import DAO mới
import dao.floorDAO;      // Import DAO mới
import model.room;
import model.room_type;
import model.floor;
import util.GeminiService;

@WebServlet("/api/chatbot")
public class ChatBoxServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/plain; charset=UTF-8");

        String userMessage = request.getParameter("message");
        
        // --- 1. LẤY DỮ LIỆU TỪ DATABASE ---
        roomDAO rDao = roomDAO.getIns();
        room_typeDAO rtDao = room_typeDAO.getIns();
        floorDAO fDao = floorDAO.getIns();
        
        ArrayList<room> rooms = rDao.selectAll();
        ArrayList<room_type> roomTypes = rtDao.selectAll();
        ArrayList<floor> floors = fDao.selectAll();

        // --- 2. TẠO CHUỖI NGỮ CẢNH (CONTEXT) CHI TIẾT ---
        StringBuilder dbContext = new StringBuilder();
        
        // Thêm thông tin cơ bản
        dbContext.append("Bạn là trợ lý ảo của khách sạn. Khách sạn ở 36 P. Hà Trung, Hàng Bông, Hà Nội. SĐT: 0383952771. ");
        
        // 2.1. Thông tin Tầng
        dbContext.append("\n\n* THÔNG TIN CÁC TẦNG: ");
        for (floor f : floors) {
            dbContext.append("Tầng ").append(f.getFloor_name())
                     .append(" (").append(f.getFloor_description()).append("); ");
        }
        
        // 2.2. Thông tin Loại phòng
        dbContext.append("\n\n* THÔNG TIN LOẠI PHÒNG: ");
        for (room_type rt : roomTypes) {
            dbContext.append(rt.getRt_name())
                     
                     .append(", Giá: ").append(rt.getRt_price())
                     .append(", Max: ").append(rt.getRt_max_people())
                     .append(" người, Mô tả: ").append(rt.getRt_description())
                     .append("); ");
        }

        // 2.3. Thông tin Phòng cụ thể
        dbContext.append("\n\n* THÔNG TIN PHÒNG CỤ THỂ (room_name - rt_id - rs_id): ");
        for (room r : rooms) {
            String status = (r.getRs_id() == 1) ? "Trống" : ((r.getRs_id() == 2) ? "Đã đặt" : "Đang bảo trì"); // Giả định rs_id
            dbContext.append(r.getRoom_name())
                     .append(" (Tầng: ").append(r.getFloor_id()) 
                     .append(", Loại: ").append(r.getRt_id())
                     .append(", Trạng thái: ").append(status)
                     .append("); ");
        }

        // --- 3. GỌI GEMINI ---
        String aiReply = GeminiService.getResponse(userMessage, dbContext.toString());

        // --- 4. TRẢ VỀ KẾT QUẢ ---
        PrintWriter out = response.getWriter();
        out.print(aiReply);
        out.flush();
    }
}