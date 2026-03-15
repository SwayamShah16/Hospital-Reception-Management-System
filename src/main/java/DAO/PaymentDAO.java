package DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import Connection.GetConnection;
import POJO.PaymentPOJO;

public class PaymentDAO {

	private static final String INSERT_SQL = "INSERT INTO payment (payment_ID, appointment_ID, patient_ID, amount, date, mode, status) VALUES (?, ?, ?, ?, ?, ?, ?)";

	private static final String SELECT_BY_ID_SQL = "SELECT payment_ID, appointment_ID, patient_ID, amount, date, mode, status FROM payment WHERE payment_ID = ?";

	private static final String SELECT_ALL_SQL = "SELECT payment_ID, appointment_ID, patient_ID, amount, date, mode, status FROM payment";

	private static final String UPDATE_SQL = "UPDATE payment SET appointment_ID = ?, patient_ID = ?, amount = ?, date = ?, mode = ?, status = ? WHERE payment_ID = ?";

	private static final String DELETE_SQL = "DELETE FROM payment WHERE payment_ID = ?";

	private Connection getConnection() {
		return new GetConnection().GetConnection();
	}

	public boolean createPayment(PaymentPOJO p) {
		try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(INSERT_SQL)) {

			ps.setInt(1, p.getPayment_ID());
			ps.setInt(2, p.getAppointment_ID());
			ps.setInt(3, p.getPatient_ID());
			ps.setInt(4, p.getAmount());
			ps.setInt(5, p.getDate());
			ps.setString(6, p.getMode());
			ps.setString(7, p.getStatus());

			return ps.executeUpdate() > 0;
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return false;
	}

	public PaymentPOJO getPaymentById(int id) {
		try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(SELECT_BY_ID_SQL)) {

			ps.setInt(1, id);
			try (ResultSet rs = ps.executeQuery()) {
				if (rs.next()) {
					return mapRowToPayment(rs);
				}
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return null;
	}

	public List<PaymentPOJO> getAllPayments() {
		List<PaymentPOJO> list = new ArrayList<>();
		try (Connection conn = getConnection();
				PreparedStatement ps = conn.prepareStatement(SELECT_ALL_SQL);
				ResultSet rs = ps.executeQuery()) {

			while (rs.next()) {
				list.add(mapRowToPayment(rs));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return list;
	}

	public boolean updatePayment(PaymentPOJO p) {
		try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(UPDATE_SQL)) {

			ps.setInt(1, p.getAppointment_ID());
			ps.setInt(2, p.getPatient_ID());
			ps.setInt(3, p.getAmount());
			ps.setInt(4, p.getDate());
			ps.setString(5, p.getMode());
			ps.setString(6, p.getStatus());
			ps.setInt(7, p.getPayment_ID());

			return ps.executeUpdate() > 0;
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return false;
	}

	public boolean deletePayment(int id) {
		try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(DELETE_SQL)) {

			ps.setInt(1, id);
			return ps.executeUpdate() > 0;
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return false;
	}

	private PaymentPOJO mapRowToPayment(ResultSet rs) throws SQLException {
		int paymentId = rs.getInt("payment_ID");
		int appointmentId = rs.getInt("appointment_ID");
		int patientId = rs.getInt("patient_ID");
		int amount = rs.getInt("amount");
		int date = rs.getInt("date");
		String mode = rs.getString("mode");
		String status = rs.getString("status");
		return new PaymentPOJO(paymentId, appointmentId, patientId, amount, date, mode, status);
	}
}

