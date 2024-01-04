package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import entity.User;
import sql.connection.DBConnection;

public class UserDAO {
	public boolean doLogin(String username, String password) throws SQLException {

		Connection connection = DBConnection.makeConnection();

		String sql = "SELECT * FROM user WHERE username = ?";

		PreparedStatement preStmt = connection.prepareStatement(sql);
		preStmt.setString(1, username);

		ResultSet resultSet = preStmt.executeQuery();

		if (!resultSet.next()) {
			return false;
		}

		User user = new User();
		user.setUsername(resultSet.getString("username"));
		user.setPassword(resultSet.getString("password"));
		user.setEmail(resultSet.getString("email"));
		user.setFailedCount(resultSet.getInt("failedCount"));

		if (!user.getPassword().equals(password)) {
			updateFailedCount(user.getUsername());
			return false;
		}

		if (user.getFailedCount() >= 4) {

			return false;
		}

		return true;
	}

	public void updateFailedCount(String username) throws SQLException {
		Connection connection = DBConnection.makeConnection();
		String sql = "UPDATE user SET `failedCount` = failedCount + 1 WHERE username = ?";

		PreparedStatement preStmt = connection.prepareStatement(sql);
		preStmt.setString(1, username);

		preStmt.executeUpdate();

	}

	public User findUser(String username) throws SQLException {
		Connection connection = DBConnection.makeConnection();
		String sql = "SELECT * FROM user WHERE username = ?";
		PreparedStatement preStmt = connection.prepareStatement(sql);
		preStmt.setString(1, username);
		ResultSet resultSet = preStmt.executeQuery();

		if (resultSet.next()) {
			User user = new User();
			user.setUsername(resultSet.getString("username"));
			user.setPassword(resultSet.getString("password"));
			user.setEmail(resultSet.getString("email"));
			user.setFailedCount(resultSet.getInt("failedCount"));
			return user;
		}
		return null;

	}
}
