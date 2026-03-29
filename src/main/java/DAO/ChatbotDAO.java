package DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import Connection.GetConnection;

public class ChatbotDAO {

	public static String getResponse(String message) {

		String reply = "Sorry, I didn’t understand. Please contact reception.";

		try {
			Connection con = GetConnection.getConnection();

			String sql = "SELECT answer FROM chatbot_faq WHERE LOWER(question) LIKE ? LIMIT 1";
			PreparedStatement ps = con.prepareStatement(sql);

			ps.setString(1, "%" + message.toLowerCase() + "%");

			ResultSet rs = ps.executeQuery();

			if (rs.next()) {
				reply = rs.getString("answer");
			}

			con.close();

		} catch (Exception e) {
			e.printStackTrace();
		}

		return reply;
	}
}