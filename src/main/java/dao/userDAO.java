package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import model.user;
import util.ConnectionPoolImpl;

public class userDAO implements daoInterface<user> {

	private Connection con;
	
	public userDAO() {
		try {
			this.con = ConnectionPoolImpl.getInstance().getConnection("user");
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public static userDAO getInstance() {
		return new userDAO();
	}

	@Override
	public int insert(user t) {
		int kq = 0;
		try {
			String sql = "INSERT INTO user (user_fullname, user_dob, user_address, user_gender, user_phone_number, user_email, user_avatar_url, acc_id) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
			
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setString(1, t.getUser_fullname());
			ps.setDate(2, t.getUser_dob());
			ps.setString(3, t.getUser_address());
			ps.setInt(4, t.getUser_gender());
			ps.setString(5, t.getUser_phone_number());
			ps.setString(6, t.getUser_email());
			ps.setString(7, t.getUser_avatar_url());
			ps.setInt(8, t.getAcc_id());

			kq = ps.executeUpdate();
		} catch (Exception e) {
			System.out.println("insert user " + e);
		}finally {
        	try {
				ConnectionPoolImpl.getInstance().releaseConnection(this.con, "user");
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		return kq;
	}

	public int insertIgnore(ArrayList<user> list) {
		int kq = 0;
		int l = list.size();
		
		if(l == 0)
			return kq;

		StringBuilder bsql = new StringBuilder(
				"INSERT IGNORE INTO user (user_fullname, user_dob, user_address, user_gender, user_phone_number, user_email, user_avatar_url, acc_id) VALUES ");
		for (int i = 0; i < l - 1; i++) {
			bsql.append("(?, ?, ?, ?, ?, ?, ?, ?),");
		}
		bsql.append("(?, ?, ?, ?, ?, ?, ?, ?);");
		String sql = bsql.toString();

		try {
			
			PreparedStatement ps = con.prepareStatement(sql);
			for (int i = 0; i < l; i++) {
				user t = list.get(i);
				
				ps.setString(8 * i + 1, t.getUser_fullname());
				ps.setDate(8 * i + 2, t.getUser_dob());
				ps.setString(8 * i + 3, t.getUser_address());
				ps.setInt(8 * i + 4, t.getUser_gender());
				ps.setString(8 * i + 5, t.getUser_phone_number());
				ps.setString(8 * i + 6, t.getUser_email());
				ps.setString(8 * i +7, t.getUser_avatar_url());
				ps.setInt(8 * i + 8, t.getAcc_id());
			}

			kq = ps.executeUpdate();
		} catch (Exception e) {
			System.out.println("insert ignore user " + e);
		}finally {
        	try {
				ConnectionPoolImpl.getInstance().releaseConnection(this.con, "user");
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		return kq;
	}

	@Override
	public int update(user t) {
		int kq = 0;
		try {
			String sql = "UPDATE user SET user_fullname = ?, user_dob = ?, user_address = ?, user_gender = ?, user_phone_number = ?, user_email = ?, user_avatar_url = ?, acc_id = ? WHERE user_id = ?";
			
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setString(1, t.getUser_fullname());
			ps.setDate(2, t.getUser_dob());
			ps.setString(3, t.getUser_address());
			ps.setInt(4, t.getUser_gender());
			ps.setString(5, t.getUser_phone_number());
			ps.setString(6, t.getUser_email());
			ps.setString(7, t.getUser_avatar_url());
			ps.setInt(8, t.getAcc_id());
			ps.setInt(9, t.getUser_id());

			kq = ps.executeUpdate();
		} catch (Exception e) {
			System.out.println("update user " + e);
		}finally {
        	try {
				ConnectionPoolImpl.getInstance().releaseConnection(this.con, "user");
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		return kq;
	}

	@Override
	public int delete(user t) {
		int kq = 0;
		try {
			String sql = "DELETE FROM user WHERE user_id = ?";
			
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setInt(1, t.getUser_id());

			kq = ps.executeUpdate();
		} catch (Exception e) {
			System.out.println("delete user " + e);
		}finally {
        	try {
				ConnectionPoolImpl.getInstance().releaseConnection(this.con, "user");
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		return kq;
	}

	@Override
	public ArrayList<user> selectAll() {
		ArrayList<user> list = new ArrayList<>();
		try {
			String sql = "SELECT * FROM user";
			
			PreparedStatement ps = con.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();

			while (rs.next()) {
				user u = new user();
				u.setUser_id(rs.getInt("user_id"));
				u.setUser_fullname(rs.getString("user_fullname"));
				u.setUser_dob(rs.getDate("user_dob"));
				u.setUser_address(rs.getString("user_address"));
				u.setUser_gender(rs.getInt("user_gender"));
				u.setUser_phone_number(rs.getString("user_phone_number"));
				u.setUser_email(rs.getString("user_email"));
				u.setUser_avatar_url(rs.getString("user_avatar_url"));
				u.setAcc_id(rs.getInt("acc_id"));
				list.add(u);
			}

		} catch (Exception e) {
			System.out.println("selectAll user " + e);
		}finally {
        	try {
				ConnectionPoolImpl.getInstance().releaseConnection(this.con, "user");
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		return list;
	}

	@Override
	public user selectById(int id) {
		user u = null;
		try {
			String sql = "SELECT * FROM user WHERE user_id = ?";
			
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setInt(1, id);
			ResultSet rs = ps.executeQuery();

			if (rs.next()) {
				u = new user();
				u.setUser_id(rs.getInt("user_id"));
				u.setUser_fullname(rs.getString("user_fullname"));
				u.setUser_dob(rs.getDate("user_dob"));
				u.setUser_address(rs.getString("user_address"));
				u.setUser_gender(rs.getInt("user_gender"));
				u.setUser_phone_number(rs.getString("user_phone_number"));
				u.setUser_email(rs.getString("user_email"));
				u.setUser_avatar_url(rs.getString("user_avatar_url"));
				u.setAcc_id(rs.getInt("acc_id"));
			}

		} catch (Exception e) {
			System.out.println("selectById user " + e);
		}finally {
        	try {
				ConnectionPoolImpl.getInstance().releaseConnection(this.con, "user");
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		return u;
	}

	@Override
	public ArrayList<user> selectByCondition(String condition) {
		ArrayList<user> list = new ArrayList<>();
		try {
			String sql = "SELECT * FROM user WHERE " + condition;
			
			PreparedStatement ps = con.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();

			while (rs.next()) {
				user u = new user();
				u.setUser_id(rs.getInt("user_id"));
				u.setUser_fullname(rs.getString("user_fullname"));
				u.setUser_dob(rs.getDate("user_dob"));
				u.setUser_address(rs.getString("user_address"));
				u.setUser_gender(rs.getInt("user_gender"));
				u.setUser_phone_number(rs.getString("user_phone_number"));
				u.setUser_email(rs.getString("user_email"));
				u.setUser_avatar_url(rs.getString("user_avatar_url"));
				u.setAcc_id(rs.getInt("acc_id"));
				list.add(u);
			}

		} catch (Exception e) {
			System.out.println("selectByCondition user " + e);
		}finally {
        	try {
				ConnectionPoolImpl.getInstance().releaseConnection(this.con, "user");
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		return list;
	}

	public user getUserByAccountId(int accountId) {
		user u = null;
		try {
			String sql = "SELECT * FROM user WHERE acc_id = ?";
			
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setInt(1, accountId);
			ResultSet rs = ps.executeQuery();

			if (rs.next()) {
				u = new user();
				u.setUser_id(rs.getInt("user_id"));
				u.setUser_fullname(rs.getString("user_fullname"));
				u.setUser_dob(rs.getDate("user_dob"));
				u.setUser_address(rs.getString("user_address"));
				u.setUser_gender(rs.getInt("user_gender"));
				u.setUser_phone_number(rs.getString("user_phone_number"));
				u.setUser_email(rs.getString("user_email"));
				u.setUser_avatar_url(rs.getString("user_avatar_url"));
				u.setAcc_id(rs.getInt("acc_id"));
			}

		} catch (Exception e) {
			System.out.println("getUserByAccountId error: " + e);
		}finally {
        	try {
				ConnectionPoolImpl.getInstance().releaseConnection(this.con, "user");
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		return u;
	}
	
	public int updateAvatarUrl(int userId, String newUrl) {
	    
	    int result = 0;
	    // SQL: UPDATE customer SET cus_avt_url = ? WHERE cus_id = ?
	    String sql = "UPDATE user SET user_avatar_url = ? WHERE user_id = ?";
	    
	    // Giả định 'con' là đối tượng Connection đã được khởi tạo
	    java.sql.Connection con = null; // Khai báo và khởi tạo connection ở đây
	    java.sql.PreparedStatement ps = null;

	    try {
	        // Lấy kết nối từ Connection Pool (hoặc cách bạn quản lý kết nối)
	        con = ConnectionPoolImpl.getInstance().getConnection("user");
	        ps = con.prepareStatement(sql);
	        
	        // 1. SET cus_avt_url (Tham số 1)
	        ps.setString(1, newUrl);
	        
	        // 2. WHERE cus_id = ? (Tham số 2)
	        ps.setInt(2, userId);
	        
	        // !!! BƯỚC SỬA LỖI QUAN TRỌNG: Dùng executeUpdate() cho lệnh UPDATE
	        result = ps.executeUpdate(); 
	        
	        // result sẽ là 1 nếu cập nhật thành công, 0 nếu không tìm thấy cusId
	        
	    } catch (Exception e) {
	        System.out.println("Lỗi cập nhật Avatar URL: " + e.getMessage());
	        e.printStackTrace();
	    } finally {
	        // Đảm bảo đóng PreparedStatement và trả lại Connection
	        try {
	            if (ps != null) ps.close();
	            if (con != null) ConnectionPoolImpl.getInstance().releaseConnection(con, "user");
	        } catch (java.sql.SQLException e) {
	            e.printStackTrace();
	        }
	    }
	    return result; // Trả về số dòng đã được cập nhật
	}

}
