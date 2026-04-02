package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import model.room_type;
import util.ConnectionPoolImpl;

public class room_typeDAO implements daoInterface<room_type> {

	private Connection con;

	public room_typeDAO() {
		try {
			this.con = ConnectionPoolImpl.getInstance().getConnection("room_type");
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public static room_typeDAO getIns() {
		return new room_typeDAO();
	}

	@Override
	public int insert(room_type t) {
		int kq = 0;
		String sql = "INSERT INTO room_type(rt_name, rt_description, rt_price, rt_max_people, rt_area, rt_special, rt_img_url) VALUES (?, ?, ?, ?, ?, ?, ?)";
		try {
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setString(1, t.getRt_name());
			ps.setString(2, t.getRt_description());
			ps.setBigDecimal(3, t.getRt_price());
			ps.setInt(4, t.getRt_max_people());
			ps.setInt(5, t.getRt_area());
			ps.setString(6, t.getRt_special());
			ps.setString(7, t.getRt_img_url());
			kq = ps.executeUpdate();
		} catch (Exception e) {
			System.out.println("insert " + e);
		}finally {
        	try {
				ConnectionPoolImpl.getInstance().releaseConnection(this.con, "room_type");
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		return kq;
	}

	@Override
	public int update(room_type t) {
		int kq = 0;
		String sql = "UPDATE room_type SET rt_name = ?, rt_description = ?, rt_price = ?, rt_max_people = ?, rt_area = ?, rt_special = ?, rt_img_url = ?  WHERE rt_id = ?";
		try {
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setString(1, t.getRt_name());
			ps.setString(2, t.getRt_description());
			ps.setBigDecimal(3, t.getRt_price());
			ps.setInt(4, t.getRt_max_people());
			ps.setInt(5, t.getRt_area());
			ps.setString(6, t.getRt_special());
			ps.setString(7, t.getRt_img_url());
			ps.setInt(8, t.getRt_id());	
			kq = ps.executeUpdate();
		} catch (Exception e) {
			System.out.println("update " + e);
		}finally {
        	try {
				ConnectionPoolImpl.getInstance().releaseConnection(this.con, "room_type");
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		return kq;
	}

	@Override
	public int delete(room_type t) {
		int kq = 0;
		String sql = "DELETE FROM room_type WHERE rt_id = ?";
		try {
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setInt(1, t.getRt_id());
			kq = ps.executeUpdate();
		} catch (Exception e) {
			System.out.println("delete " + e);
		}finally {
        	try {
				ConnectionPoolImpl.getInstance().releaseConnection(this.con, "room_type");
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		return kq;
	}

	@Override
	public ArrayList<room_type> selectAll() {
		ArrayList<room_type> list = new ArrayList<>();
		String sql = "SELECT * FROM room_type";
		try {
			PreparedStatement ps = con.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				room_type rt = new room_type();
				rt.setRt_id(rs.getInt("rt_id"));
				rt.setRt_name(rs.getString("rt_name"));
				rt.setRt_description(rs.getString("rt_description"));
				rt.setRt_price(rs.getBigDecimal("rt_price"));
				rt.setRt_max_people(rs.getInt("rt_max_people"));
				rt.setRt_area(rs.getInt("rt_area"));
				rt.setRt_special(rs.getString("rt_special"));
				rt.setRt_img_url(rs.getString("rt_img_url"));
				list.add(rt);
			}
		} catch (Exception e) {
			System.out.println("selectAll " + e);
		}finally {
        	try {
				ConnectionPoolImpl.getInstance().releaseConnection(this.con, "room_type");
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		return list;
	}

	 @Override 
	public room_type selectById(int id) {
		room_type rt = null;
		String sql = "SELECT * FROM room_type WHERE rt_id = ?";
		try {
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setInt(1, id);
			ResultSet rs = ps.executeQuery();
			if (rs.next()) {
				rt = new room_type();
				rt.setRt_id(rs.getInt("rt_id"));
				rt.setRt_name(rs.getString("rt_name"));
				rt.setRt_description(rs.getString("rt_description"));
				rt.setRt_price(rs.getBigDecimal("rt_price"));
				rt.setRt_max_people(rs.getInt("rt_max_people"));
				rt.setRt_area(rs.getInt("rt_area"));
				rt.setRt_special(rs.getString("rt_special"));
				rt.setRt_img_url(rs.getString("rt_img_url"));			}
		} catch (Exception e) {
			System.out.println("selectById " + e);
		}finally {
        	try {
				ConnectionPoolImpl.getInstance().releaseConnection(this.con, "room_type");
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		return rt;
	}

	@Override
	public ArrayList<room_type> selectByCondition(String condition) {
		ArrayList<room_type> list = new ArrayList<>();
		String sql = "SELECT * FROM room_type WHERE " + condition;
		try {
			PreparedStatement ps = con.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				room_type rt = new room_type();
				rt.setRt_id(rs.getInt("rt_id"));
				rt.setRt_name(rs.getString("rt_name"));
				rt.setRt_description(rs.getString("rt_description"));
				rt.setRt_price(rs.getBigDecimal("rt_price"));
				rt.setRt_max_people(rs.getInt("rt_max_people"));
				rt.setRt_area(rs.getInt("rt_area"));
				rt.setRt_special(rs.getString("rt_special"));
				rt.setRt_img_url(rs.getString("rt_img_url"));
				list.add(rt);
			}
		} catch (Exception e) {
			System.out.println("selectByCondition " + e);
		}finally {
        	try {
				ConnectionPoolImpl.getInstance().releaseConnection(this.con, "room_type");
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		return list;
	}
}
