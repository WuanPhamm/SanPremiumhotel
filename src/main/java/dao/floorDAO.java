package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import model.floor;
import util.ConnectionPoolImpl;

public class floorDAO implements daoInterface<floor> {

	private Connection con;

	public floorDAO() {
		try {
			this.con = ConnectionPoolImpl.getInstance().getConnection("account");
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public static floorDAO getIns() {
		return new floorDAO();
	}

	@Override
	public int insert(floor t) {
		int kq = 0;
		String sql = "INSERT INTO floor(floor_name, floor_description) VALUES (?, ?)";
		try {
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setString(1, t.getFloor_name());
			ps.setString(2, t.getFloor_description());
			kq = ps.executeUpdate();
		} catch (Exception e) {
			System.out.println("insert " + e);
		}finally {
        	try {
				ConnectionPoolImpl.getInstance().releaseConnection(this.con, "floor");
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		return kq;
	}

	@Override
	public int update(floor t) {
		int kq = 0;
		String sql = "UPDATE floor SET floor_name = ?, floor_description = ? WHERE floor_id = ?";
		try {
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setString(1, t.getFloor_name());
			ps.setString(2, t.getFloor_description());
			ps.setInt(3, t.getFloor_id());
			kq = ps.executeUpdate();
		} catch (Exception e) {
			System.out.println("update " + e);
		}finally {
        	try {
				ConnectionPoolImpl.getInstance().releaseConnection(this.con, "floor");
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		return kq;
	}

	@Override
	public int delete(floor t) {
		int kq = 0;
		String sql = "DELETE FROM floor WHERE floor_id = ?";
		try {
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setInt(1, t.getFloor_id());
			kq = ps.executeUpdate();
		} catch (Exception e) {
			System.out.println("delete " + e);
		}finally {
        	try {
				ConnectionPoolImpl.getInstance().releaseConnection(this.con, "floor");
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		return kq;
	}

	@Override
	public ArrayList<floor> selectAll() {
		ArrayList<floor> list = new ArrayList<>();
		String sql = "SELECT * FROM floor";
		try {
			PreparedStatement ps = con.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				floor f = new floor();
				f.setFloor_id(rs.getInt("floor_id"));
				f.setFloor_name(rs.getString("floor_name"));
				f.setFloor_description(rs.getString("floor_description"));
				list.add(f);
			}
		} catch (Exception e) {
			System.out.println("selectAll " + e);
		}finally {
        	try {
				ConnectionPoolImpl.getInstance().releaseConnection(this.con, "floor");
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		return list;
	}

	@Override
	public floor selectById(int id) {
		floor f = null;
		String sql = "SELECT * FROM floor WHERE floor_id = ?";
		try {
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setInt(1, id);
			ResultSet rs = ps.executeQuery();
			if (rs.next()) {
				f = new floor();
				f.setFloor_id(rs.getInt("floor_id"));
				f.setFloor_name(rs.getString("floor_name"));
				f.setFloor_description(rs.getString("floor_description"));
			}
		} catch (Exception e) {
			System.out.println("selectById " + e);
		}finally {
        	try {
				ConnectionPoolImpl.getInstance().releaseConnection(this.con, "floor");
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		return f;
	}

	@Override
	public ArrayList<floor> selectByCondition(String condition) {
		ArrayList<floor> list = new ArrayList<>();
		String sql = "SELECT * FROM floor WHERE " + condition;
		try {
			PreparedStatement ps = con.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				floor f = new floor();
				f.setFloor_id(rs.getInt("floor_id"));
				f.setFloor_name(rs.getString("floor_name"));
				f.setFloor_description(rs.getString("floor_description"));
				list.add(f);
			}
		} catch (Exception e) {
			System.out.println("selectByCondition " + e);
		}finally {
        	try {
				ConnectionPoolImpl.getInstance().releaseConnection(this.con, "floor");
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		return list;
	}
	
	
	
}
