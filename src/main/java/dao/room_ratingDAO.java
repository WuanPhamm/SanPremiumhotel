package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import model.room_rating;
import util.ConnectionPoolImpl; // Giả sử import đúng

public class room_ratingDAO implements daoInterface<room_rating> {

    private Connection con;

    /**
     * Constructor lấy connection từ pool
     */
    public room_ratingDAO() {
        try {
            // Lấy connection, giả sử tên pool là "room_rating"
            this.con = ConnectionPoolImpl.getInstance().getConnection("room_rating");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    /**
     * Phương thức factory, trả về một instance MỚI (giống hệt bookingDAO)
     */
    public static room_ratingDAO getIns() {
        return new room_ratingDAO();
    }

    /**
     * Giải phóng connection về pool
     */
    private void releaseConnection() {
        try {
            ConnectionPoolImpl.getInstance().releaseConnection(this.con, "room_rating");
        } catch (SQLException e) {
            System.err.println("Lỗi khi giải phóng connection (room_ratingDAO): " + e.getMessage());
            e.printStackTrace();
        }
    }

    @Override
    public int insert(room_rating t) {
        int kq = 0;
        String sql = "INSERT INTO room_rating (rate_star, rate_description, booking_id, rate_type, rate_time) "
                + "VALUES (?, ?, ?, ?, ?)";
        try {
            // Yêu cầu trả về khóa tự động tạo
            PreparedStatement ps = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            
            ps.setInt(1, t.getRate_star());
            ps.setString(2, t.getRate_description());
            ps.setInt(3, t.getBooking_id());
            ps.setInt(4, t.getRate_type());
            ps.setTimestamp(5, t.getRate_time());

            kq = ps.executeUpdate();
            
            // Lấy ID vừa được sinh ra và gán lại vào đối tượng
            if (kq > 0) {
                try (ResultSet generatedKeys = ps.getGeneratedKeys()) {
                    if (generatedKeys.next()) {
                        t.setRate_id(generatedKeys.getInt(1)); // Sử dụng setter (từ Lombok @Data)
                    }
                }
            }
            
        } catch (Exception e) {
            System.out.println("insert room_rating: " + e.getMessage());
        } finally {
            releaseConnection(); // Luôn giải phóng connection
        }
        return kq;
    }

    @Override
    public int update(room_rating t) {
        int kq = 0;
        String sql = "UPDATE room_rating SET rate_star = ?, rate_description = ?, booking_id = ?, "
                + "rate_type = ?, rate_time = ? WHERE rate_id = ?";
        try {
            PreparedStatement ps = con.prepareStatement(sql);
            
            ps.setInt(1, t.getRate_star());
            ps.setString(2, t.getRate_description());
            ps.setInt(3, t.getBooking_id());
            ps.setInt(4, t.getRate_type());
            ps.setTimestamp(5, t.getRate_time());
            ps.setInt(6, t.getRate_id()); // Mệnh đề WHERE

            kq = ps.executeUpdate();
        } catch (Exception e) {
            System.out.println("update room_rating: " + e.getMessage());
        } finally {
            releaseConnection();
        }
        return kq;
    }

    @Override
    public int delete(room_rating t) {
        int kq = 0;
        String sql = "DELETE FROM room_rating WHERE rate_id = ?";
        try {
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, t.getRate_id());
            kq = ps.executeUpdate();
        } catch (Exception e) {
            System.out.println("delete room_rating: " + e.getMessage());
        } finally {
            releaseConnection();
        }
        return kq;
    }

    @Override
    public ArrayList<room_rating> selectAll() {
        ArrayList<room_rating> list = new ArrayList<>();
        String sql = "SELECT * FROM room_rating ORDER BY rate_time DESC";
        try {
            PreparedStatement ps = con.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                room_rating r = new room_rating(
                        rs.getInt("rate_id"),
                        rs.getInt("rate_star"),
                        rs.getString("rate_description"),
                        rs.getInt("booking_id"),
                        rs.getInt("rate_type"),
                        rs.getTimestamp("rate_time")
                );
                list.add(r);
            }
        } catch (Exception e) {
            System.out.println("selectAll room_rating: " + e.getMessage());
        } finally {
            releaseConnection();
        }
        return list;
    }

    @Override
    public room_rating selectById(int id) {
        room_rating r = null;
        String sql = "SELECT * FROM room_rating WHERE rate_id = ?";
        try {
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                r = new room_rating(
                        rs.getInt("rate_id"),
                        rs.getInt("rate_star"),
                        rs.getString("rate_description"),
                        rs.getInt("booking_id"),
                        rs.getInt("rate_type"),
                        rs.getTimestamp("rate_time")
                );
            }
        } catch (Exception e) {
            System.out.println("selectById room_rating: " + e.getMessage());
        } finally {
            releaseConnection();
        }
        return r;
    }

    @Override
    public ArrayList<room_rating> selectByCondition(String condition) {
        ArrayList<room_rating> list = new ArrayList<>();
        // Cảnh báo: Dễ bị SQL Injection nếu 'condition' đến từ người dùng
        String sql = "SELECT * FROM room_rating WHERE " + condition;
        try {
            PreparedStatement ps = con.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                room_rating r = new room_rating(
                        rs.getInt("rate_id"),
                        rs.getInt("rate_star"),
                        rs.getString("rate_description"),
                        rs.getInt("booking_id"),
                        rs.getInt("rate_type"),
                        rs.getTimestamp("rate_time")
                );
                list.add(r);
            }
        } catch (Exception e) {
            System.out.println("selectByCondition room_rating: " + e.getMessage());
        } finally {
            releaseConnection();
        }
        return list;
    }
    
    
    public room_rating selectByBookingId(int id) {
        room_rating r = null;
        String sql = "SELECT * FROM room_rating WHERE booking_id = ?";
        try {
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                r = new room_rating(
                        rs.getInt("rate_id"),
                        rs.getInt("rate_star"),
                        rs.getString("rate_description"),
                        rs.getInt("booking_id"),
                        rs.getInt("rate_type"),
                        rs.getTimestamp("rate_time")
                );
            }
        } catch (Exception e) {
            System.out.println("selectById room_rating: " + e.getMessage());
        } finally {
            releaseConnection();
        }
        return r;
    }
    
    
    public double getAverageRating() {
        double avg = 0;
        String sql = "SELECT AVG(rate_star) FROM room_rating";
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            ps = con.prepareStatement(sql);
            rs = ps.executeQuery();

            if (rs.next()) {
                avg = rs.getDouble(1); // Lấy giá trị trung bình
            }

        } catch (Exception e) {
            System.out.println("avg " + e);
        } finally {
            try {
                if (rs != null) rs.close();
                if (ps != null) ps.close();
                ConnectionPoolImpl.getInstance().releaseConnection(this.con, "room_rating");
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }

        return avg;
    }
    public int countRatingStar3Up() {
        int count = 0;
        String sql = "SELECT COUNT(*) FROM room_rating WHERE rate_star >= 3";
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            ps = con.prepareStatement(sql);
            rs = ps.executeQuery();

            if (rs.next()) {
                count = rs.getInt(1);
            }

        } catch (Exception e) {
            System.out.println("countRatingStar3Up " + e);
        } finally {
            try {
                if (rs != null) rs.close();
                if (ps != null) ps.close();
                ConnectionPoolImpl.getInstance().releaseConnection(this.con, "room_rating");
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }

        return count;
    }


}