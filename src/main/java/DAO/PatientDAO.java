package DAO;

import java.sql.*;
import java.util.*;
import POJO.PatientPOJO;
import Connection.GetConnection;

public class PatientDAO {

	// ADD
	public boolean addPatient(PatientPOJO p) {
		try (Connection con = GetConnection.getConnection()) {

			String sql = "INSERT INTO Patient(First_Name, Last_Name, Gender, DOB, Contact_Number, Address, Email, Blood_Group, Registration_Date) VALUES(?,?,?,?,?,?,?,?,?)";

			PreparedStatement ps = con.prepareStatement(sql);

			ps.setString(1, p.getFirstName());
			ps.setString(2, p.getLastName());
			ps.setString(3, p.getGender());
			ps.setDate(4, p.getDob());
			ps.setString(5, p.getContactNumber());
			ps.setString(6, p.getAddress());
			ps.setString(7, p.getEmail());
			ps.setString(8, p.getBloodGroup());
			ps.setDate(9, p.getRegistrationDate());

			return ps.executeUpdate() > 0;

		} catch (Exception e) {
			e.printStackTrace();
		}
		return false;
	}

	// GET ALL
	public List<PatientPOJO> getAllPatients() {
		List<PatientPOJO> list = new ArrayList<>();

		try (Connection con = GetConnection.getConnection()) {
			Statement st = con.createStatement();
			ResultSet rs = st.executeQuery("SELECT * FROM Patient");

			while (rs.next()) {
				PatientPOJO p = new PatientPOJO();

				p.setPatientId(rs.getInt("Patient_ID"));
				p.setFirstName(rs.getString("First_Name"));
				p.setLastName(rs.getString("Last_Name"));
				p.setGender(rs.getString("Gender"));
				p.setDob(rs.getDate("DOB"));
				p.setContactNumber(rs.getString("Contact_Number"));
				p.setAddress(rs.getString("Address"));
				p.setEmail(rs.getString("Email"));
				p.setBloodGroup(rs.getString("Blood_Group"));

				list.add(p);
			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		return list;
	}

	public boolean deletePatient(int id) {
		try (Connection con = GetConnection.getConnection()) {

			PreparedStatement ps = con.prepareStatement("DELETE FROM Patient WHERE Patient_ID=?");

			ps.setInt(1, id);

			return ps.executeUpdate() > 0;

		} catch (Exception e) {
			e.printStackTrace();
		}
		return false;
	}

	// GET BY ID
	public PatientPOJO getPatientById(int id) {
		PatientPOJO p = new PatientPOJO();

		try (Connection con = GetConnection.getConnection()) {

			PreparedStatement ps = con.prepareStatement("SELECT * FROM Patient WHERE Patient_ID=?");
			ps.setInt(1, id);

			ResultSet rs = ps.executeQuery();

			if (rs.next()) {
				p.setPatientId(rs.getInt("Patient_ID"));
				p.setFirstName(rs.getString("First_Name"));
				p.setLastName(rs.getString("Last_Name"));
				p.setGender(rs.getString("Gender"));
				p.setDob(rs.getDate("DOB"));
				p.setContactNumber(rs.getString("Contact_Number"));
				p.setAddress(rs.getString("Address"));
				p.setEmail(rs.getString("Email"));
				p.setBloodGroup(rs.getString("Blood_Group"));
			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		return p;
	}

	// UPDATE
	public boolean updatePatient(PatientPOJO p) {
		try (Connection con = GetConnection.getConnection()) {

			String sql = "UPDATE Patient SET First_Name=?, Last_Name=?, Gender=?, DOB=?, Contact_Number=?, Address=?, Email=?, Blood_Group=? WHERE Patient_ID=?";
			PreparedStatement ps = con.prepareStatement(sql);

			ps.setString(1, p.getFirstName());
			ps.setString(2, p.getLastName());
			ps.setString(3, p.getGender());
			ps.setDate(4, p.getDob());
			ps.setString(5, p.getContactNumber());
			ps.setString(6, p.getAddress());
			ps.setString(7, p.getEmail());
			ps.setString(8, p.getBloodGroup());
			ps.setInt(9, p.getPatientId());

			return ps.executeUpdate() > 0;

		} catch (Exception e) {
			e.printStackTrace();
		}
		return false;
	}

	public List<PatientPOJO> searchPatients(String keyword) {

		List<PatientPOJO> list = new ArrayList<>();

		try (Connection con = GetConnection.getConnection()) {

			String sql = "SELECT * FROM Patient WHERE " + "First_Name LIKE ? OR " + "Last_Name LIKE ? OR "
					+ "Contact_Number LIKE ?";

			PreparedStatement ps = con.prepareStatement(sql);

			String search = "%" + keyword + "%";

			ps.setString(1, search);
			ps.setString(2, search);
			ps.setString(3, search);

			ResultSet rs = ps.executeQuery();

			while (rs.next()) {

				PatientPOJO p = new PatientPOJO();

				p.setPatientId(rs.getInt("Patient_ID"));
				p.setFirstName(rs.getString("First_Name"));
				p.setLastName(rs.getString("Last_Name"));
				p.setGender(rs.getString("Gender"));
				p.setDob(rs.getDate("DOB"));
				p.setContactNumber(rs.getString("Contact_Number"));
				p.setAddress(rs.getString("Address"));
				p.setEmail(rs.getString("Email"));
				p.setBloodGroup(rs.getString("Blood_Group"));

				list.add(p);
			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		return list;
	}
}