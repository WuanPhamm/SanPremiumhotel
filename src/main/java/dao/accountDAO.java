package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;

import model.cus_wallet;
import model.account;
import model.customer;
import model.user;
import util.ConnectionPoolImpl;
//import util.JDBCUtil;

public class accountDAO implements daoInterface<account> {

	private Connection con;
	
	public accountDAO() {
		try {
			this.con = ConnectionPoolImpl.getInstance().getConnection("account");
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
    public static accountDAO getIns(){
        return new accountDAO();
    }

    @Override
    public int insert(account t) {
        int kq = 0;
        try {
            String sql = "INSERT INTO account (acc_username, acc_password, acc_status, role_id) VALUES (?, ?, ?, ?)";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, t.getAcc_username());
            ps.setString(2, t.getAcc_password());
            ps.setInt(3, t.getAcc_status());
            ps.setInt(4, t.getRole_id());
            
            kq = ps.executeUpdate();
            int account_id = accountDAO.getIns().findByUsername(t.getAcc_username());
            t.setAcc_id(account_id);
            
            if(kq == 1) {
            	if(t.getRole_id() == 1) {
            		user u = new user(0, t.getAcc_username(), null, "", 0, "", "", "", t.getAcc_id());
            		 
            		kq = userDAO.getInstance().insert(u);
            	}else if(t.getRole_id() == 2) {
            		customer cus = new customer(0, t.getAcc_username(), t.getAcc_username(), null, 0, "", "", "", "", 0,"images/anhdaidien.jpg", account_id);
            		cus_wallet cw = new cus_wallet(0,account_id,null,0);
            		cus_walletDAO.getInstance().insert(cw);
            		kq = customerDAO.getIns().insert(cus);
            	}
            }
        } catch (Exception e) {
            System.out.println("insert account " + e);
        }finally {
        	try {
				ConnectionPoolImpl.getInstance().releaseConnection(this.con, "account");
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
        return kq;
    }
    
    public static String getEmailPrefix(String email) {
        if (email == null) return "";
        int atIndex = email.indexOf("@");
        if (atIndex == -1) return email; // Không có '@' thì trả lại nguyên chuỗi
        return email.substring(0, atIndex);
    }
    
    public int insertAccGoogle(account t) {
        int kq = 0;
        try {
            String sql = "INSERT INTO account (acc_username, acc_password, acc_status, role_id) VALUES (?, ?, ?, ?)";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, t.getAcc_username());
            ps.setString(2, t.getAcc_password());
            ps.setInt(3, t.getAcc_status());
            ps.setInt(4, t.getRole_id());
            
            kq = ps.executeUpdate();
            int account_id = accountDAO.getIns().findByUsername(t.getAcc_username());
            t.setAcc_id(account_id);
            
            
            if(kq == 1) {
            	
            	String userName = getEmailPrefix(t.getAcc_username());
            	
            	if(t.getRole_id() == 1) {
            		user u = new user(0, userName, null, "", 0, "", "", "", t.getAcc_id());
            		 
            		kq = userDAO.getInstance().insert(u);
            	}else if(t.getRole_id() == 2) {
            		customer cus = new customer(0, "", userName, null, 0, "", "", "", "", 0,"images/anhdaidien.jpg", account_id);
            		
            		kq = customerDAO.getIns().insert(cus);
            	}
            }
        } catch (Exception e) {
            System.out.println("insert account " + e);
        }finally {
        	try {
				ConnectionPoolImpl.getInstance().releaseConnection(this.con, "account");
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
        return kq;
    }
    
    public int insertIgnore(ArrayList<account> list) {
        int kq = 0;
    	int l = list.size();
    	
        try {
        	StringBuilder bsql = new StringBuilder("INSERT IGNORE INTO account (acc_username, acc_password, role_id) VALUES");
        	
        	for(int i = 0; i < l - 1; i++) {
        		bsql.append("(?,?,?),");
        	}
        	bsql.append("(?,?,?);");
        	
        	String sql = bsql.toString();
            PreparedStatement ps = con.prepareStatement(sql);
            
            for(int i = 0; i < l; i++) {
                ps.setString(3 * i + 1, list.get(i).getAcc_username());
                ps.setString(3 * i + 2, list.get(i).getAcc_password());
                ps.setInt(3 * i + 3, list.get(i).getRole_id());
            }
            
            kq = ps.executeUpdate();
            
            ArrayList<user> list_user = new ArrayList<>();
            ArrayList<customer> list_cus = new ArrayList<>();
            
            for(int i = 0; i < l; i++) {
            	String u_name = list.get(i).getAcc_username();
            	int acc_id = accountDAO.getIns().findByUsername(u_name);
            	if(list.get(i).getRole_id() == 1) {
            		user u = new user(0, u_name, null, "", 0, "", "","", acc_id);
            		list_user.add(u);
            	}else if(list.get(i).getRole_id() == 2) {
            		System.out.println("Add cus");
            		customer cus = new customer(0, u_name,u_name, null, 0, "", "", "", "", 0,"", acc_id);
            		list_cus.add(cus);
            	}
            }
            
            customerDAO.getIns().insertIgnore(list_cus);
            userDAO.getInstance().insertIgnore(list_user);
            
        } catch (Exception e) {
            System.out.println("insert ignore account " + e);
        }finally {
        	try {
				ConnectionPoolImpl.getInstance().releaseConnection(this.con, "account");
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
        return kq;
    }

    @Override
    public int update(account t) {
        int kq = 0;
        try {
            String sql = "UPDATE account SET acc_username = ?, acc_password = ?, acc_status = ?, role_id = ?, "
            		+ "acc_last_login_at = ? , acc_updated_at = CURRENT_TIMESTAMP "
            		+ "WHERE acc_id = ?";
            //Connection con = JDBCUtil.getConn();
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, t.getAcc_username());
            ps.setString(2, t.getAcc_password());
            ps.setInt(3, t.getAcc_status());
            ps.setInt(4, t.getRole_id());
            ps.setTimestamp(5, t.getAcc_last_login_at());
            
            ps.setInt(6, t.getAcc_id());
            
            kq = ps.executeUpdate();
        } catch (Exception e) {
            System.out.println("update account " + e);
        }finally {
        	try {
				ConnectionPoolImpl.getInstance().releaseConnection(this.con, "account");
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
        return kq;
    }

    @Override
    public ArrayList<account> selectAll() {
        ArrayList<account> accounts = new ArrayList<>();
        try {
            String sql = "SELECT * FROM account";
            //Connection con = JDBCUtil.getConn();
            PreparedStatement ps = con.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                account acc = new account();
                acc.setAcc_id(rs.getInt("acc_id"));
                acc.setAcc_username(rs.getString("acc_username"));
                acc.setAcc_password(rs.getString("acc_password"));
                acc.setAcc_status(rs.getInt("acc_status"));
                acc.setAcc_created_at(rs.getTimestamp("acc_created_at"));
                acc.setAcc_updated_at(rs.getTimestamp("acc_updated_at"));
                acc.setAcc_last_login_at(rs.getTimestamp("acc_last_login_at"));
                acc.setAcc_login_time(rs.getInt("acc_login_time"));
                acc.setRole_id(rs.getInt("role_id"));
                accounts.add(acc);
            }
        } catch (Exception e) {
            System.out.println("selectAll account " + e);
        }finally {
        	try {
				ConnectionPoolImpl.getInstance().releaseConnection(this.con, "account");
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
        return accounts;
    }

    @Override
    public account selectById(int id) {
        account acc = null;
        try {
            String sql = "SELECT * FROM account WHERE acc_id = ?";
            //Connection con = JDBCUtil.getConn();
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                acc = new account();
                acc.setAcc_id(rs.getInt("acc_id"));
                acc.setAcc_username(rs.getString("acc_username"));
                acc.setAcc_password(rs.getString("acc_password"));
                acc.setAcc_status(rs.getInt("acc_status"));
                acc.setAcc_created_at(rs.getTimestamp("acc_created_at"));
                acc.setAcc_updated_at(rs.getTimestamp("acc_updated_at"));
                acc.setAcc_last_login_at(rs.getTimestamp("acc_last_login_at"));
                acc.setAcc_login_time(rs.getInt("acc_login_time"));
                acc.setRole_id(rs.getInt("role_id"));
            }
        } catch (Exception e) {
            System.out.println("selectById account " + e);
        }finally {
        	try {
				ConnectionPoolImpl.getInstance().releaseConnection(this.con, "account");
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
        return acc;
    }

    @Override
    public ArrayList<account> selectByCondition(String condition) {
        ArrayList<account> accounts = new ArrayList<>();
        try {
            String sql = "SELECT * FROM account WHERE " + condition;
            //Connection con = JDBCUtil.getConn();
            PreparedStatement ps = con.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                account acc = new account();
                acc.setAcc_id(rs.getInt("acc_id"));
                acc.setAcc_username(rs.getString("acc_username"));
                acc.setAcc_password(rs.getString("acc_password"));
                acc.setAcc_status(rs.getInt("acc_status"));
                acc.setAcc_created_at(rs.getTimestamp("acc_created_at"));
                acc.setAcc_updated_at(rs.getTimestamp("acc_updated_at"));
                acc.setAcc_last_login_at(rs.getTimestamp("acc_last_login_at"));
                acc.setAcc_login_time(rs.getInt("acc_login_time"));
                acc.setRole_id(rs.getInt("role_id"));
                accounts.add(acc);
            }
        } catch (Exception e) {
            System.out.println("selectByCondition account " + e);
        }finally {
        	try {
				ConnectionPoolImpl.getInstance().releaseConnection(this.con, "account");
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
        return accounts;
    }

    // Cập nhật thời gian đăng nhập khi người dùng đăng nhập
    public int updateLastLogin(account t) {
        int kq = 0;
        try {
            String sql = "UPDATE account SET acc_updated_at = ?, acc_login_time = ? WHERE acc_id = ?";
            //Connection con = JDBCUtil.getConn();
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setTimestamp(1, t.getAcc_updated_at());
            ps.setInt(2, t.getAcc_login_time() + 1);
            ps.setInt(3, t.getAcc_id()); // Sử dụng account_id để xác định người dùng
            kq = ps.executeUpdate();
        } catch (Exception e) {
            System.out.println("updateLastLogin account " + e);
        }finally {
        	try {
				ConnectionPoolImpl.getInstance().releaseConnection(this.con, "account");
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
        return kq;
    }
    
    public account findByUsernameAndPassword(String username, String password) {
        account acc = null;
        String sql = "SELECT * FROM account WHERE acc_username = ? AND acc_password = ?";
        try (
        	//Connection con = JDBCUtil.getConn();
            PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, username);
            ps.setString(2, password);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                acc = new account(
                    rs.getInt("acc_id"),
                    rs.getString("acc_username"),
                    rs.getString("acc_password"),
                    rs.getInt("acc_status"),
                    rs.getTimestamp("acc_created_at"),
                    rs.getTimestamp("acc_updated_at"),
                    rs.getTimestamp("acc_last_login_at"),
                    rs.getInt("acc_login_time"),
                    rs.getInt("role_id")
                );
            }
        } catch (Exception e) {
            System.out.println("findByUsernameAndPassword: " + e.getMessage());
        }finally {
        	try {
				ConnectionPoolImpl.getInstance().releaseConnection(this.con, "account");
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
        return acc;
    }
    
    public account findAccByUsername(String username) {
        account acc = null;
        String sql = "SELECT * FROM account WHERE acc_username = ? ";
        try (
        	//Connection con = JDBCUtil.getConn();
            PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, username);
            
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                acc = new account(
                    rs.getInt("acc_id"),
                    rs.getString("acc_username"),
                    rs.getString("acc_password"),
                    rs.getInt("acc_status"),
                    rs.getTimestamp("acc_created_at"),
                    rs.getTimestamp("acc_updated_at"),
                    rs.getTimestamp("acc_last_login_at"),
                    rs.getInt("acc_login_time"),
                    rs.getInt("role_id")
                );
            }
        } catch (Exception e) {
            System.out.println("findAccByUsername: " + e.getMessage());
        }finally {
        	try {
				ConnectionPoolImpl.getInstance().releaseConnection(this.con, "account");
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
        return acc;
    }
    
    public int findByUsername(String username) {
        int accountId = 0; 
        String sql = "SELECT acc_id FROM account WHERE acc_username = ?";
        try (
        	 //Connection con = JDBCUtil.getConn();
             PreparedStatement ps = con.prepareStatement(sql)) {
            
            ps.setString(1, username);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                accountId = rs.getInt("acc_id");
            }
        } catch (Exception e) {
            System.out.println("findByUsername " + e);
        }finally {
        	try {
				ConnectionPoolImpl.getInstance().releaseConnection(this.con, "account");
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
        return accountId;
    }
    
    @Override
    public int delete(account t) {
        int kq = 0;
        try {
            String sql = "DELETE FROM account WHERE acc_id = ?";
            //Connection con = JDBCUtil.getConn();
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, t.getAcc_id());
            
            kq = ps.executeUpdate();
        } catch (Exception e) {
            System.out.println("delete account " + e);
        }finally {
        	try {
				ConnectionPoolImpl.getInstance().releaseConnection(this.con, "account");
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
        return kq;
    }
    
    public int xoa_khoiphuc(int account_id, int account_status) {
        int kq = 0;
        try {
            String sql = "UPDATE account SET acc_status = ? WHERE acc_id = ?";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, account_status);
            ps.setInt(2, account_id);
            
            kq = ps.executeUpdate();
        } catch (Exception e) {
            System.out.println("xoa khoi phuc account " + e);
        }finally {
        	try {
				ConnectionPoolImpl.getInstance().releaseConnection(this.con, "account");
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
        return kq;
    }


}
