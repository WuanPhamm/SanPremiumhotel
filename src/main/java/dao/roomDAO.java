package dao;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import model.account;
import model.customer;
import model.room;
import model.user;
import util.ConnectionPoolImpl;
import util.JDBCUtil;

public class roomDAO implements daoInterface<room> {


	public static roomDAO getIns() {
		return new roomDAO();
	}
	
	
	

	@Override
	public int insert(room t) {
	    int kq = 0;
	    Connection con = null; // Giống như Vấn đề 1
	    String sql = "INSERT INTO room(room_name, rt_id, rs_id, floor_id, room_booking_time) VALUES (?, ?, ?, ?, ?)";
	    
	    try {
	        con = ConnectionPoolImpl.getInstance().getConnection("room"); // Giống như Vấn đề 1
	        PreparedStatement ps = con.prepareStatement(sql);
	        
	        // Sửa lại thứ tự cho đúng
	        ps.setString(1, t.getRoom_name());       // Cột 1: room_name
	        ps.setInt(2, t.getRt_id());            // Cột 2: rt_id
	        ps.setInt(3, t.getRs_id());            // Cột 3: rs_id
	        ps.setInt(4, t.getFloor_id());         // Cột 4: floor_id
	        ps.setInt(5, t.getRoom_booking_time());// Cột 5: room_booking_time
	        
	        kq = ps.executeUpdate();
	    } catch (Exception e) {
	        System.out.println("insert " + e);
	        e.printStackTrace();
	    } finally {
	        // Giống như Vấn đề 1
	        try {
	            if (con != null) {
	                ConnectionPoolImpl.getInstance().releaseConnection(con, "room");
	            }
	        } catch (SQLException e) {
	            e.printStackTrace();
	        }
	    }
	    return kq;
	}
	
	
	public int insertIgnore(ArrayList<room> list) {
        int kq = 0;
    	int l = list.size();
    	Connection con=null;
        try {
        	con = ConnectionPoolImpl.getInstance().getConnection("room-insertIgnore");
        	StringBuilder bsql = new StringBuilder("INSERT IGNORE INTO room (room_name, rt_id, rs_id, floor_id, room_booking_time) VALUES");
        	
        	for(int i = 0; i < l - 1; i++) {
        		bsql.append("(?,?,?,?,?),");
        	}
        	bsql.append("(?,?,?,?,?);");
        	
        	String sql = bsql.toString();
            PreparedStatement ps = con.prepareStatement(sql);
            
            for(int i = 0; i < l; i++) {
                ps.setString(5 * i + 1, list.get(i).getRoom_name());               
                ps.setInt(5 * i + 2, list.get(i).getRt_id());
                ps.setInt(5 * i + 3, list.get(i).getRs_id());
                ps.setInt(5 * i + 4 ,list.get(i).getFloor_id());
                ps.setInt(5 * i + 5, list.get(i).getRoom_booking_time());
            }
            
            kq = ps.executeUpdate();
            
            
        } catch (Exception e) {
            System.out.println("insert ignore room " + e);
        }finally {
        	try {
                if (con != null) { // BƯỚC 2: Sửa lại
				    ConnectionPoolImpl.getInstance().releaseConnection(con, "room-insertIgnore");
                }
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
        return kq;
    }
	

	@Override
	public int update(room t) {
	    int kq = 0;
	    Connection con = null; // Khai báo Connection cục bộ
	    String sql = "UPDATE room SET room_name = ?, room_booking_time = ?, floor_id = ?, rt_id = ?, rs_id = ? WHERE room_id = ?";
	    
	    try {
	        // Lấy kết nối mới từ pool
	        con = ConnectionPoolImpl.getInstance().getConnection("room"); 
	        PreparedStatement ps = con.prepareStatement(sql);
	        
	        ps.setString(1, t.getRoom_name());
	        ps.setInt(2, t.getRoom_booking_time());
	        ps.setInt(3, t.getFloor_id());
	        ps.setInt(4, t.getRt_id());
	        ps.setInt(5, t.getRs_id());
	        ps.setInt(6, t.getRoom_id());
	        
	        kq = ps.executeUpdate();
	    } catch (Exception e) {
	        System.out.println("update " + e);
	        e.printStackTrace(); // Thêm e.printStackTrace() để xem lỗi chi tiết
	    } finally {
	        try {
	            // Trả kết nối về pool
	            if (con != null) { 
	                ConnectionPoolImpl.getInstance().releaseConnection(con, "room");
	            }
	        } catch (SQLException e) {
	            e.printStackTrace();
	        }
	    }
	    return kq;
	}

	@Override
	public int delete(room t) {
		int kq = 0;
		String sql = "DELETE FROM room WHERE room_id = ?";
		Connection con = null;
		try {
			con = ConnectionPoolImpl.getInstance().getConnection("room-delete");
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setInt(1, t.getRoom_id());
			kq = ps.executeUpdate();
		} catch (Exception e) {
			System.out.println("delete " + e);
		}finally {
			try {
                if (con != null) {
				    ConnectionPoolImpl.getInstance().releaseConnection(con, "room-delete"); // Trả
                }
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return kq;
	}

	@Override
	public ArrayList<room> selectAll() {
		ArrayList<room> list = new ArrayList<>();
		String sql = "SELECT * FROM room";
		Connection con =null;
		try {
			con = ConnectionPoolImpl.getInstance().getConnection("room-selectAll"); // Lấy
			
			PreparedStatement ps = con.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				room r = new room();
				r.setRoom_id(rs.getInt("room_id"));
				r.setRoom_name(rs.getString("room_name"));		
				r.setRoom_booking_time(rs.getInt("room_booking_time"));			
				r.setFloor_id(rs.getInt("floor_id"));
				r.setRt_id(rs.getInt("rt_id"));
				r.setRs_id(rs.getInt("rs_id"));
				list.add(r);
			}
		} catch (Exception e) {
			System.out.println("selectAll " + e);
		}finally {
			try {
				if (con != null) {
					ConnectionPoolImpl.getInstance().releaseConnection(con, "room-selectAll"); // Trả
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		
		return list;
	}

	@Override
	public room selectById(int id) {
		room r = null;
		String sql = "SELECT * FROM room WHERE room_id = ?";
		Connection con =null;
		try {
			con= ConnectionPoolImpl.getInstance().getConnection("room-selectById");
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setInt(1, id);
			ResultSet rs = ps.executeQuery();
			if (rs.next()) {
				r = new room();
				r.setRoom_id(rs.getInt("room_id"));
				r.setRoom_name(rs.getString("room_name"));
				r.setRoom_booking_time(rs.getInt("room_booking_time"));				
				r.setFloor_id(rs.getInt("floor_id"));
				r.setRt_id(rs.getInt("rt_id"));
				r.setRs_id(rs.getInt("rs_id"));
			}
		} catch (Exception e) {
			System.out.println("selectById " + e);
		}finally {
			try {
				if (con != null) {
					ConnectionPoolImpl.getInstance().releaseConnection(con, "room-selectById"); // Trả
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return r;
	}

	@Override
	public ArrayList<room> selectByCondition(String condition) {
		ArrayList<room> list = new ArrayList<>();
		String sql = "SELECT * FROM room WHERE " + condition;
		Connection con=null;
		try {
			con = ConnectionPoolImpl.getInstance().getConnection("room-selectByCondition"); 
			PreparedStatement ps = con.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				room r = new room();
				r.setRoom_id(rs.getInt("room_id"));
				r.setRoom_name(rs.getString("room_name"));				
				r.setRoom_booking_time(rs.getInt("room_booking_time"));				
				r.setFloor_id(rs.getInt("floor_id"));
				r.setRt_id(rs.getInt("rt_id"));
				r.setRs_id(rs.getInt("rs_id"));
				list.add(r);
			}
		} catch (Exception e) {
			System.out.println("selectByCondition " + e);
		}finally {
			try {
				if (con != null) {
					ConnectionPoolImpl.getInstance().releaseConnection(con, "room-selectByCondition"); // Trả
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return list;
	}
	
	public int updateTrangThai(int room_id, int rs_id) {
		int kq = 0;
		String sql = "UPDATE room SET rs_id = ? WHERE room_id = ?";
		Connection con=null;
		try {
			con = ConnectionPoolImpl.getInstance().getConnection("room-updateTrangThai");
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setInt(1, rs_id);
			ps.setInt(2, room_id);
			kq = ps.executeUpdate();
		} catch (Exception e) {
			System.out.println("update " + e);
		}finally {
			try {
				if (con != null) {
					ConnectionPoolImpl.getInstance().releaseConnection(con, "room-updateTrangThai"); // Trả
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return kq;
	}
	
	
	
	public ArrayList<room> getAvailableRooms(int rt_id, int floor_id) {
	    ArrayList<room> list = new ArrayList<>();
	    String sql = "SELECT * FROM room " +
	                 "WHERE rt_id = ? AND floor_id = ? " +
	                 "ORDER BY room_name";
	    Connection con = null;
	    try {
	        con = ConnectionPoolImpl.getInstance().getConnection("room");
	        PreparedStatement ps = con.prepareStatement(sql);
	        ps.setInt(1, rt_id);
	        ps.setInt(2, floor_id);
	        
	        ResultSet rs = ps.executeQuery();
	        
	        while (rs.next()) {
	            room r = new room();
	            r.setRoom_id(rs.getInt("room_id"));
	            r.setRoom_name(rs.getString("room_name"));
	            r.setRoom_booking_time(rs.getInt("room_booking_time"));
	            r.setFloor_id(rs.getInt("floor_id"));
	            r.setRt_id(rs.getInt("rt_id"));
	            r.setRs_id(rs.getInt("rs_id"));
	            list.add(r);
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	    } finally {
	        if (con != null) {
	            try {
	                ConnectionPoolImpl.getInstance().releaseConnection(con, "room");
	            } catch (Exception e) { e.printStackTrace(); }
	        }
	    }
	    return list;
	}
	
	public int countRooms() {
	    int kq = 0;
	    String sql = "SELECT COUNT(*) FROM room";
	    PreparedStatement ps = null;
	    ResultSet rs = null;
	    Connection con=null;
	    try {
	    	con = ConnectionPoolImpl.getInstance().getConnection("room-count");
	        ps = con.prepareStatement(sql);
	        rs = ps.executeQuery(); // Dùng executeQuery() thay vì executeUpdate()

	        if (rs.next()) {
	            kq = rs.getInt(1); // Lấy giá trị COUNT(*) ở cột đầu tiên
	        }

	    } catch (Exception e) {
	        System.out.println("count " + e);
	    } finally {
	        try {
	            if (rs != null) rs.close();
	            if (ps != null) ps.close();
	            if (con != null) {
	            	ConnectionPoolImpl.getInstance().releaseConnection(con, "room-count");}
	        } catch (SQLException e) {
	            e.printStackTrace();
	        }
	    }

	    return kq;
	}
	
	// Thêm phương thức này vào class roomDAO.java của bạn

	public void updateAllRoomStatuses() {
	    Connection con = null;
	    PreparedStatement ps = null;

	    // Câu lệnh SQL này cập nhật tất cả các phòng (có trạng thái 1 hoặc 2)
	    // dựa trên việc có hay không một bản ghi trong 'unavailable_date'
	    String sql = "UPDATE room r " +
	                 "LEFT JOIN unavailable_date ud ON r.room_id = ud.room_id " +
	                 "  AND (CURDATE() >= ud.ud_start AND CURDATE() < ud.ud_end) " + // Giả sử ud_end là ngày trả phòng
	                 "SET " +
	                 "  r.rs_id = CASE " +
	                 "    WHEN ud.ud_id IS NOT NULL THEN 2 " + // 2 = Đang được đặt
	                 "    ELSE 1 " +                           // 1 = Đang trống
	                 "  END " +
	                 "WHERE " +
	                 "  r.rs_id IN (1, 2);"; // Chỉ cập nhật phòng đang trống hoặc đang đặt

	    try {
	        // Lấy và trả connection đúng cách (như đã sửa ở Vấn đề 1)
	        con = ConnectionPoolImpl.getInstance().getConnection("roomStatusUpdater");
	        ps = con.prepareStatement(sql);
	        int updatedRows = ps.executeUpdate();
	        
	        // Ghi log để bạn biết nó đang chạy
	        System.out.println("RoomStatusUpdater: Updated " + updatedRows + " rows."); 
	        
	    } catch (Exception e) {
	        System.out.println("Error running RoomStatusUpdater: " + e);
	        e.printStackTrace();
	    } finally {
	        try {
	            // Dọn dẹp
	            if (ps != null) ps.close();
	            if (con != null) {
	                ConnectionPoolImpl.getInstance().releaseConnection(con, "roomStatusUpdater");
	            }
	        } catch (SQLException e) {
	            e.printStackTrace();
	        }
	    }
	}
	

}
