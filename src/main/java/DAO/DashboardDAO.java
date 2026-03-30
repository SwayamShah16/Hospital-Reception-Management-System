package DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import Connection.GetConnection;

public class DashboardDAO {

	public static int getPatientCount() {
		int count = 0;
		try {
			Connection con = GetConnection.getConnection();
			PreparedStatement ps = con.prepareStatement("SELECT COUNT(*) FROM patient");
			ResultSet rs = ps.executeQuery();
			if (rs.next())
				count = rs.getInt(1);
			con.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return count;
	}

	public static int getDoctorCount() {
		int count = 0;
		try {
			Connection con = GetConnection.getConnection();
			PreparedStatement ps = con.prepareStatement("SELECT COUNT(*) FROM doctor");
			ResultSet rs = ps.executeQuery();
			if (rs.next())
				count = rs.getInt(1);
			con.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return count;
	}

	public static int getAppointmentCount() {
		int count = 0;
		try {
			Connection con = GetConnection.getConnection();
			PreparedStatement ps = con.prepareStatement("SELECT COUNT(*) FROM appointment");
			ResultSet rs = ps.executeQuery();
			if (rs.next())
				count = rs.getInt(1);
			con.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return count;
	}

	public static double getTotalRevenue() {
		double total = 0;
		try {
			Connection con = GetConnection.getConnection();
			PreparedStatement ps = con.prepareStatement("SELECT SUM(amount) FROM payment");
			ResultSet rs = ps.executeQuery();
			if (rs.next())
				total = rs.getDouble(1);
			con.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return total;
	}

	public static int getStaffCount() {
		int count = 0;
		try {
			Connection con = GetConnection.getConnection();
			PreparedStatement ps = con.prepareStatement("SELECT COUNT(*) FROM staff");
			ResultSet rs = ps.executeQuery();
			if (rs.next())
				count = rs.getInt(1);
			con.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return count;
	}

	public static int getRoomCount() {
		int count = 0;
		try {
			Connection con = GetConnection.getConnection();
			PreparedStatement ps = con.prepareStatement("SELECT COUNT(*) FROM room");
			ResultSet rs = ps.executeQuery();
			if (rs.next())
				count = rs.getInt(1);
			con.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return count;
	}

	public static void addActivity(String action) {
		try {
			Connection con = GetConnection.getConnection();

			PreparedStatement ps = con.prepareStatement("INSERT INTO activity_log(action) VALUES (?)");

			ps.setString(1, action);
			ps.executeUpdate();

			con.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public static List<String> getActivities() {

		List<String> list = new ArrayList<>();

		try {
			Connection con = GetConnection.getConnection();

			PreparedStatement ps = con
					.prepareStatement("SELECT action, created_at FROM activity_log ORDER BY id DESC LIMIT 5");

			ResultSet rs = ps.executeQuery();

			while (rs.next()) {
				String activity = rs.getString("action") + " (" + rs.getTimestamp("created_at") + ")";
				list.add(activity);
			}

			con.close();
		} catch (Exception e) {
			e.printStackTrace();
		}

		return list;
	}

	public static List<String> getAllActivities() {

		List<String> list = new ArrayList<>();

		try {
			Connection con = GetConnection.getConnection();

			PreparedStatement ps = con.prepareStatement("SELECT action, created_at FROM activity_log ORDER BY id DESC");

			ResultSet rs = ps.executeQuery();

			while (rs.next()) {
				list.add(rs.getString("action") + " (" + rs.getTimestamp("created_at") + ")");
			}

			con.close();
		} catch (Exception e) {
			e.printStackTrace();
		}

		return list;
	}
}