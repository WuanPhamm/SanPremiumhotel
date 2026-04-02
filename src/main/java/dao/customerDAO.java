package dao;

import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;


import model.CustomerStatisticDTO;
import model.customer;
import util.ConnectionPoolImpl;

public class customerDAO implements daoInterface<customer> {

	private Connection con;

	public customerDAO() {
		try {
			this.con = ConnectionPoolImpl.getInstance().getConnection("customer");
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public static customerDAO getIns() {
		return new customerDAO();
	}

	@Override
	public int insert(customer t) {
		int kq = 0;
		String sql = "INSERT INTO customer(cus_firstname, cus_lastname, cus_dob, cus_gender, cus_phone, cus_email, cus_address, cus_cccd, cus_avt_url, acc_id) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
		try {
			PreparedStatement ps = con.prepareStatement(sql, PreparedStatement.RETURN_GENERATED_KEYS);

			ps.setString(1, t.getCus_firstname());
			ps.setString(2, t.getCus_lastname());
			ps.setDate(3, t.getCus_dob());
			ps.setInt(4, t.getCus_gender());
			ps.setString(5, t.getCus_phone());
			ps.setString(6, t.getCus_email());
			ps.setString(7, t.getCus_address());
			ps.setString(8, t.getCus_cccd());
			ps.setString(9, t.getCus_avt_url());
			ps.setInt(10, t.getAcc_id());

			kq = ps.executeUpdate();
			
			try (ResultSet rs = ps.getGeneratedKeys()) {
	            if (rs.next()) {
	                int generatedId = rs.getInt(1);
	                t.setCus_id(generatedId); // Gán ID vừa tạo vào đối tượng customer
	                return generatedId; // Trả về ID vừa tạo
	            }
	        }
		} catch (Exception e) {
			System.out.println("insert " + e);
		}finally {
        	try {
				ConnectionPoolImpl.getInstance().releaseConnection(this.con, "customer");
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		return kq;
	}

	public int insertIgnore(ArrayList<customer> list) {
		int kq = 0;
		int l = list.size();

		if (l == 0)
			return kq;

		StringBuilder bsql = new StringBuilder("INSERT IGNORE INTO cus(cus_firstname, "
				+ "cus_lastname, cus_dob, cus_gender, cus_phone, "
				+ "cus_email, cus_address, cus_cccd,cus_avt_url, acc_id) VALUES ");

		for (int i = 0; i < l - 1; i++) {
			bsql.append("(?, ?, ?, ?, ?, ?, ?, ?, ?, ?),");
		}
		bsql.append("(?, ?, ?, ?, ?, ?, ?, ?, ?, ?);");

		String sql = bsql.toString();

		try {
			PreparedStatement ps = con.prepareStatement(sql);

			for (int i = 0; i < l; i++) {
				customer t = list.get(i);

				ps.setString(10 * i + 1, t.getCus_firstname());
				ps.setString(10 * i + 2, t.getCus_lastname());
				ps.setDate(10 * i + 3, t.getCus_dob());
				ps.setInt(10 * i + 4, t.getCus_gender());
				ps.setString(10 * i + 5, t.getCus_phone());
				ps.setString(10 * i + 6, t.getCus_email());
				ps.setString(10 * i + 7, t.getCus_address());
				ps.setString(10 * i + 8, t.getCus_cccd());
				ps.setString(10 * i + 9, t.getCus_avt_url());
				ps.setInt(10 * i + 10, t.getAcc_id());

			}
			kq = ps.executeUpdate();
		} catch (Exception e) {
			System.out.println("Insert customer ignore " + e);
		}finally {
        	try {
				ConnectionPoolImpl.getInstance().releaseConnection(this.con, "customer");
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}

		return kq;
	}

	@Override
	public int update(customer t) {
		int kq = 0;
		String sql = "UPDATE customer SET cus_firstname = ?, cus_lastname = ?, cus_dob = ?, cus_gender = ?, cus_phone = ?, cus_email = ?, cus_address = ?, cus_cccd = ?, cus_booking_time = ?, cus_avt_url = ?, acc_id = ? WHERE cus_id = ?";
		try {
			PreparedStatement ps = con.prepareStatement(sql);

			ps.setString(1, t.getCus_firstname());
			ps.setString(2, t.getCus_lastname());
			ps.setDate(3, t.getCus_dob());
			ps.setInt(4, t.getCus_gender());
			ps.setString(5, t.getCus_phone());
			ps.setString(6, t.getCus_email());
			ps.setString(7, t.getCus_address());
			ps.setString(8, t.getCus_cccd());
			ps.setInt(9, t.getCus_booking_time());
			ps.setString(10, t.getCus_avt_url());
			ps.setInt(11, t.getAcc_id());
			ps.setInt(12, t.getCus_id());

			kq = ps.executeUpdate();
		} catch (Exception e) {
			System.out.println("update " + e);
		}finally {
        	try {
				ConnectionPoolImpl.getInstance().releaseConnection(this.con, "customer");
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		return kq;
	}

	@Override
	public int delete(customer t) {
		int kq = 0;
		String sql = "DELETE FROM customer WHERE cus_id = ?";
		try {
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setInt(1, t.getCus_id());
			kq = ps.executeUpdate();
		} catch (Exception e) {
			System.out.println("delete " + e);
		}finally {
        	try {
				ConnectionPoolImpl.getInstance().releaseConnection(this.con, "customer");
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		return kq;
	}

	@Override
	public ArrayList<customer> selectAll() {
		ArrayList<customer> list = new ArrayList<>();
		String sql = "SELECT * FROM customer";
		try {
			PreparedStatement ps = con.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				customer c = new customer();
				c.setCus_id(rs.getInt("cus_id"));
				c.setCus_firstname(rs.getString("cus_firstname"));
				c.setCus_lastname(rs.getString("cus_lastname"));
				c.setCus_dob(rs.getDate("cus_dob"));
				c.setCus_gender(rs.getInt("cus_gender"));
				c.setCus_phone(rs.getString("cus_phone"));
				c.setCus_email(rs.getString("cus_email"));
				c.setCus_address(rs.getString("cus_address"));
				c.setCus_cccd(rs.getString("cus_cccd"));
				c.setCus_booking_time(rs.getInt("cus_booking_time"));
				c.setCus_avt_url(rs.getString("cus_avt_url"));
				c.setAcc_id(rs.getInt("acc_id"));
				list.add(c);
			}
		} catch (Exception e) {
			System.out.println("selectAll " + e);
		}finally {
        	try {
				ConnectionPoolImpl.getInstance().releaseConnection(this.con, "customer");
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		return list;
	}

	@Override
	public customer selectById(int id) {
		customer c = null;
		String sql = "SELECT * FROM customer WHERE cus_id = ?";
		try {
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setInt(1, id);
			ResultSet rs = ps.executeQuery();
			if (rs.next()) {
				c = new customer();
				c.setCus_id(rs.getInt("cus_id"));
				c.setCus_firstname(rs.getString("cus_firstname"));
				c.setCus_lastname(rs.getString("cus_lastname"));
				c.setCus_dob(rs.getDate("cus_dob"));
				c.setCus_gender(rs.getInt("cus_gender"));
				c.setCus_phone(rs.getString("cus_phone"));
				c.setCus_email(rs.getString("cus_email"));
				c.setCus_address(rs.getString("cus_address"));
				c.setCus_cccd(rs.getString("cus_cccd"));
				c.setCus_booking_time(rs.getInt("cus_booking_time"));
				c.setCus_avt_url(rs.getString("cus_avt_url"));
				c.setAcc_id(rs.getInt("acc_id"));
			}
		} catch (Exception e) {
			System.out.println("selectById " + e);
		}finally {
        	try {
				ConnectionPoolImpl.getInstance().releaseConnection(this.con, "customer");
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		return c;
	}

	@Override
	public ArrayList<customer> selectByCondition(String condition) {
		ArrayList<customer> list = new ArrayList<>();
		String sql = "SELECT * FROM customer WHERE " + condition;
		try {
			PreparedStatement ps = con.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				customer c = new customer();
				c.setCus_id(rs.getInt("cus_id"));
				c.setCus_firstname(rs.getString("cus_firstname"));
				c.setCus_lastname(rs.getString("cus_lastname"));
				c.setCus_dob(rs.getDate("cus_dob"));
				c.setCus_gender(rs.getInt("cus_gender"));
				c.setCus_phone(rs.getString("cus_phone"));
				c.setCus_email(rs.getString("cus_email"));
				c.setCus_address(rs.getString("cus_address"));
				c.setCus_cccd(rs.getString("cus_cccd"));
				c.setCus_booking_time(rs.getInt("cus_booking_time"));
				c.setCus_avt_url(rs.getString("cus_avt_url"));
				c.setAcc_id(rs.getInt("acc_id"));
				list.add(c);
			}
		} catch (Exception e) {
			System.out.println("selectByCondition " + e);
		}finally {
        	try {
				ConnectionPoolImpl.getInstance().releaseConnection(this.con, "customer");
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		return list;
	}
	
	public customer getCustomerByAccountId(int id) {
		customer c = null;
		String sql = "SELECT * FROM customer WHERE acc_id = ?";
		try {
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setInt(1, id);
			ResultSet rs = ps.executeQuery();
			if (rs.next()) {
				c = new customer();
				c.setCus_id(rs.getInt("cus_id"));
				c.setCus_firstname(rs.getString("cus_firstname"));
				c.setCus_lastname(rs.getString("cus_lastname"));
				c.setCus_dob(rs.getDate("cus_dob"));
				c.setCus_gender(rs.getInt("cus_gender"));
				c.setCus_phone(rs.getString("cus_phone"));
				c.setCus_email(rs.getString("cus_email"));
				c.setCus_address(rs.getString("cus_address"));
				c.setCus_cccd(rs.getString("cus_cccd"));
				c.setCus_booking_time(rs.getInt("cus_booking_time"));
				c.setCus_avt_url(rs.getString("cus_avt_url"));
				c.setAcc_id(rs.getInt("acc_id"));
			}
		} catch (Exception e) {
			System.out.println("get Customer By Account ID " + e);
		}finally {
        	try {
				ConnectionPoolImpl.getInstance().releaseConnection(this.con, "customer");
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return c;
	}
	
	// Giả định class customerDAO có trường Connection con và các phương thức cần thiết

	public int updateAvatarUrl(int cusId, String newUrl) {
		    
	    int result = 0;
	    // SQL: UPDATE customer SET cus_avt_url = ? WHERE cus_id = ?
	    String sql = "UPDATE customer SET cus_avt_url = ? WHERE cus_id = ?";
	    
	    // Giả định 'con' là đối tượng Connection đã được khởi tạo
	    java.sql.Connection con = null; // Khai báo và khởi tạo connection ở đây
	    java.sql.PreparedStatement ps = null;

	    try {
	        // Lấy kết nối từ Connection Pool (hoặc cách bạn quản lý kết nối)
	        con = ConnectionPoolImpl.getInstance().getConnection("customer");
	        ps = con.prepareStatement(sql);
	        
	        // 1. SET cus_avt_url (Tham số 1)
	        ps.setString(1, newUrl);
	        
	        // 2. WHERE cus_id = ? (Tham số 2)
	        ps.setInt(2, cusId);
	        
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
	            if (con != null) ConnectionPoolImpl.getInstance().releaseConnection(con, "customer");
	        } catch (java.sql.SQLException e) {
	            e.printStackTrace();
	        }
	    }
	    return result; // Trả về số dòng đã được cập nhật
	}
	// Thêm vào class customerDAO

	// 1. Lấy Top khách hàng theo doanh thu
	public ArrayList<CustomerStatisticDTO> getTopCustomerByRevenue(int limit) {
	    ArrayList<CustomerStatisticDTO> list = new ArrayList<>();
	    // SQL: Join bảng customer và booking, tính tổng tiền, sắp xếp giảm dần
	    // Lưu ý: Thêm điều kiện WHERE b.bs_id = [TRANG_THAI_THANH_CONG] nếu cần
	    String sql = "SELECT c.*, SUM(b.booking_total) as total_revenue, COUNT(b.booking_id) as total_count " +
	                 "FROM customer c " +
	                 "JOIN booking b ON c.cus_id = b.cus_id " +
	                 "GROUP BY c.cus_id " +
	                 "ORDER BY total_revenue DESC " +
	                 "LIMIT ?";
	    
	    // Khởi tạo connection cục bộ để đảm bảo an toàn thread/pool
	    Connection con = null;
	    PreparedStatement ps = null;
	    ResultSet rs = null;

	    try {
	        con = ConnectionPoolImpl.getInstance().getConnection("customer");
	        ps = con.prepareStatement(sql);
	        ps.setInt(1, limit);
	        rs = ps.executeQuery();

	        while (rs.next()) {
	            customer c = new customer();
	            // Map dữ liệu customer từ RS
	            c.setCus_id(rs.getInt("cus_id"));
	            c.setCus_firstname(rs.getString("cus_firstname"));
	            c.setCus_lastname(rs.getString("cus_lastname"));
	            c.setCus_email(rs.getString("cus_email"));
	            c.setCus_phone(rs.getString("cus_phone"));
	            c.setCus_avt_url(rs.getString("cus_avt_url"));
	            // ... map thêm các trường khác nếu cần hiển thị

	            BigDecimal revenue = rs.getBigDecimal("total_revenue");
	            int count = rs.getInt("total_count");

	            CustomerStatisticDTO dto = new CustomerStatisticDTO(c, count, revenue);
	            list.add(dto);
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	    } finally {
	        // Code đóng resource giống các hàm khác của bạn
	        try {
	            if (rs != null) rs.close();
	            if (ps != null) ps.close();
	            if (con != null) ConnectionPoolImpl.getInstance().releaseConnection(con, "customer");
	        } catch (SQLException e) {
	            e.printStackTrace();
	        }
	    }
	    return list;
	}

	// 2. Lấy Top khách hàng theo số lượng đơn đặt
	public ArrayList<CustomerStatisticDTO> getTopCustomerByBookingCount(int limit , Date startDate, Date endDate) {
	    ArrayList<CustomerStatisticDTO> list = new ArrayList<>();
	    String sql = "SELECT c.*, SUM(b.booking_total) as total_revenue, COUNT(b.booking_id) as total_count " +
	                 "FROM customer c " +
	                 "JOIN booking b ON c.cus_id = b.cus_id " +
	                 "WHERE b.booking_time >= ? AND b.booking_time <= ? " + 
	                 "GROUP BY c.cus_id " +
	                 "ORDER BY total_count DESC " +
	                 "LIMIT ?";
	    
	    Connection con = null;
	    PreparedStatement ps = null;
	    ResultSet rs = null;

	    try {
	        con = ConnectionPoolImpl.getInstance().getConnection("customer");
	        ps = con.prepareStatement(sql);
	        ps.setDate(1, startDate);
	        ps.setDate(2, endDate);
	        ps.setInt(3, limit);
	        
	      
	        rs = ps.executeQuery();

	        while (rs.next()) {
	            customer c = new customer();
	            c.setCus_id(rs.getInt("cus_id"));
	            c.setCus_firstname(rs.getString("cus_firstname"));
	            c.setCus_lastname(rs.getString("cus_lastname"));
	            c.setCus_email(rs.getString("cus_email"));
	            c.setCus_phone(rs.getString("cus_phone"));
	            c.setCus_address(rs.getString("cus_address")); // Lấy thêm địa chỉ để hiển thị popup
	            c.setCus_gender(rs.getInt("cus_gender"));      // Lấy thêm giới tính
	            c.setCus_dob(rs.getDate("cus_dob"));
	            c.setCus_avt_url(rs.getString("cus_avt_url"));
	            BigDecimal revenue = rs.getBigDecimal("total_revenue");
	            int count = rs.getInt("total_count");

	            CustomerStatisticDTO dto = new CustomerStatisticDTO(c, count, revenue);
	            list.add(dto);
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	    } finally {
	        try {
	            if (rs != null) rs.close();
	            if (ps != null) ps.close();
	            if (con != null) ConnectionPoolImpl.getInstance().releaseConnection(con, "customer");
	        } catch (SQLException e) {
	            e.printStackTrace();
	        }
	    }
	    return list;
	}
	
	// Trong file dao/customerDAO.java

	// Hàm lấy Top theo doanh thu có lọc ngày
	public ArrayList<CustomerStatisticDTO> getTopCustomerByRevenue(int limit, Date startDate, Date endDate) {
	    ArrayList<CustomerStatisticDTO> list = new ArrayList<>();
	    // Thêm điều kiện WHERE b.booking_time BETWEEN ? AND ?
	    // Chúng ta lọc theo ngày tạo đơn (booking_time) hoặc ngày thanh toán (payment_time) tùy nghiệp vụ. 
	    // Ở đây tôi dùng booking_time.
	    String sql = "SELECT c.*, SUM(b.booking_total) as total_revenue, COUNT(b.booking_id) as total_count " +
	                 "FROM customer c " +
	                 "JOIN booking b ON c.cus_id = b.cus_id " +
	                 "WHERE b.booking_time >= ? AND b.booking_time <= ? " + 
	                 "GROUP BY c.cus_id " +
	                 "ORDER BY total_revenue DESC " +
	                 "LIMIT ?";
	    
	    Connection con = null;
	    PreparedStatement ps = null;
	    ResultSet rs = null;

	    try {
	        con = ConnectionPoolImpl.getInstance().getConnection("customer");
	        ps = con.prepareStatement(sql);
	        
	        // Lưu ý: endDate khi truyền từ giao diện thường là 00:00:00. 
	        // Để lấy trọn vẹn ngày cuối, nên cộng thêm 1 ngày hoặc xử lý time.
	        // Ở mức cơ bản, ta truyền Date thẳng vào.
	        ps.setDate(1, startDate);
	        ps.setDate(2, endDate);
	        ps.setInt(3, limit);
	        
	        rs = ps.executeQuery();

	        while (rs.next()) {
	            customer c = new customer();
	            c.setCus_id(rs.getInt("cus_id"));
	            c.setCus_firstname(rs.getString("cus_firstname"));
	            c.setCus_lastname(rs.getString("cus_lastname"));
	            c.setCus_email(rs.getString("cus_email"));
	            c.setCus_phone(rs.getString("cus_phone"));
	            c.setCus_address(rs.getString("cus_address")); // Lấy thêm địa chỉ để hiển thị popup
	            c.setCus_gender(rs.getInt("cus_gender"));      // Lấy thêm giới tính
	            c.setCus_dob(rs.getDate("cus_dob"));           // Lấy thêm ngày sinh
	            c.setCus_avt_url(rs.getString("cus_avt_url"));
	            BigDecimal revenue = rs.getBigDecimal("total_revenue");
	            int count = rs.getInt("total_count");

	            CustomerStatisticDTO dto = new CustomerStatisticDTO(c, count, revenue);
	            list.add(dto);
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	    } finally {
	        // ... (Code đóng kết nối như cũ)
	        try {
	            if (rs != null) rs.close();
	            if (ps != null) ps.close();
	            if (con != null) ConnectionPoolImpl.getInstance().releaseConnection(con, "customer");
	        } catch (SQLException e) {
	            e.printStackTrace();
	        }
	    }
	    return list;
	}

	// Tương tự, bạn làm thêm hàm getTopCustomerByBookingCount với tham số Date y hệt logic trên
	
}
