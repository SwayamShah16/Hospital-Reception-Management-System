package DAO;

import java.sql.*;
import java.util.*;
import Controller.*;
import POJO.AppointmentPOJO;
import POJO.DoctorPOJO;
import POJO.PatientPOJO;
import POJO.ReceptionistPOJO;

public class AppointmentDAO {

	private String url = "jdbc:mysql://localhost:3306/hospital";
	private String user = "root";
	private String password = "";

	private Connection getConnection() throws Exception {
		Class.forName("com.mysql.cj.jdbc.Driver");
		return DriverManager.getConnection(url, user, password);
	}

	// --- Add Appointment ---
	public void addAppointment(AppointmentPOJO a) throws Exception {
		String sql = "INSERT INTO Appointment(Patient_ID, Doctor_ID, Receptionist_ID, Appointment_Date, Appointment_Time, Priority, Remarks) VALUES (?,?,?,?,?,?,?)";
		try (Connection con = getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {
			ps.setInt(1, a.getPatientId());
			ps.setInt(2, a.getDoctorId());
			ps.setInt(3, a.getReceptionistId());
			ps.setDate(4, a.getAppointmentDate());
			ps.setTime(5, a.getAppointmentTime());
			ps.setString(6, a.getPriority());
			ps.setString(7, a.getRemarks());
			ps.executeUpdate();
		}
	}

	// --- Update Appointment ---
	public void updateAppointment(AppointmentPOJO a) throws Exception {
		String sql = "UPDATE Appointment SET Patient_ID=?, Doctor_ID=?, Receptionist_ID=?, Appointment_Date=?, Appointment_Time=?, Priority=?, Remarks=? WHERE Appointment_ID=?";
		try (Connection con = getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {
			ps.setInt(1, a.getPatientId());
			ps.setInt(2, a.getDoctorId());
			ps.setInt(3, a.getReceptionistId());
			ps.setDate(4, a.getAppointmentDate());
			ps.setTime(5, a.getAppointmentTime());
			ps.setString(6, a.getPriority());
			ps.setString(7, a.getRemarks());
			ps.setInt(8, a.getAppointmentId());
			ps.executeUpdate();
		}
	}

	// --- Delete Appointment ---
	public void deleteAppointment(int id) throws Exception {
		String sql = "DELETE FROM payment WHERE Appointment_ID = ?;\r\n"
				+ "DELETE FROM appointment WHERE Appointment_ID = ?;";
		try (Connection con = getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {
			ps.setInt(1, id);
			ps.executeUpdate();
		}
	}

	// --- Get Appointment by ID ---
	public AppointmentPOJO getAppointmentById(int id) throws Exception {
		String sql = "SELECT * FROM Appointment WHERE Appointment_ID=?";
		try (Connection con = getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {
			ps.setInt(1, id);
			ResultSet rs = ps.executeQuery();
			if (rs.next()) {
				AppointmentPOJO a = new AppointmentPOJO();
				a.setAppointmentId(rs.getInt("Appointment_ID"));
				a.setPatientId(rs.getInt("Patient_ID"));
				a.setDoctorId(rs.getInt("Doctor_ID"));
				a.setReceptionistId(rs.getInt("Receptionist_ID"));
				a.setAppointmentDate(rs.getDate("Appointment_Date"));
				a.setAppointmentTime(rs.getTime("Appointment_Time"));
				a.setPriority(rs.getString("Priority"));
				a.setRemarks(rs.getString("Remarks"));
				return a;
			}
		}
		return null;
	}

	// --- Get All Appointments with optional search ---
	public List<AppointmentPOJO> getAllAppointments(String keyword) throws Exception {
		List<AppointmentPOJO> list = new ArrayList<>();
		String sql = "SELECT a.* FROM Appointment a " + "JOIN Patient p ON a.Patient_ID=p.Patient_ID "
				+ "JOIN Doctor d ON a.Doctor_ID=d.Doctor_ID "
				+ "WHERE p.First_Name LIKE ? OR p.Last_Name LIKE ? OR d.Name LIKE ? "
				+ "ORDER BY CASE Priority WHEN 'High' THEN 1 WHEN 'Normal' THEN 2 WHEN 'Low' THEN 3 END, Appointment_Date, Appointment_Time";
		try (Connection con = getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {
			String kw = "%" + keyword + "%";
			ps.setString(1, kw);
			ps.setString(2, kw);
			ps.setString(3, kw);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				AppointmentPOJO a = new AppointmentPOJO();
				a.setAppointmentId(rs.getInt("Appointment_ID"));
				a.setPatientId(rs.getInt("Patient_ID"));
				a.setDoctorId(rs.getInt("Doctor_ID"));
				a.setReceptionistId(rs.getInt("Receptionist_ID"));
				a.setAppointmentDate(rs.getDate("Appointment_Date"));
				a.setAppointmentTime(rs.getTime("Appointment_Time"));
				a.setPriority(rs.getString("Priority"));
				a.setRemarks(rs.getString("Remarks"));
				list.add(a);
			}
		}
		return list;
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