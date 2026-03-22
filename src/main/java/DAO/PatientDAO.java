package DAO;

import java.sql.*;
import java.util.*;

import Connection.GetConnection;
import POJO.PatientPOJO;

public class PatientDAO {

	private Connection getConnection() {
		return GetConnection.getConnection();
	}

	// 🔹 Get All Patients
	public List<PatientPOJO> getAllPatients() {

		List<PatientPOJO> list = new ArrayList<>();

		try (Connection con = GetConnection.getConnection();
				PreparedStatement ps = con.prepareStatement("SELECT * FROM patient");
				ResultSet rs = ps.executeQuery()) {

			while (rs.next()) {
				PatientPOJO p = new PatientPOJO();

				p.setPatient_ID(rs.getInt("patient_ID"));
				p.setFirst_Name(rs.getString("first_Name"));
				p.setLast_Name(rs.getString("last_Name"));
				p.setGender(rs.getString("gender"));
				p.setDob(rs.getDate("dob"));
				p.setContact_Number(rs.getString("contact_Number"));
				p.setAddress(rs.getString("address"));
				p.setEmail(rs.getString("email"));
				p.setBlood_Group(rs.getString("blood_Group"));
				p.setRegistration_Date(rs.getDate("registration_Date"));

				list.add(p);
			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		return list;
	}

	// 🔹 Filter Patients
	public List<PatientPOJO> getFilteredPatients(String name, String gender, String bloodGroup) {

		List<PatientPOJO> list = new ArrayList<>();
		String query = "SELECT * FROM patient WHERE 1=1";

		if (name != null && !name.trim().isEmpty()) {
			query += " AND (first_Name LIKE ? OR last_Name LIKE ?)";
		}
		if (gender != null && !gender.trim().isEmpty()) {
			query += " AND gender = ?";
		}
		if (bloodGroup != null && !bloodGroup.trim().isEmpty()) {
			query += " AND blood_Group = ?";
		}

		try (Connection con = GetConnection.getConnection(); 
				PreparedStatement ps = con.prepareStatement(query)) {

			int index = 1;

			if (name != null && !name.trim().isEmpty()) {
				ps.setString(index++, "%" + name + "%");
				ps.setString(index++, "%" + name + "%");
			}
			if (gender != null && !gender.trim().isEmpty()) {
				ps.setString(index++, gender);
			}
			if (bloodGroup != null && !bloodGroup.trim().isEmpty()) {
				ps.setString(index++, bloodGroup);
			}

			ResultSet rs = ps.executeQuery();

			while (rs.next()) {
				PatientPOJO p = new PatientPOJO();

				p.setPatient_ID(rs.getInt("patient_ID"));
				p.setFirst_Name(rs.getString("first_Name"));
				p.setLast_Name(rs.getString("last_Name"));
				p.setGender(rs.getString("gender"));
				p.setDob(rs.getDate("dob"));
				p.setContact_Number(rs.getString("contact_Number"));
				p.setAddress(rs.getString("address"));
				p.setEmail(rs.getString("email"));
				p.setBlood_Group(rs.getString("blood_Group"));
				p.setRegistration_Date(rs.getDate("registration_Date"));

				list.add(p);
			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		return list;
	}

	// 🔹 Delete
	public boolean deletePatient(int id) {

		try (Connection con = GetConnection.getConnection();
				PreparedStatement ps = con.prepareStatement("DELETE FROM patient WHERE patient_ID=?")) {

			ps.setInt(1, id);
			return ps.executeUpdate() > 0;

		} catch (Exception e) {
			e.printStackTrace();
		}

		return false;
	}
}