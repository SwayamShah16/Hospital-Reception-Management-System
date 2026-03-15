package DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import Connection.GetConnection;
import POJO.AppointmentPOJO;

public class AppointmentDAO {

	private static final String INSERT_SQL = "INSERT INTO appointment (appointment_ID, patient_ID, doctor_ID, receptionist_ID, appointment_date, appointment_time, status, Remarks) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";

	private static final String SELECT_BY_ID_SQL = "SELECT appointment_ID, patient_ID, doctor_ID, receptionist_ID, appointment_date, appointment_time, status, Remarks FROM appointment WHERE appointment_ID = ?";

	private static final String SELECT_ALL_SQL = "SELECT appointment_ID, patient_ID, doctor_ID, receptionist_ID, appointment_date, appointment_time, status, Remarks FROM appointment";

	private static final String UPDATE_SQL = "UPDATE appointment SET patient_ID = ?, doctor_ID = ?, receptionist_ID = ?, appointment_date = ?, appointment_time = ?, status = ?, Remarks = ? WHERE appointment_ID = ?";

	private static final String DELETE_SQL = "DELETE FROM appointment WHERE appointment_ID = ?";

	private Connection getConnection() {
		return new GetConnection().GetConnection();
	}

	public boolean createAppointment(AppointmentPOJO appt) {
		try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(INSERT_SQL)) {

			ps.setInt(1, appt.getAppointment_ID());
			ps.setInt(2, appt.getPatient_ID());
			ps.setInt(3, appt.getDoctor_ID());
			ps.setInt(4, appt.getReceptionist_ID());
			ps.setInt(5, appt.getAppointment_date());
			ps.setInt(6, appt.getAppointment_time());
			ps.setString(7, appt.getStatus());
			ps.setString(8, appt.getRemarks());

			int rows = ps.executeUpdate();
			return rows > 0;
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return false;
	}

	public AppointmentPOJO getAppointmentById(int appointmentId) {
		try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(SELECT_BY_ID_SQL)) {

			ps.setInt(1, appointmentId);
			try (ResultSet rs = ps.executeQuery()) {
				if (rs.next()) {
					return mapRowToAppointment(rs);
				}
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return null;
	}

	public List<AppointmentPOJO> getAllAppointments() {
		List<AppointmentPOJO> appts = new ArrayList<>();
		try (Connection conn = getConnection();
				PreparedStatement ps = conn.prepareStatement(SELECT_ALL_SQL);
				ResultSet rs = ps.executeQuery()) {

			while (rs.next()) {
				appts.add(mapRowToAppointment(rs));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return appts;
	}

	public boolean updateAppointment(AppointmentPOJO appt) {
		try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(UPDATE_SQL)) {

			ps.setInt(1, appt.getPatient_ID());
			ps.setInt(2, appt.getDoctor_ID());
			ps.setInt(3, appt.getReceptionist_ID());
			ps.setInt(4, appt.getAppointment_date());
			ps.setInt(5, appt.getAppointment_time());
			ps.setString(6, appt.getStatus());
			ps.setString(7, appt.getRemarks());
			ps.setInt(8, appt.getAppointment_ID());

			int rows = ps.executeUpdate();
			return rows > 0;
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return false;
	}

	public boolean deleteAppointment(int appointmentId) {
		try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(DELETE_SQL)) {

			ps.setInt(1, appointmentId);
			int rows = ps.executeUpdate();
			return rows > 0;
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return false;
	}

	private AppointmentPOJO mapRowToAppointment(ResultSet rs) throws SQLException {
		int id = rs.getInt("appointment_ID");
		int patientId = rs.getInt("patient_ID");
		int doctorId = rs.getInt("doctor_ID");
		int receptionistId = rs.getInt("receptionist_ID");
		int date = rs.getInt("appointment_date");
		int time = rs.getInt("appointment_time");
		String status = rs.getString("status");
		String remarks = rs.getString("Remarks");

		return new AppointmentPOJO(id, patientId, doctorId, receptionistId, date, time, status, remarks);
	}
}

