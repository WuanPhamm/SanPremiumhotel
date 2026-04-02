package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;

import model.ContactMessage;
import util.ConnectionPoolImpl;

public class ContactMessageDAO implements daoInterface<ContactMessage> {

    public ContactMessageDAO() {}

    public static ContactMessageDAO getIns() {
        return new ContactMessageDAO();
    }

    // -------------------------------
    // INSERT
    // -------------------------------
    @Override
    public int insert(ContactMessage t) {
        int result = 0;
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet generatedKeys = null;

        String sql = "INSERT INTO contact_message (fullName, email, subject, message, createdAt) "
                   + "VALUES (?, ?, ?, ?, ?)";

        try {
            con = ConnectionPoolImpl.getInstance().getConnection("contact_message");
            ps = con.prepareStatement(sql, PreparedStatement.RETURN_GENERATED_KEYS);

            ps.setString(1, t.getFullName());
            ps.setString(2, t.getEmail());
            ps.setString(3, t.getSubject());
            ps.setString(4, t.getMessage());
            ps.setTimestamp(5, t.getCreatedAt());

            result = ps.executeUpdate();

            if (result > 0) {
                generatedKeys = ps.getGeneratedKeys();
                if (generatedKeys.next()) {
                    t.setId(generatedKeys.getInt(1));
                }
            }

        } catch (Exception e) {
            System.out.println("insert: " + e.getMessage());
        } finally {
            closeResources(con, ps, generatedKeys);
        }

        return result;
    }

    // -------------------------------
    // UPDATE
    // -------------------------------
    @Override
    public int update(ContactMessage t) {
        int result = 0;
        Connection con = null;
        PreparedStatement ps = null;

        String sql = "UPDATE contact_message SET fullName=?, email=?, subject=?, message=?, createdAt=? "
                   + "WHERE id=?";

        try {
            con = ConnectionPoolImpl.getInstance().getConnection("contact_message");
            ps = con.prepareStatement(sql);

            ps.setString(1, t.getFullName());
            ps.setString(2, t.getEmail());
            ps.setString(3, t.getSubject());
            ps.setString(4, t.getMessage());
            ps.setTimestamp(5, t.getCreatedAt());
            ps.setInt(6, t.getId());

            result = ps.executeUpdate();

        } catch (Exception e) {
            System.out.println("update: " + e.getMessage());
        } finally {
            closeResources(con, ps, null);
        }

        return result;
    }

    // -------------------------------
    // DELETE
    // -------------------------------
    @Override
    public int delete(ContactMessage t) {
        int result = 0;
        Connection con = null;
        PreparedStatement ps = null;

        String sql = "DELETE FROM contact_message WHERE id=?";

        try {
            con = ConnectionPoolImpl.getInstance().getConnection("contact_message");
            ps = con.prepareStatement(sql);
            ps.setInt(1, t.getId());
            result = ps.executeUpdate();

        } catch (Exception e) {
            System.out.println("delete: " + e.getMessage());
        } finally {
            closeResources(con, ps, null);
        }

        return result;
    }

    // -------------------------------
    // SELECT ALL
    // -------------------------------
    @Override
    public ArrayList<ContactMessage> selectAll() {
        ArrayList<ContactMessage> list = new ArrayList<>();
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        String sql = "SELECT * FROM contact_message ORDER BY createdAt DESC";

        try {
            con = ConnectionPoolImpl.getInstance().getConnection("contact_message");
            ps = con.prepareStatement(sql);
            rs = ps.executeQuery();

            while (rs.next()) {
                list.add(mapResultSet(rs));
            }

        } catch (Exception e) {
            System.out.println("selectAll: " + e.getMessage());
        } finally {
            closeResources(con, ps, rs);
        }

        return list;
    }

    // -------------------------------
    // SELECT BY ID
    // -------------------------------
    @Override
    public ContactMessage selectById(int id) {
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        String sql = "SELECT * FROM contact_message WHERE id=?";

        try {
            con = ConnectionPoolImpl.getInstance().getConnection("contact_message");
            ps = con.prepareStatement(sql);
            ps.setInt(1, id);
            rs = ps.executeQuery();

            if (rs.next()) {
                return mapResultSet(rs);
            }

        } catch (Exception e) {
            System.out.println("selectById: " + e.getMessage());
        } finally {
            closeResources(con, ps, rs);
        }

        return null;
    }

    // -------------------------------
    // SELECT BY CONDITION
    // -------------------------------
    @Override
    public ArrayList<ContactMessage> selectByCondition(String condition) {
        ArrayList<ContactMessage> list = new ArrayList<>();
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        String sql = "SELECT * FROM contact_message WHERE " + condition;

        try {
            con = ConnectionPoolImpl.getInstance().getConnection("contact_message");
            ps = con.prepareStatement(sql);
            rs = ps.executeQuery();

            while (rs.next()) {
                list.add(mapResultSet(rs));
            }

        } catch (Exception e) {
            System.out.println("selectByCondition: " + e.getMessage());
        } finally {
            closeResources(con, ps, rs);
        }

        return list;
    }

    // -------------------------------
    // MAP RESULTSET → MODEL
    // -------------------------------
    private ContactMessage mapResultSet(ResultSet rs) throws SQLException {
        ContactMessage cm = new ContactMessage();

        cm.setId(rs.getInt("id"));
        cm.setFullName(rs.getString("fullName"));
        cm.setEmail(rs.getString("email"));
        cm.setSubject(rs.getString("subject"));
        cm.setMessage(rs.getString("message"));
        cm.setCreatedAt(rs.getTimestamp("createdAt"));

        return cm;
    }

    // -------------------------------
    // CLOSE RESOURCES
    // -------------------------------
 // SỬA: Thay thế con.close() bằng logic trả về pool
    private void closeResources(Connection con, PreparedStatement ps, ResultSet rs) {
        try { if (rs != null) rs.close(); } catch (Exception e) {}
        try { if (ps != null) ps.close(); } catch (Exception e) {}
        
        // Cần trả kết nối về pool, không đóng
        if (con != null) {
            try {
                // Giả định resource name bạn dùng là "contact_message"
                ConnectionPoolImpl.getInstance().releaseConnection(con, "contact_message"); 
            } catch (Exception e) {
                e.printStackTrace(); 
            }
        }
    }
}
