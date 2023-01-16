package counter.dao;

import java.sql.*;

public class DatabaseConnect {
	public static Connection getConnection() {
		Connection con=null;
		try {
			con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "admin", "admin");
			if (con != null) {
				System.out.println("Connection Success");
			}
		} catch (SQLException ex) {

			System.out.println("Failed to create the database connection.");
		}
		return con;
	}
}