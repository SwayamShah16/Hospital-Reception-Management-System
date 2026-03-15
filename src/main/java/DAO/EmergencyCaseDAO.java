package DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import Connection.GetConnection;
import POJO.EmergencyCasePOJO;

public class EmergencyCaseDAO {

	private static final String INSERT_SQL = "INSERT INTO emergency_case (emergency_Id, patient_Id, emergency_type, severity_level, priority_level, arrival_time, assigned_doctor_ID, status) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";

	private static final String SELECT_BY_ID_SQL = "SELECT emergency_Id, patient_Id, emergency_type, severity_level, priority_level, arrival_time, assigned_doctor_ID, status FROM emergency_case WHERE emergency_Id = ?";

	private static final String SELECT_ALL_SQL = "SELECT emergency_Id, patient_Id, emergency_type, severity_level, priority_level, arrival_time, assigned_doctor_ID, status FROM emergency_case";

	private static final String UPDATE_SQL = "UPDATE emergency_case SET patient_Id = ?, emergency_type = ?, severity_level = ?, priority_level = ?, arrival_time = ?, assigned_doctor_ID = ?, status = ? WHERE emergency_Id = ?";

	private static final String DELETE_SQL = "DELETE FROM emergency_case WHERE emergency_Id = ?";

	private Connection getConnection() {
		return new GetConnection().GetConnection();
	}

	public boolean createEmergencyCase(EmergencyCasePOJO ec) {
		try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(INSERT_SQL)) {

			ps.setInt(1, ec.getEmergency_Id());
			ps.setInt(2, ec.getPatient_Id());
			ps.setString(3, ec.getEmergency_type());
			ps.setString(4, ec.getSeverity_level());
			ps.setString(5, ec.getPriority_level());
			ps.setInt(6, ec.getArrival_time());
			ps.setInt(7, ec.getAssigned_doctor_ID());
			ps.setString(8, ec.getStatus());

			int rows = ps.executeUpdate();
			return rows > 0;
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return false;
	}

	public EmergencyCasePOJO getEmergencyCaseById(int id) {
		try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(SELECT_BY_ID_SQL)) {

			ps.setInt(1, id);
			try (ResultSet rs = ps.executeQuery()) {
				if (rs.next()) {
					return mapRowToEmergencyCase(rs);
				}
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return null;
	}

	public List<EmergencyCasePOJO> getAllEmergencyCases() {
		List<EmergencyCasePOJO> list = new ArrayList<>();
		try (Connection conn = getConnection();
				PreparedStatement ps = conn.prepareStatement(SELECT_ALL_SQL);
				ResultSet rs = ps.executeQuery()) {

			while (rs.next()) {
				list.add(mapRowToEmergencyCase(rs));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return list;
	}

	public boolean updateEmergencyCase(EmergencyCasePOJO ec) {
		try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(UPDATE_SQL)) {

			ps.setInt(1, ec.getPatient_Id());
			ps.setString(2, ec.getEmergency_type());
			ps.setString(3, ec.getSeverity_level());
			ps.setString(4, ec.getPriority_level());
			ps.setInt(5, ec.getArrival_time());
			ps.setInt(6, ec.getAssigned_doctor_ID());
			ps.setString(7, ec.getStatus());
			ps.setInt(8, ec.getEmergency_Id());

			int rows = ps.executeUpdate();
			return rows > 0;
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return false;
	}

	public boolean deleteEmergencyCase(int id) {
		try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(DELETE_SQL)) {

			ps.setInt(1, id);
			int rows = ps.executeUpdate();
			return rows > 0;
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return false;
	}

	private EmergencyCasePOJO mapRowToEmergencyCase(ResultSet rs) throws SQLException {
		int emergencyId = rs.getInt("emergency_Id");
		int patientId = rs.getInt("patient_Id");
		String type = rs.getString("emergency_type");
		String severity = rs.getString("severity_level");
		String priority = rs.getString("priority_level");
		int arrivalTime = rs.getInt("arrival_time");
		int doctorId = rs.getInt("assigned_doctor_ID");
		String status = rs.getString("status");

		return new EmergencyCasePOJO(emergencyId, patientId, type, severity, priority, arrivalTime, doctorId, status);
	}
}

