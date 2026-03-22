package DAO;

import java.sql.*;
import java.util.*;

import Connection.GetConnection;
import POJO.DoctorPOJO;

public class DoctorDAO {

	private Connection con;

	public DoctorDAO() {
		con = GetConnection.getConnection();
	}

	// ✅ ADD
	public boolean addDoctor(DoctorPOJO d) {
		try {
			String sql = "INSERT INTO doctor (name, specialization, contact_number, email, consultation_fee, availability_status) VALUES (?, ?, ?, ?, ?, ?)";
			PreparedStatement ps = con.prepareStatement(sql);

			ps.setString(1, d.getName());
			ps.setString(2, d.getSpecialization());
			ps.setString(3, d.getContact_Number());
			ps.setString(4, d.getEmail());
			ps.setDouble(5, d.getConsultation_Fee());
			ps.setString(6, d.getAvailability_Status());

			return ps.executeUpdate() > 0;

		} catch (Exception e) {
			e.printStackTrace();
		}
		return false;
	}

	// ✅ GET ALL
	public List<DoctorPOJO> getAllDoctors() {
		List<DoctorPOJO> list = new ArrayList<>();

		try {
			String sql = "SELECT * FROM doctor";
			PreparedStatement ps = con.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();

			while (rs.next()) {
				list.add(new DoctorPOJO(rs.getInt("doctor_id"), rs.getString("name"), rs.getString("specialization"),
						rs.getString("contact_number"), rs.getString("email"), rs.getDouble("consultation_fee"),
						rs.getString("availability_status")));
			}

		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	// ✅ GET BY ID
	public DoctorPOJO getDoctorById(int id) {
		try {
			String sql = "SELECT * FROM doctor WHERE doctor_id=?";
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setInt(1, id);

			ResultSet rs = ps.executeQuery();

			if (rs.next()) {
				return new DoctorPOJO(rs.getInt("doctor_id"), rs.getString("name"), rs.getString("specialization"),
						rs.getString("contact_number"), rs.getString("email"), rs.getDouble("consultation_fee"),
						rs.getString("availability_status"));
			}

		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	// ✅ UPDATE
	public boolean updateDoctor(DoctorPOJO d) {
		try {
			String sql = "UPDATE doctor SET name=?, specialization=?, contact_number=?, email=?, consultation_fee=?, availability_status=? WHERE doctor_id=?";
			PreparedStatement ps = con.prepareStatement(sql);

			ps.setString(1, d.getName());
			ps.setString(2, d.getSpecialization());
			ps.setString(3, d.getContact_Number());
			ps.setString(4, d.getEmail());
			ps.setDouble(5, d.getConsultation_Fee());
			ps.setString(6, d.getAvailability_Status());
			ps.setInt(7, d.getDoctor_ID());

			return ps.executeUpdate() > 0;

		} catch (Exception e) {
			e.printStackTrace();
		}
		return false;
	}

	// ✅ DELETE
	public boolean deleteDoctor(int id) {
		try {
			String sql = "DELETE FROM doctor WHERE doctor_id=?";
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setInt(1, id);

			return ps.executeUpdate() > 0;

		} catch (Exception e) {
			e.printStackTrace();
		}
		return false;
	}

	// ✅ FILTER
	public List<DoctorPOJO> filterDoctors(String specialization, String availability) {
		List<DoctorPOJO> list = new ArrayList<>();

		try {
			String sql = "SELECT * FROM doctor WHERE 1=1";

			if (specialization != null && !specialization.isEmpty()) {
				sql += " AND specialization=?";
			}
			if (availability != null && !availability.isEmpty()) {
				sql += " AND availability_status=?";
			}

			PreparedStatement ps = con.prepareStatement(sql);

			int i = 1;
			if (specialization != null && !specialization.isEmpty()) {
				ps.setString(i++, specialization);
			}
			if (availability != null && !availability.isEmpty()) {
				ps.setString(i++, availability);
			}

			ResultSet rs = ps.executeQuery();

			while (rs.next()) {
				list.add(new DoctorPOJO(rs.getInt("doctor_id"), rs.getString("name"), rs.getString("specialization"),
						rs.getString("contact_number"), rs.getString("email"), rs.getDouble("consultation_fee"),
						rs.getString("availability_status")));
			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		return list;
	}
}