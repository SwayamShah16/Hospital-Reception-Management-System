package DAO;

import java.sql.*;
import java.util.*;

import POJO.PaymentPOJO;

import java.math.BigDecimal;

public class PaymentDAO {

	private Connection conn;

	public PaymentDAO(Connection conn) {
		this.conn = conn;
	}

	// 1️⃣ Add Payment (simulate status)
	public boolean addPayment(PaymentPOJO p) throws SQLException {
		String sql = "INSERT INTO payment(Appointment_ID, Patient_ID, Amount, Payment_Date, Payment_Mode, Payment_Status) "
				+ "VALUES (?, ?, ?, ?, ?, ?)";
		PreparedStatement ps = conn.prepareStatement(sql);

		ps.setInt(1, p.getAppointmentId());
		ps.setInt(2, p.getPatientId());
		ps.setBigDecimal(3, p.getAmount());
		ps.setDate(4, p.getPaymentDate());
		ps.setString(5, p.getPaymentMode());

		// Simulate 98% success, 2% failure
		String status = Math.random() > 0.02 ? "Success" : "Failed";
		ps.setString(6, status);

		int rows = ps.executeUpdate();
		return rows > 0;
	}

	// 2️⃣ Get payment by appointment ID
	public PaymentPOJO getPaymentByAppointmentId(int appointmentId) throws SQLException {
		String sql = "SELECT * FROM payment WHERE Appointment_ID=?";
		PreparedStatement ps = conn.prepareStatement(sql);
		ps.setInt(1, appointmentId);
		ResultSet rs = ps.executeQuery();

		if (rs.next()) {
			PaymentPOJO p = new PaymentPOJO();
			p.setPaymentId(rs.getInt("Payment_ID"));
			p.setAppointmentId(rs.getInt("Appointment_ID"));
			p.setPatientId(rs.getInt("Patient_ID"));
			p.setAmount(rs.getBigDecimal("Amount"));
			p.setPaymentDate(rs.getDate("Payment_Date"));
			p.setPaymentMode(rs.getString("Payment_Mode"));
			p.setPaymentStatus(rs.getString("Payment_Status"));
			return p;
		}
		return null;
	}

	// 3️⃣ Delete payment
	public boolean deletePayment(int paymentId) throws SQLException {
		String sql = "DELETE FROM payment WHERE Payment_ID=?";
		PreparedStatement ps = conn.prepareStatement(sql);
		ps.setInt(1, paymentId);
		return ps.executeUpdate() > 0;
	}

	// 4️⃣ Optional: Update payment manually
	public boolean updatePayment(PaymentPOJO p) throws SQLException {
		String sql = "UPDATE payment SET Amount=?, Payment_Mode=?, Payment_Status=? WHERE Payment_ID=?";
		PreparedStatement ps = conn.prepareStatement(sql);
		ps.setBigDecimal(1, p.getAmount());
		ps.setString(2, p.getPaymentMode());
		ps.setString(3, p.getPaymentStatus());
		ps.setInt(4, p.getPaymentId());
		return ps.executeUpdate() > 0;
	}
}