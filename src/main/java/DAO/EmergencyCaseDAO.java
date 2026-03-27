package DAO;

import java.sql.*;
import java.util.*;

import Connection.GetConnection;
import POJO.DoctorPOJO;
import POJO.EmergencyCasePOJO;
import POJO.PatientPOJO;
import POJO.ReceptionistPOJO;

public class EmergencyCaseDAO {

	public static Connection getConnection() throws Exception {
		return GetConnection.getConnection();
	}

	// INSERT
	public static void insertEmergency(EmergencyCasePOJO e) {
		try {
			Connection con = getConnection();

			String sql = "INSERT INTO emergency_case (Patient_ID, Emergency_Type, Severity_Level, Priority_Level, Arrival_Time, Assigned_Doctor_ID, Status) VALUES (?, ?, ?, ?, ?, ?, ?)";

			PreparedStatement ps = con.prepareStatement(sql);
			ps.setInt(1, e.getPatientId());
			ps.setString(2, e.getEmergencyType());
			ps.setString(3, e.getSeverityLevel());
			ps.setString(4, e.getPriorityLevel());
			ps.setTimestamp(5, e.getArrivalTime());
			ps.setInt(6, e.getDoctorId());
			ps.setString(7, e.getStatus());

			ps.executeUpdate();
			con.close();

		} catch (Exception ex) {
			ex.printStackTrace();
		}
	}

	// GET ALL (SORTED BY PRIORITY)
	public static List<EmergencyCasePOJO> getAllEmergencies() {
		List<EmergencyCasePOJO> list = new ArrayList<>();

		try {
			Connection con = getConnection();

			String sql = "SELECT * FROM emergency_case ORDER BY FIELD(Priority_Level,'High','Medium','Low'), Arrival_Time ASC";
			PreparedStatement ps = con.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();

			while (rs.next()) {
				EmergencyCasePOJO e = new EmergencyCasePOJO();

				e.setEmergencyId(rs.getInt("Emergency_ID"));
				e.setPatientId(rs.getInt("Patient_ID"));
				e.setEmergencyType(rs.getString("Emergency_Type"));
				e.setSeverityLevel(rs.getString("Severity_Level"));
				e.setPriorityLevel(rs.getString("Priority_Level"));
				e.setArrivalTime(rs.getTimestamp("Arrival_Time"));
				e.setDoctorId(rs.getInt("Assigned_Doctor_ID"));
				e.setStatus(rs.getString("Status"));

				list.add(e);
			}

			con.close();
		} catch (Exception ex) {
			ex.printStackTrace();
		}

		return list;
	}

	// GET BY ID
	public static EmergencyCasePOJO getEmergencyById(int id) {
		EmergencyCasePOJO e = new EmergencyCasePOJO();

		try {
			Connection con = getConnection();

			PreparedStatement ps = con.prepareStatement("SELECT * FROM emergency_case WHERE Emergency_ID=?");
			ps.setInt(1, id);
			ResultSet rs = ps.executeQuery();

			if (rs.next()) {
				e.setEmergencyId(rs.getInt("Emergency_ID"));
				e.setPatientId(rs.getInt("Patient_ID"));
				e.setEmergencyType(rs.getString("Emergency_Type"));
				e.setSeverityLevel(rs.getString("Severity_Level"));
				e.setPriorityLevel(rs.getString("Priority_Level"));
				e.setArrivalTime(rs.getTimestamp("Arrival_Time"));
				e.setDoctorId(rs.getInt("Assigned_Doctor_ID"));
				e.setStatus(rs.getString("Status"));
			}

			con.close();
		} catch (Exception ex) {
			ex.printStackTrace();
		}

		return e;
	}

	// UPDATE
	public static void updateEmergency(EmergencyCasePOJO e) {
		try {
			Connection con = getConnection();

			String sql = "UPDATE emergency_case SET Patient_ID=?, Emergency_Type=?, Severity_Level=?, Priority_Level=?, Assigned_Doctor_ID=?, Status=? WHERE Emergency_ID=?";
			PreparedStatement ps = con.prepareStatement(sql);

			ps.setInt(1, e.getPatientId());
			ps.setString(2, e.getEmergencyType());
			ps.setString(3, e.getSeverityLevel());
			ps.setString(4, e.getPriorityLevel());
			ps.setInt(5, e.getDoctorId());
			ps.setString(6, e.getStatus());
			ps.setInt(7, e.getEmergencyId());

			ps.executeUpdate();
			con.close();

		} catch (Exception ex) {
			ex.printStackTrace();
		}
	}

	// DELETE
	public static void deleteEmergency(int id) {
		try {
			Connection con = getConnection();

			PreparedStatement ps = con.prepareStatement("DELETE FROM emergency_case WHERE Emergency_ID=?");
			ps.setInt(1, id);

			ps.executeUpdate();
			con.close();

		} catch (Exception ex) {
			ex.printStackTrace();
		}
	}

	// --- Helper Methods to get Names ---
	public String getPatientName(int id) throws Exception {
		String name = "";
		String sql = "SELECT First_Name, Last_Name FROM Patient WHERE Patient_ID=?";
		try (Connection con = getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {
			ps.setInt(1, id);
			ResultSet rs = ps.executeQuery();
			if (rs.next()) {
				name = rs.getString("First_Name") + " " + rs.getString("Last_Name");
			}
		}
		return name;
	}

	public String getDoctorName(int id) throws Exception {
		String name = "";
		String sql = "SELECT Name FROM Doctor WHERE Doctor_ID=?";
		try (Connection con = getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {
			ps.setInt(1, id);
			ResultSet rs = ps.executeQuery();
			if (rs.next())
				name = rs.getString("Name");
		}
		return name;
	}

	public String getReceptionistName(int id) throws Exception {
		String name = "";
		String sql = "SELECT Name FROM Receptionist WHERE Receptionist_ID=?";
		try (Connection con = getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {
			ps.setInt(1, id);
			ResultSet rs = ps.executeQuery();
			if (rs.next())
				name = rs.getString("Name");
		}
		return name;
	}

	// --- Get all patients/doctors/receptionists for dropdowns ---
	public List<PatientPOJO> getAllPatients() throws Exception {
		List<PatientPOJO> list = new ArrayList<>();
		String sql = "SELECT * FROM Patient";
		try (Connection con = getConnection();
				PreparedStatement ps = con.prepareStatement(sql);
				ResultSet rs = ps.executeQuery()) {
			while (rs.next()) {
				PatientPOJO p = new PatientPOJO();
				p.setPatientId(rs.getInt("Patient_ID"));
				p.setFirstName(rs.getString("First_Name"));
				p.setLastName(rs.getString("Last_Name"));
				list.add(p);
			}
		}
		return list;
	}

	public List<DoctorPOJO> getAllDoctors() throws Exception {
		List<DoctorPOJO> list = new ArrayList<>();
		String sql = "SELECT * FROM Doctor";
		try (Connection con = getConnection();
				PreparedStatement ps = con.prepareStatement(sql);
				ResultSet rs = ps.executeQuery()) {
			while (rs.next()) {
				DoctorPOJO d = new DoctorPOJO();
				d.setDoctorId(rs.getInt("Doctor_ID"));
				d.setName(rs.getString("Name"));
				list.add(d);
			}
		}
		return list;
	}

	public List<ReceptionistPOJO> getAllReceptionists() throws Exception {
		List<ReceptionistPOJO> list = new ArrayList<>();
		String sql = "SELECT * FROM Receptionist";
		try (Connection con = getConnection();
				PreparedStatement ps = con.prepareStatement(sql);
				ResultSet rs = ps.executeQuery()) {
			while (rs.next()) {
				ReceptionistPOJO r = new ReceptionistPOJO();
				r.setReceptionistId(rs.getInt("Receptionist_ID"));
				r.setName(rs.getString("Name"));
				r.setUsername(rs.getString("Username"));
				r.setPassword(rs.getString("Password"));
				r.setContactNumber(rs.getString("Contact_Number"));
				r.setShiftTiming(rs.getString("Shift_Timing"));
				r.setEmail(rs.getString("Email"));
				list.add(r);
			}
		}
		return list;
	}
}