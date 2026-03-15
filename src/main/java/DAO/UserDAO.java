package DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import POJO.UserPOJO;
import Connection.GetConnection;

public class UserDAO {

	public static UserPOJO login(String username, String password, String role) {

		UserPOJO user = null;

		try {

			Connection con = null;
			try {
				con = GetConnection.GetConnection();
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
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

		} catch (Exception e) {
			e.printStackTrace();
		}

		return user;
	}

	public boolean registerUser(UserPOJO user) {
		// TODO Auto-generated method stub
		boolean status = false;

		try {

			Connection con = GetConnection.GetConnection();

			String query = "INSERT INTO users(username,password,role) VALUES(?,?,?)";

			PreparedStatement ps = con.prepareStatement(query);

			ps.setString(1, user.getUsername());
			ps.setString(2, user.getPassword());
			ps.setString(3, user.getRole());

			int row = ps.executeUpdate();

			if (row > 0) {
				status = true;
			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		return status;
	}
}