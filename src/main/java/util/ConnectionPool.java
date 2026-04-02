package util;

import java.sql.Connection;
import java.sql.SQLException;

public interface ConnectionPool {
	//Xin kết nối
	public Connection getConnection(String objectName) throws SQLException;
	//Yêu cầu trả lại kết nối
	public void releaseConnection(Connection con, String objectName) throws SQLException;
}
