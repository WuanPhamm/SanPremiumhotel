package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.math.BigDecimal;

import util.ConnectionPoolImpl;

public class DashboardDAO {

    private Connection con;

    // Constructor: Lấy kết nối từ Pool
    public DashboardDAO() {
        try {
            // Giả sử tên pool là "booking" giống như class mẫu của bạn
            this.con = ConnectionPoolImpl.getInstance().getConnection("booking");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public static DashboardDAO getIns() {
        return new DashboardDAO();
    }

    /**
     * Hàm hỗ trợ tạo điều kiện WHERE theo thời gian
     * @param type: "day" (Hôm nay), "month" (Tháng này), "year" (Năm nay)
     */
    private String getConditionTime(String type) {
        String condition = "";
        if ("day".equals(type)) {
            condition = "DATE(booking_time) = CURDATE()";
        } else if ("month".equals(type)) {
            condition = "MONTH(booking_time) = MONTH(CURDATE()) AND YEAR(booking_time) = YEAR(CURDATE())";
        } else if ("year".equals(type)) {
            condition = "YEAR(booking_time) = YEAR(CURDATE())";
        } else {
            // Mặc định lấy tất cả nếu không khớp type (hoặc xử lý tuỳ ý)
            condition = "1=1"; 
        }
        return condition;
    }

    /**
     * Thống kê số lượng đơn đặt phòng (Booking Count)
     * @param type: "day", "month", "year"
     */
    public int getBookingCount(String type) {
        int count = 0;
        String sql = "SELECT COUNT(*) FROM booking WHERE " + getConditionTime(type);
        
        PreparedStatement ps = null;
        ResultSet rs = null;
        
        try {
            // Kiểm tra kết nối
            if (this.con == null || this.con.isClosed()) {
                this.con = ConnectionPoolImpl.getInstance().getConnection("booking");
            }

            ps = con.prepareStatement(sql);
            rs = ps.executeQuery();

            if (rs.next()) {
                count = rs.getInt(1);
            }
        } catch (Exception e) {
            System.out.println("getBookingCount: " + e.getMessage());
            e.printStackTrace();
        } finally {
            // Đóng resources nhưng GIỮ kết nối nếu bạn muốn dùng tiếp trong cùng 1 request,
            // hoặc đóng luôn tuỳ vào logic Controller của bạn. 
            // Theo mẫu của bạn thì đóng luôn ở đây:
            try {
                if (rs != null) rs.close();
                if (ps != null) ps.close();
                ConnectionPoolImpl.getInstance().releaseConnection(this.con, "booking");
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return count;
    }

    /**
     * Thống kê số lượng khách hàng (Customer Count)
     * Đếm số khách hàng duy nhất (DISTINCT cus_id) đã đặt phòng
     * @param type: "day", "month", "year"
     */
    public int getCustomerCount(String type) {
        int count = 0;
        String sql = "SELECT COUNT(DISTINCT cus_id) FROM booking WHERE " + getConditionTime(type);
        
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            if (this.con == null || this.con.isClosed()) {
                this.con = ConnectionPoolImpl.getInstance().getConnection("booking");
            }
            
            ps = con.prepareStatement(sql);
            rs = ps.executeQuery();

            if (rs.next()) {
                count = rs.getInt(1);
            }
        } catch (Exception e) {
            System.out.println("getCustomerCount: " + e.getMessage());
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) rs.close();
                if (ps != null) ps.close();
                ConnectionPoolImpl.getInstance().releaseConnection(this.con, "booking");
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return count;
    }

    /**
     * Thống kê doanh thu (Revenue)
     * Tính tổng booking_total. 
     * Lưu ý: Thực tế nên thêm điều kiện WHERE bs_id = [Trạng thái thành công]
     * @param type: "day", "month", "year"
     */
    public BigDecimal getRevenue(String type) {
        BigDecimal totalRevenue = BigDecimal.ZERO;
        // Nếu muốn chỉ tính đơn thành công, sửa thành:
        // ... WHERE " + getConditionTime(type) + " AND bs_id = 4 (ví dụ 4 là thành công)
        String sql = "SELECT SUM(booking_total) FROM booking WHERE " + getConditionTime(type)+ " AND bs_id IN (1, 2, 6, 7)";
        
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            if (this.con == null || this.con.isClosed()) {
                this.con = ConnectionPoolImpl.getInstance().getConnection("booking");
            }
            
            ps = con.prepareStatement(sql);
            rs = ps.executeQuery();

            if (rs.next()) {
                BigDecimal result = rs.getBigDecimal(1);
                if (result != null) {
                    totalRevenue = result;
                }
            }
        } catch (Exception e) {
            System.out.println("getRevenue: " + e.getMessage());
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) rs.close();
                if (ps != null) ps.close();
                ConnectionPoolImpl.getInstance().releaseConnection(this.con, "booking");
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return totalRevenue;
    }
}