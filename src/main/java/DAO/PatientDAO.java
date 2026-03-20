package DAO;

import java.sql.*;
import java.util.*;

import Connection.GetConnection;
import POJO.PatientPOJO;

public class PatientDAO {

	private Connection getConnection() {
		return new GetConnection().GetConnection();
	}

	public List<PatientPOJO> getAllPatients() {
		List<PatientPOJO> list = new ArrayList<>();

		String sql = "SELECT * FROM Patient ORDER BY Registration_Date DESC";

		try (Connection con = getConnection();
				PreparedStatement ps = con.prepareStatement(sql);
				ResultSet rs = ps.executeQuery()) {

			while (rs.next()) {

				PatientPOJO p = new PatientPOJO();

				p.setPatient_ID(rs.getInt("Patient_ID"));
				p.setFirst_Name(rs.getString("First_Name"));
				p.setLast_Name(rs.getString("Last_Name"));
				p.setGender(rs.getString("Gender"));
				p.setDob(rs.getDate("DOB"));
				p.setContact_Number(rs.getString("Contact_Number"));
				p.setAddress(rs.getString("Address"));
				p.setEmail(rs.getString("Email"));
				p.setBlood_Group(rs.getString("Blood_Group"));
				p.setRegistration_Date(rs.getDate("Registration_Date"));

				list.add(p);
			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		return list;
	}

	public boolean deletePatient(int id) {
		try (Connection con = getConnection();
				PreparedStatement ps = con.prepareStatement("DELETE FROM Patient WHERE Patient_ID=?")) {

			ps.setInt(1, id);
			return ps.executeUpdate() > 0;

		} catch (Exception e) {
			e.printStackTrace();
		}
		return false;
	}
}