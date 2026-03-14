package DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import Connection.GetConnection;
import POJO.ReceptionistPOJO;

public class ReceptionistDAO {

	private static final String INSERT_SQL = "INSERT INTO receptionist (receptionist_id, recep_name, password, recep_contact_no, shift_timing, email) "
			+ "VALUES (?, ?, ?, ?, ?, ?)";

	private static final String SELECT_BY_ID_AND_PASSWORD_SQL = "SELECT receptionist_id, recep_name, password, recep_contact_no, shift_timing, email "
			+ "FROM receptionist WHERE receptionist_id = ? AND password = ?";

	private static final String SELECT_BY_ID_SQL = "SELECT receptionist_id, recep_name, password, recep_contact_no, shift_timing, email "
			+ "FROM receptionist WHERE receptionist_id = ?";

	private Connection getConnection() {
		return new GetConnection().GetConnection();
	}

	/**
	 * Validate receptionist login using ID and password.
	 */
	public ReceptionistPOJO validateReceptionist(int receptionistId, String password) {
		try (Connection conn = getConnection();
				PreparedStatement ps = conn.prepareStatement(SELECT_BY_ID_AND_PASSWORD_SQL)) {

			ps.setInt(1, receptionistId);
			ps.setString(2, password);

			try (ResultSet rs = ps.executeQuery()) {
				if (rs.next()) {
					return mapRowToReceptionist(rs);
				}
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return null;
	}

	/**
	 * Check if a receptionist ID is already registered.
	 */
	public boolean isReceptionistIdTaken(int receptionistId) {
		try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(SELECT_BY_ID_SQL)) {

			ps.setInt(1, receptionistId);

			try (ResultSet rs = ps.executeQuery()) {
				return rs.next(); // true if a row exists
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return false;
	}

	/**
	 * Register a new receptionist.
	 */
	public boolean createReceptionist(ReceptionistPOJO receptionist) {
		try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(INSERT_SQL)) {

			ps.setInt(1, receptionist.getReceptionist_id());
			ps.setString(2, receptionist.getRecep_name());
			ps.setString(3, receptionist.getPassword());
			ps.setInt(4, receptionist.getRecep_contact_no());
			ps.setInt(5, receptionist.getShift_timing());
			ps.setString(6, receptionist.getEmail());

			int rows = ps.executeUpdate();
			return rows > 0;
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return false;
	}

	/**
	 * Map a ResultSet row to a ReceptionistPOJO.
	 */
	private ReceptionistPOJO mapRowToReceptionist(ResultSet rs) throws SQLException {
		int id = rs.getInt("receptionist_id");
		String name = rs.getString("recep_name");
		String password = rs.getString("password");
		int contactNo = rs.getInt("recep_contact_no");
		int shiftTiming = rs.getInt("shift_timing");
		String email = rs.getString("email");

		return new ReceptionistPOJO(id, name, password, contactNo, shiftTiming, email);
	}
}