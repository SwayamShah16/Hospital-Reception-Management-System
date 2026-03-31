package DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;

import Connection.GetConnection;
import POJO.ContactPOJO;

public class ContactDAO {

	public boolean saveMessage(ContactPOJO contact) {
		boolean status = false;

		try {
			Connection con = GetConnection.getConnection();

			String query = "INSERT INTO contact_messages(name,email,phone,message) VALUES (?,?,?,?)";

			PreparedStatement ps = con.prepareStatement(query);
			ps.setString(1, contact.getName());
			ps.setString(2, contact.getEmail());
			ps.setString(3, contact.getPhone());
			ps.setString(4, contact.getMessage());

			int rows = ps.executeUpdate();

			if (rows > 0) {
				status = true;
			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		return status;
	}
}