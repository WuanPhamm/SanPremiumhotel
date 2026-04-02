package dao;

import java.sql.Connection;
import java.sql.Date; // Lưu ý import này
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import model.RoomTypeStat;
import util.ConnectionPoolImpl;

public class RoomtypeStatisticalDAO {
    
    private Connection con;

    public RoomtypeStatisticalDAO() {
        try {
            this.con = ConnectionPoolImpl.getInstance().getConnection("statistical");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    /**
     * Lấy thống kê có hỗ trợ lọc theo ngày
     * @param fromDate Ngày bắt đầu (có thể null)
     * @param toDate Ngày kết thúc (có thể null)
     */
    public ArrayList<RoomTypeStat> getTopBookedRoomTypes(Date fromDate, Date toDate) {
        ArrayList<RoomTypeStat> list = new ArrayList<>();
        StringBuilder sql = new StringBuilder();
        
        // Khởi tạo câu SQL cơ bản
        sql.append("SELECT rt.rt_name, COUNT(b.booking_id) as total_qty, SUM(b.booking_total) as total_rev ");
        sql.append("FROM booking b ");
        sql.append("JOIN room r ON b.room_id = r.room_id ");
        sql.append("JOIN room_type rt ON r.rt_id = rt.rt_id ");
        sql.append("WHERE 1=1 "); // Mẹo để dễ dàng nối thêm AND

        // Nếu có ngày bắt đầu
        if (fromDate != null) {
            sql.append("AND DATE(b.booking_time) >= ? ");
        }
        // Nếu có ngày kết thúc
        if (toDate != null) {
            sql.append("AND DATE(b.booking_time) <= ? ");
        }

        sql.append("GROUP BY rt.rt_name ");
        sql.append("ORDER BY total_qty DESC ");
        sql.append("LIMIT 10");

        try {
            PreparedStatement ps = con.prepareStatement(sql.toString());
            
            // Thiết lập tham số cho PreparedStatement
            int index = 1;
            if (fromDate != null) {
                ps.setDate(index++, fromDate);
            }
            if (toDate != null) {
                ps.setDate(index++, toDate);
            }

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                RoomTypeStat stat = new RoomTypeStat();
                stat.setRtName(rs.getString("rt_name"));
                stat.setTotalBookings(rs.getInt("total_qty"));
                stat.setTotalRevenue(rs.getDouble("total_rev"));
                list.add(stat);
            }
        } catch (Exception e) {
            System.out.println("getTopBookedRoomTypes error: " + e);
        } finally {
            try {
                ConnectionPoolImpl.getInstance().releaseConnection(this.con, "statistical");
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return list;
    }
}