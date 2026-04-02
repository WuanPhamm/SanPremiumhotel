package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import model.unavailable_date;
import util.ConnectionPoolImpl; // Giả sử ConnectionPoolImpl ở package util

public class unavailable_dateDAO implements daoInterface<unavailable_date> {

    // Không cần constructor và không cần biến 'con' ở đây
    // khi sử dụng connection pool đúng cách.

    public static unavailable_dateDAO getIns() {
        return new unavailable_dateDAO();
    }

    @Override
    public int insert(unavailable_date t) {
        int kq = 0;
        Connection con = null;
        String sql = "INSERT INTO unavailable_date(ud_start, ud_end, room_id, booking_id) VALUES (?, ?, ?,?)";
        
        try {
            // Lấy kết nối từ pool
            con = ConnectionPoolImpl.getInstance().getConnection("unavailable_date");
            PreparedStatement ps = con.prepareStatement(sql);
            
            ps.setDate(1, t.getUd_start()); // Dùng setDate vì model dùng java.sql.Date
            ps.setDate(2, t.getUd_end());
            ps.setInt(3, t.getRoom_id());
            ps.setInt(4, t.getBooking_id());
            kq = ps.executeUpdate();
            
        } catch (Exception e) {
            System.out.println("insert " + e);
            e.printStackTrace();
        } finally {
            // Trả kết nối về pool
            try {
                if (con != null) {
                    ConnectionPoolImpl.getInstance().releaseConnection(con, "unavailable_date");
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return kq;
    }

    @Override
    public int update(unavailable_date t) {
        int kq = 0;
        Connection con = null;
        String sql = "UPDATE unavailable_date SET ud_start = ?, ud_end = ?, room_id = ?, booking_id=? WHERE ud_id = ?";
        
        try {
            con = ConnectionPoolImpl.getInstance().getConnection("unavailable_date");
            PreparedStatement ps = con.prepareStatement(sql);
            
            ps.setDate(1, t.getUd_start());
            ps.setDate(2, t.getUd_end());
            ps.setInt(3, t.getRoom_id());
            ps.setInt(4, t.getBooking_id());
            ps.setInt(5, t.getUd_id());
            
            kq = ps.executeUpdate();
            
        } catch (Exception e) {
            System.out.println("update " + e);
            e.printStackTrace();
        } finally {
            try {
                if (con != null) {
                    ConnectionPoolImpl.getInstance().releaseConnection(con, "unavailable_date");
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return kq;
    }

    @Override
    public int delete(unavailable_date t) {
        int kq = 0;
        Connection con = null;
        String sql = "DELETE FROM unavailable_date WHERE ud_id = ?";
        
        try {
            con = ConnectionPoolImpl.getInstance().getConnection("unavailable_date");
            PreparedStatement ps = con.prepareStatement(sql);
            
            ps.setInt(1, t.getUd_id());
            
            kq = ps.executeUpdate();
            
        } catch (Exception e) {
            System.out.println("delete " + e);
            e.printStackTrace();
        } finally {
            try {
                if (con != null) {
                    ConnectionPoolImpl.getInstance().releaseConnection(con, "unavailable_date");
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return kq;
    }

    @Override
    public ArrayList<unavailable_date> selectAll() {
        ArrayList<unavailable_date> list = new ArrayList<>();
        Connection con = null;
        String sql = "SELECT * FROM unavailable_date";
        
        try {
            con = ConnectionPoolImpl.getInstance().getConnection("unavailable_date");
            PreparedStatement ps = con.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            
            while (rs.next()) {
                unavailable_date u = new unavailable_date();
                u.setUd_id(rs.getInt("ud_id"));
                u.setUd_start(rs.getDate("ud_start")); // Lấy theo tên cột trong model
                u.setUd_end(rs.getDate("ud_end"));
                u.setBooking_id(rs.getInt("booking_id"));
                u.setRoom_id(rs.getInt("room_id"));
                list.add(u);
            }
            
        } catch (Exception e) {
            System.out.println("selectAll " + e);
            e.printStackTrace();
        } finally {
            try {
                if (con != null) {
                    ConnectionPoolImpl.getInstance().releaseConnection(con, "unavailable_date");
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return list;
    }

    @Override
    public unavailable_date selectById(int id) {
        unavailable_date u = null;
        Connection con = null;
        String sql = "SELECT * FROM unavailable_date WHERE ud_id = ?";
        
        try {
            con = ConnectionPoolImpl.getInstance().getConnection("unavailable_date");
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            
            if (rs.next()) {
                u = new unavailable_date();
                u.setUd_id(rs.getInt("ud_id"));
                u.setUd_start(rs.getDate("ud_start"));
                u.setUd_end(rs.getDate("ud_end"));
                u.setBooking_id(rs.getInt("booking_id"));
                u.setRoom_id(rs.getInt("room_id"));
            }
            
        } catch (Exception e) {
            System.out.println("selectById " + e);
            e.printStackTrace();
        } finally {
            try {
                if (con != null) {
                    ConnectionPoolImpl.getInstance().releaseConnection(con, "unavailable_date");
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return u;
    }

    @Override
    public ArrayList<unavailable_date> selectByCondition(String condition) {
        ArrayList<unavailable_date> list = new ArrayList<>();
        Connection con = null;
        // Cẩn thận với SQL Injection khi dùng 'condition'
        String sql = "SELECT * FROM unavailable_date WHERE " + condition; 
        
        try {
            con = ConnectionPoolImpl.getInstance().getConnection("unavailable_date");
            PreparedStatement ps = con.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            
            while (rs.next()) {
                unavailable_date u = new unavailable_date();
                u.setUd_id(rs.getInt("ud_id"));
                u.setUd_start(rs.getDate("ud_start"));
                u.setUd_end(rs.getDate("ud_end"));
                u.setBooking_id(rs.getInt("booking_id"));
                u.setRoom_id(rs.getInt("room_id"));
                list.add(u);
            }
            
        } catch (Exception e) {
            System.out.println("selectByCondition " + e);
            e.printStackTrace();
        } finally {
            try {
                if (con != null) {
                    ConnectionPoolImpl.getInstance().releaseConnection(con, "unavailable_date");
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return list;
    }
    
    public int deleteByRoomId(int roomId) {
        int kq = 0;
        Connection con = null;
        PreparedStatement ps = null; // Khai báo PreparedStatement ở đây
        String sql = "DELETE FROM unavailable_date WHERE room_id = ?";

        try {
            // Lấy kết nối
            con = ConnectionPoolImpl.getInstance().getConnection("unavailable_date");
            ps = con.prepareStatement(sql);
            
            // Thiết lập tham số
            ps.setInt(1, roomId);
            
            // Thực thi
            kq = ps.executeUpdate();
            
        } catch (Exception e) {
            System.out.println("deleteByRoomId " + e);
            e.printStackTrace();
        } finally {
            // Dọn dẹp tài nguyên
            try {
                // Đóng PreparedStatement
                if (ps != null) {
                    ps.close();
                }
                // Trả kết nối về pool
                if (con != null) {
                    ConnectionPoolImpl.getInstance().releaseConnection(con, "unavailable_date");
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return kq;
    }
    
    public int deleteByBookingId(int bookingId) {
        int kq = 0;
        Connection con = null;
        PreparedStatement ps = null; // Khai báo PreparedStatement ở đây
        String sql = "DELETE FROM unavailable_date WHERE booking_id = ?";

        try {
            // Lấy kết nối
            con = ConnectionPoolImpl.getInstance().getConnection("unavailable_date");
            ps = con.prepareStatement(sql);
            
            // Thiết lập tham số
            ps.setInt(1, bookingId);
            
            // Thực thi
            kq = ps.executeUpdate();
            
        } catch (Exception e) {
            System.out.println("deleteByRoomId " + e);
            e.printStackTrace();
        } finally {
            // Dọn dẹp tài nguyên
            try {
                // Đóng PreparedStatement
                if (ps != null) {
                    ps.close();
                }
                // Trả kết nối về pool
                if (con != null) {
                    ConnectionPoolImpl.getInstance().releaseConnection(con, "unavailable_date");
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return kq;
    }
}