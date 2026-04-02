package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import model.withdrawal_bill;
import util.ConnectionPoolImpl;

public class withdrawal_billDAO {

    private static withdrawal_billDAO instance;

    public static withdrawal_billDAO getInstance() {
        if (instance == null) {
            instance = new withdrawal_billDAO();
        }
        return instance;
    }

    
 // Thêm yêu cầu rút tiền mới (Khách hàng thực hiện)
    public int insert(withdrawal_bill t) {
        int kq = 0;
        Connection con = null;
        try {
            con = ConnectionPoolImpl.getInstance().getConnection("wallet");
            String sql = "INSERT INTO withdrawal_bill (cw_id, withdrawal_amount, bank_name, bank_id, wdb_status) VALUES (?, ?, ?, ?, ?)";
            PreparedStatement ps = con.prepareStatement(sql);
            
            ps.setInt(1, t.getCw_id());
            ps.setBigDecimal(2, t.getWithdrawal_amount());
            ps.setString(3, t.getBank_name());
            ps.setString(4, t.getBank_id());
            ps.setInt(5, 0); // Mặc định là 0: Chờ xử lý khi mới tạo phiếu
            
            kq = ps.executeUpdate();
        } catch (Exception e) {
            System.out.println("Lỗi insert withdrawal_bill: " + e.getMessage());
        } finally {
            if (con != null) {
                try {
                    ConnectionPoolImpl.getInstance().releaseConnection(con, "wallet");
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }
        return kq;
    }
    // Lấy danh sách tất cả yêu cầu rút tiền (Có hỗ trợ lọc)
    public List<withdrawal_bill> getAllBills(String filterStatus) {
        List<withdrawal_bill> list = new ArrayList<>();
        Connection con = null;
        try {
            con = ConnectionPoolImpl.getInstance().getConnection("wallet");
            
            // Xây dựng câu truy vấn
            String sql = "SELECT * FROM withdrawal_bill ";
            if (filterStatus != null && !filterStatus.equals("all")) {
                sql += " WHERE wdb_status = ? ";
            }
            sql += " ORDER BY wdb_id DESC"; // Đưa yêu cầu mới nhất lên đầu

            PreparedStatement ps = con.prepareStatement(sql);
            if (filterStatus != null && !filterStatus.equals("all")) {
                ps.setInt(1, Integer.parseInt(filterStatus));
            }

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                withdrawal_bill bill = new withdrawal_bill(
                    rs.getInt("wdb_id"),
                    rs.getInt("cw_id"),
                    rs.getBigDecimal("withdrawal_amount"),
                    rs.getString("bank_name"),
                    rs.getString("bank_id"),
                    rs.getInt("wdb_status")
                );
                list.add(bill);
            }
        } catch (Exception e) {
            System.out.println("Lỗi getAllBills: " + e.getMessage());
        } finally {
            if (con != null) {
                try { ConnectionPoolImpl.getInstance().releaseConnection(con, "wallet"); } 
                catch (SQLException e) { e.printStackTrace(); }
            }
        }
        return list;
    }

    // Admin xác nhận đã chuyển khoản cho khách (Đổi status -> 1)
    public boolean confirmPayment(int wdb_id) {
        Connection con = null;
        boolean isSuccess = false;
        try {
            con = ConnectionPoolImpl.getInstance().getConnection("wallet");
            // Chỉ cho phép cập nhật nếu trạng thái đang là 0 (Chờ xử lý)
            String sql = "UPDATE withdrawal_bill SET wdb_status = 1 WHERE wdb_id = ? AND wdb_status = 0";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, wdb_id);
            
            int rows = ps.executeUpdate();
            isSuccess = rows > 0;
            
        } catch (Exception e) {
            System.out.println("Lỗi confirmPayment: " + e.getMessage());
        } finally {
            if (con != null) {
                try { ConnectionPoolImpl.getInstance().releaseConnection(con, "wallet"); } 
                catch (SQLException e) { e.printStackTrace(); }
            }
        }
        return isSuccess;
    }
    
 // Tìm một phiếu rút tiền dựa trên ID
    public withdrawal_bill findById(int wdb_id) {
        withdrawal_bill bill = null;
        Connection con = null;
        try {
            con = ConnectionPoolImpl.getInstance().getConnection("wallet");
            String sql = "SELECT * FROM withdrawal_bill WHERE wdb_id = ?";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, wdb_id);
            
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                bill = new withdrawal_bill(
                    rs.getInt("wdb_id"),
                    rs.getInt("cw_id"),
                    rs.getBigDecimal("withdrawal_amount"),
                    rs.getString("bank_name"),
                    rs.getString("bank_id"),
                    rs.getInt("wdb_status")
                );
            }
        } catch (Exception e) {
            System.out.println("Lỗi findById withdrawal_bill: " + e.getMessage());
        } finally {
            if (con != null) {
                try {
                    ConnectionPoolImpl.getInstance().releaseConnection(con, "wallet");
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }
        return bill;
    }
}