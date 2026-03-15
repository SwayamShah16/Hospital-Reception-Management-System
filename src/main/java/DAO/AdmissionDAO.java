package DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import Connection.GetConnection;
import POJO.AdmissionPOJO;

public class AdmissionDAO {

	private static final String INSERT_SQL = "INSERT INTO admission (admit_ID, patient_ID, room_ID, admit_date, discharge_date, doctor_ID, total_bill) VALUES (?, ?, ?, ?, ?, ?, ?)";

	private static final String SELECT_BY_ID_SQL = "SELECT admit_ID, patient_ID, room_ID, admit_date, discharge_date, doctor_ID, total_bill FROM admission WHERE admit_ID = ?";

	private static final String SELECT_ALL_SQL = "SELECT admit_ID, patient_ID, room_ID, admit_date, discharge_date, doctor_ID, total_bill FROM admission";

	private static final String UPDATE_SQL = "UPDATE admission SET patient_ID = ?, room_ID = ?, admit_date = ?, discharge_date = ?, doctor_ID = ?, total_bill = ? WHERE admit_ID = ?";

	private static final String DELETE_SQL = "DELETE FROM admission WHERE admit_ID = ?";

	private Connection getConnection() {
		return new GetConnection().GetConnection();
	}

	public boolean createAdmission(AdmissionPOJO admission) {
		try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(INSERT_SQL)) {

			ps.setInt(1, admission.getAdmit_ID());
			ps.setInt(2, admission.getPatient_ID());
			ps.setInt(3, admission.getRoom_ID());
			ps.setInt(4, admission.getAdmit_date());
			ps.setInt(5, admission.getDischarge_date());
			ps.setInt(6, admission.getDoctor_ID());
			ps.setInt(7, admission.getTotal_bill());

			int rows = ps.executeUpdate();
			return rows > 0;
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return false;
	}

	public AdmissionPOJO getAdmissionById(int admitId) {
		try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(SELECT_BY_ID_SQL)) {

			ps.setInt(1, admitId);
			try (ResultSet rs = ps.executeQuery()) {
				if (rs.next()) {
					return mapRowToAdmission(rs);
				}
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return null;
	}

	public List<AdmissionPOJO> getAllAdmissions() {
		List<AdmissionPOJO> list = new ArrayList<>();
		try (Connection conn = getConnection();
				PreparedStatement ps = conn.prepareStatement(SELECT_ALL_SQL);
				ResultSet rs = ps.executeQuery()) {

			while (rs.next()) {
				list.add(mapRowToAdmission(rs));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return list;
	}

	public boolean updateAdmission(AdmissionPOJO admission) {
		try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(UPDATE_SQL)) {

			ps.setInt(1, admission.getPatient_ID());
			ps.setInt(2, admission.getRoom_ID());
			ps.setInt(3, admission.getAdmit_date());
			ps.setInt(4, admission.getDischarge_date());
			ps.setInt(5, admission.getDoctor_ID());
			ps.setInt(6, admission.getTotal_bill());
			ps.setInt(7, admission.getAdmit_ID());

			int rows = ps.executeUpdate();
			return rows > 0;
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return false;
	}

	public boolean deleteAdmission(int admitId) {
		try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(DELETE_SQL)) {

			ps.setInt(1, admitId);
			int rows = ps.executeUpdate();
			return rows > 0;
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return false;
	}

	private AdmissionPOJO mapRowToAdmission(ResultSet rs) throws SQLException {
		int admitId = rs.getInt("admit_ID");
		int patientId = rs.getInt("patient_ID");
		int roomId = rs.getInt("room_ID");
		int admitDate = rs.getInt("admit_date");
		int dischargeDate = rs.getInt("discharge_date");
		int doctorId = rs.getInt("doctor_ID");
		int totalBill = rs.getInt("total_bill");

		return new AdmissionPOJO(admitId, patientId, roomId, admitDate, dischargeDate, doctorId, totalBill);
	}
}

