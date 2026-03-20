package DAO;

import java.sql.*;
import java.util.*;

import Connection.GetConnection;
import POJO.PatientPOJO;

public class PatientDAO {

	private Connection getConnection() {
		return GetConnection.GetConnection();
	}

	// ✅ NON-STATIC METHOD
	public List<PatientPOJO> getAllPatients() {

		List<PatientPOJO> list = new ArrayList<>();

		try (Connection con = getConnection();
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

			System.out.println("Patients fetched from DB: " + list.size());

		} catch (Exception e) {
			e.printStackTrace();
		}

		return list;
	}

	public boolean deletePatient(int id) {

		try (Connection con = getConnection();
				PreparedStatement ps = con.prepareStatement("DELETE FROM patient WHERE patient_ID=?")) {

			ps.setInt(1, id);

			return ps.executeUpdate() > 0;

		} catch (Exception e) {
			e.printStackTrace();
		}

		return false;
	}
}