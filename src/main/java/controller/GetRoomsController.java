package controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import dao.roomDAO;
import model.room;

@WebServlet("/getRooms")
public class GetRoomsController extends HttpServlet {

    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	@Override
    
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("application/json; charset=UTF-8");
        resp.setCharacterEncoding("UTF-8");
        req.setCharacterEncoding("UTF-8");

        System.out.println("--- Bắt đầu xử lý yêu cầu GET cho LogDemoServlet ---");
        String rt_raw = req.getParameter("rt_id");
        String fl_raw = req.getParameter("floor_id");
        System.out.println(rt_raw);
        System.out.println(fl_raw);
        
        int rtId  = (rt_raw  != null && !rt_raw.isEmpty())  ? Integer.parseInt(rt_raw)  : 0;
        int flId  = (fl_raw  != null && !fl_raw.isEmpty())  ? Integer.parseInt(fl_raw)  : 0;

        // nếu thiếu dữ liệu thì trả list rỗng, không văng lỗi
        if (rtId == 0 || flId == 0) {
            resp.getWriter().write("[]");
            return;
        }

        ArrayList<room> rooms = roomDAO.getIns().getAvailableRooms(rtId, flId);
        
        // CHUYỂN ĐỔI SANG DTO
        ArrayList<RoomDTO> roomDTOs = new ArrayList<>();
        for (room r : rooms) {
            roomDTOs.add(new RoomDTO(r.getRoom_id(), r.getRoom_name()));
        }

        String json = new Gson().toJson(roomDTOs);
        resp.getWriter().write(json);
    }
	
	private static class RoomDTO {
	    int id;
	    String name;
	    public RoomDTO(int id, String name) {
	        this.id = id;
	        this.name = name;
	    }
	}

}

