package controller;

import java.io.IOException;
import java.sql.Date;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import dao.roomDAO;
import dao.unavailable_dateDAO;
import model.room;
import model.unavailable_date;

@WebServlet("/getUnavailableDates")
public class GetUnavailableDatesServlet extends HttpServlet {

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
        String r_raw = req.getParameter("room_id");
      
       
        
        int rId  = (r_raw  != null && !r_raw.isEmpty())  ? Integer.parseInt(r_raw)  : 0;
        

        // nếu thiếu dữ liệu thì trả list rỗng, không văng lỗi
        if (rId == 0) {
            resp.getWriter().write("[]");
            return;
        }
        String condition = "room_id="+rId;
        ArrayList<unavailable_date> uds = unavailable_dateDAO.getIns().selectByCondition(condition);
        
        
        // CHUYỂN ĐỔI SANG DTO
        ArrayList<UdDTO> udDTOs = new ArrayList<>();
        for (unavailable_date ud : uds) {
            udDTOs.add(new UdDTO(ud.getUd_id(), ud.getUd_start(), ud.getUd_end()));
        }

        String json = new Gson().toJson(udDTOs);
        resp.getWriter().write(json);
    }
	
	private static class UdDTO {
	    int id;
	    Date startDate;
	    Date endDate;
	    
	    
	    public UdDTO(int id, Date startDate, Date endDate) {
	        this.id = id;
	        this.startDate=startDate;
	        this.endDate=endDate;
	        
	    }
	}

}

