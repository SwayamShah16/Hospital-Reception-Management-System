package DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import POJO.UserPOJO;
import Connection.GetConnection;

public class UserDAO {

	// LOGIN METHOD
	public UserPOJO login(String username, String password, String role) {
		UserPOJO user = null;

		try {

			Connection con = GetConnection.getConnection();

			if (con == null) {
				System.out.println("Database connection failed");
				return null;
			}

			String query = "SELECT * FROM users WHERE username=? AND password=? AND role=?";

			PreparedStatement ps = con.prepareStatement(query);

			ps.setString(1, username);
			ps.setString(2, password);
			ps.setString(3, role);

			ResultSet rs = ps.executeQuery();

			if (rs.next()) {

				user = new UserPOJO();

				user.setUserId(rs.getInt("user_id"));
				user.setUsername(rs.getString("username"));
				user.setRole(rs.getString("role"));
			}

			rs.close();
			ps.close();
			con.close();

		} catch (Exception e) {
			e.printStackTrace();
		}

		return user;
	}

	// REGISTER METHOD
	public boolean registerUser(UserPOJO user) {

		boolean status = false;

		try {

			Connection con = GetConnection.getConnection();

			String query = "INSERT INTO users(username,password,role) VALUES(?,?,?)";

			PreparedStatement ps = con.prepareStatement(query);

			ps.setString(1, user.getUsername());
			ps.setString(2, user.getPassword());
			ps.setString(3, user.getRole());

			int rows = ps.executeUpdate();

			if (rows > 0) {
				status = true;
			}

			ps.close();
			con.close();

		} catch (Exception e) {
			e.printStackTrace();
		}

		return status;
	}
}