package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.cus_wallet;
import util.ConnectionPoolImpl;

public class cus_walletDAO {

    private static cus_walletDAO instance;

    public static cus_walletDAO getInstance() {
        if (instance == null) {
            instance = new cus_walletDAO();
        }
        return instance;
    }

    // 1. Lấy thông tin ví theo acc_id (Đã có của bạn)
    public cus_wallet getWalletByAccountId(int acc_id) {
        cus_wallet wallet = null;
        Connection con = null;
        try {
            con = ConnectionPoolImpl.getInstance().getConnection("wallet");
            String sql = "SELECT * FROM cus_wallet WHERE acc_id = ? AND cw_status = 0"; 
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, acc_id);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                wallet = new cus_wallet(
                    rs.getInt("cw_id"),
                    rs.getInt("acc_id"),
                    rs.getBigDecimal("balance"),
                    rs.getInt("cw_status")
                );
            }
        } catch (Exception e) {
            System.out.println("Lỗi getWalletByAccountId: " + e.getMessage());
        } finally {
            release(con);
        }
        return wallet;
    }

    // 2. Thêm ví mới (Dùng khi khách hàng đăng ký tài khoản thành công)
    public int insert(cus_wallet t) {
        int kq = 0;
        Connection con = null;
        try {
            con = ConnectionPoolImpl.getInstance().getConnection("wallet");
            String sql = "INSERT INTO cus_wallet (acc_id, balance, cw_status) VALUES (?, ?, ?)";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, t.getAcc_id());
            ps.setBigDecimal(2, t.getBalance());
            ps.setInt(3, t.getCw_status());
            
            kq = ps.executeUpdate();
        } catch (Exception e) {
            System.out.println("Lỗi insert wallet: " + e.getMessage());
        } finally {
            release(con);
        }
        return kq;
    }

    // 3. Cập nhật thông tin ví (Dùng để thay đổi số dư hoặc thông tin chung)
    public int update(cus_wallet t) {
        int kq = 0;
        Connection con = null;
        try {
            con = ConnectionPoolImpl.getInstance().getConnection("wallet");
            String sql = "UPDATE cus_wallet SET balance = ?, cw_status = ? WHERE cw_id = ?";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setBigDecimal(1, t.getBalance());
            ps.setInt(2, t.getCw_status());
            ps.setInt(3, t.getCw_id());
            
            kq = ps.executeUpdate();
        } catch (Exception e) {
            System.out.println("Lỗi update wallet: " + e.getMessage());
        } finally {
            release(con);
        }
        return kq;
    }

    // 4. Xóa ví (Thường ít dùng, chủ yếu là update trạng thái)
    public int delete(int cw_id) {
        int kq = 0;
        Connection con = null;
        try {
            con = ConnectionPoolImpl.getInstance().getConnection("wallet");
            String sql = "DELETE FROM cus_wallet WHERE cw_id = ?";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, cw_id);
            
            kq = ps.executeUpdate();
        } catch (Exception e) {
            System.out.println("Lỗi delete wallet: " + e.getMessage());
        } finally {
            release(con);
        }
        return kq;
    }

    // 5. Cập nhật trạng thái ví (Ví dụ: Khóa ví status = 1, Mở ví status = 0)
    public int updateStatus(int cw_id, int newStatus) {
        int kq = 0;
        Connection con = null;
        try {
            con = ConnectionPoolImpl.getInstance().getConnection("wallet");
            String sql = "UPDATE cus_wallet SET cw_status = ? WHERE cw_id = ?";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, newStatus);
            ps.setInt(2, cw_id);
            
            kq = ps.executeUpdate();
        } catch (Exception e) {
            System.out.println("Lỗi updateStatus wallet: " + e.getMessage());
        } finally {
            release(con);
        }
        return kq;
    }
    
    // 6. Lấy tất cả danh sách ví (Cho Admin quản lý)
    public List<cus_wallet> selectAll() {
        List<cus_wallet> list = new ArrayList<>();
        Connection con = null;
        try {
            con = ConnectionPoolImpl.getInstance().getConnection("wallet");
            String sql = "SELECT * FROM cus_wallet";
            PreparedStatement ps = con.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new cus_wallet(
                    rs.getInt("cw_id"),
                    rs.getInt("acc_id"),
                    rs.getBigDecimal("balance"),
                    rs.getInt("cw_status")
                ));
            }
        } catch (Exception e) {
            System.out.println("Lỗi selectAll wallet: " + e.getMessage());
        } finally {
            release(con);
        }
        return list;
    }
    
 // 7. Tìm kiếm ví theo ID ví (cw_id)
    public cus_wallet findById(int cw_id) {
        cus_wallet wallet = null;
        Connection con = null;
        try {
            con = ConnectionPoolImpl.getInstance().getConnection("wallet");
            String sql = "SELECT * FROM cus_wallet WHERE cw_id = ?";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, cw_id);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                wallet = new cus_wallet(
                    rs.getInt("cw_id"),
                    rs.getInt("acc_id"),
                    rs.getBigDecimal("balance"),
                    rs.getInt("cw_status")
                );
            }
        } catch (Exception e) {
            System.out.println("Lỗi findById wallet: " + e.getMessage());
        } finally {
            release(con);
        }
        return wallet;
    }

    // Hàm phụ để đóng kết nối cho gọn code
    private void release(Connection con) {
        if (con != null) {
            try {
                ConnectionPoolImpl.getInstance().releaseConnection(con, "wallet");
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}