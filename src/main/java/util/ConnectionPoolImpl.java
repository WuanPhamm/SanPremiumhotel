package util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Stack;

public class ConnectionPoolImpl implements ConnectionPool {
	// Trình điều khiển làm việc
	private String driver;

	// Tài khoản kết nối
	private String username;
	private String password;

	// Đường dẫn thực thi
	private String url;

	// Đối tượng lưu trữ kết nối
	private Stack<Connection> pool;

	private static volatile ConnectionPool CP;

	public ConnectionPoolImpl() {
		// Xác định trình điều khiển
		this.driver = "com.mysql.cj.jdbc.Driver";

		// Nạp trình điều khiển
		try {
			Class.forName(this.driver);
		} catch (ClassNotFoundException e) {
			e.addSuppressed(e);
		}

		// Xác định tài khoản
		this.username = "root";
		this.password = "123456";

		// Xác nhận đường dẫn thực thi
		this.url = "jdbc:mysql://localhost:3306/hoteln4?allowMultiQueries=true";

		// Khởi tạo bộ nhớ đối tượng lưu trữ
		this.pool = new Stack<>();
	}

	@Override
	public Connection getConnection(String objectName) throws SQLException {
		if (this.pool.isEmpty()) {
			System.out.println(objectName + " đã khởi tạo một kết nối mới.");
			return DriverManager.getConnection(this.url, this.username, this.password);
		} else {
			System.out.println(objectName + " đã lấy ra 1 kết nối.");
			return this.pool.pop();
		}
	}

	@Override
	public void releaseConnection(Connection con, String objectName) throws SQLException {
		System.out.println(objectName + " đã trả về một kết nối.");
		this.pool.push(con);
	}

	@Override
	protected void finalize() throws Throwable {
		
		this.pool.clear();

		this.pool = null;

		System.out.println("CPool is Closed!");
	}

	public static ConnectionPool getInstance() {
		if (CP == null) {
			synchronized (ConnectionPoolImpl.class) {
				if (CP == null) {
					CP = new ConnectionPoolImpl();
				}
			}
		}
		return CP;
	}

}
