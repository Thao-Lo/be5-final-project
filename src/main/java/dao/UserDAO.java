package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Base64;

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
		
		//decode the password
		String encodedPassword = resultSet.getString("password");
		byte[] decodedBytes = Base64.getDecoder().decode(encodedPassword);
		String decodedPassword = new String(decodedBytes);
				
		user.setPassword(decodedPassword);
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

	public void registerNewUser(String username, String email, String password) throws SQLException {
		Connection connection = DBConnection.makeConnection();
		PreparedStatement preStmt = null;

		String SQL = "INSERT INTO user (`username`, `email`, `password`) VALUES (?, ?, ?);";
		preStmt = connection.prepareStatement(SQL);

		preStmt.setString(1, username);
		preStmt.setString(2, email);
		preStmt.setString(3, password);

		preStmt.executeUpdate();

	}

	public boolean isUsernameRegistered(String username) throws SQLException {

		Connection connection = DBConnection.makeConnection();
		String sql = "SELECT COUNT(*) FROM user WHERE username = ?";
		PreparedStatement preStmt = connection.prepareStatement(sql);

		preStmt.setString(1, username);
		ResultSet resultSet = preStmt.executeQuery();

		if (resultSet.next()) {
			int count = resultSet.getInt(1);
			return count > 0;
		}
		return false;
	}

}
