package DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import Connection.GetConnection;
import POJO.DoctorPOJO;

public class DoctorDAO {

	private static final String INSERT_SQL = "INSERT INTO doctor (doctor_ID, doctor_name, Specialization, doctor_contact_no, doctor_email, consulatancy_fee, availability_status) VALUES (?, ?, ?, ?, ?, ?, ?)";

	private static final String SELECT_BY_ID_SQL = "SELECT doctor_ID, doctor_name, Specialization, doctor_contact_no, doctor_email, consulatancy_fee, availability_status FROM doctor WHERE doctor_ID = ?";

	private static final String SELECT_ALL_SQL = "SELECT doctor_ID, doctor_name, Specialization, doctor_contact_no, doctor_email, consulatancy_fee, availability_status FROM doctor";

	private static final String UPDATE_SQL = "UPDATE doctor SET doctor_name = ?, Specialization = ?, doctor_contact_no = ?, doctor_email = ?, consulatancy_fee = ?, availability_status = ? WHERE doctor_ID = ?";

	private static final String DELETE_SQL = "DELETE FROM doctor WHERE doctor_ID = ?";

	private Connection getConnection() {
		return new GetConnection().GetConnection();
	}

	public boolean createDoctor(DoctorPOJO doctor) {
		try (Connection connection = getConnection(); PreparedStatement ps = connection.prepareStatement(INSERT_SQL)) {

			ps.setInt(1, doctor.getDoctor_ID());
			ps.setString(2, doctor.getDoctor_name());
			ps.setString(3, doctor.getSpecialization());
			ps.setInt(4, doctor.getDoctor_contact_no());
			ps.setString(5, doctor.getDoctor_email());
			ps.setInt(6, doctor.getConsulatancy_fee());
			ps.setString(7, doctor.getAvailability_status());

			int rows = ps.executeUpdate();
			return rows > 0;
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return false;
	}

	public DoctorPOJO getDoctorById(int doctorId) {
		try (Connection connection = getConnection(); PreparedStatement ps = connection.prepareStatement(SELECT_BY_ID_SQL)) {

			ps.setInt(1, doctorId);
			try (ResultSet rs = ps.executeQuery()) {
				if (rs.next()) {
					return mapRowToDoctor(rs);
				}
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return null;
	}

	public List<DoctorPOJO> getAllDoctors() {
		List<DoctorPOJO> doctors = new ArrayList<>();
		try (Connection connection = getConnection();
				PreparedStatement ps = connection.prepareStatement(SELECT_ALL_SQL);
				ResultSet rs = ps.executeQuery()) {

			while (rs.next()) {
				doctors.add(mapRowToDoctor(rs));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return doctors;
	}

	public boolean updateDoctor(DoctorPOJO doctor) {
		try (Connection connection = getConnection(); PreparedStatement ps = connection.prepareStatement(UPDATE_SQL)) {

			ps.setString(1, doctor.getDoctor_name());
			ps.setString(2, doctor.getSpecialization());
			ps.setInt(3, doctor.getDoctor_contact_no());
			ps.setString(4, doctor.getDoctor_email());
			ps.setInt(5, doctor.getConsulatancy_fee());
			ps.setString(6, doctor.getAvailability_status());
			ps.setInt(7, doctor.getDoctor_ID());

			int rows = ps.executeUpdate();
			return rows > 0;
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return false;
	}

	public boolean deleteDoctor(int doctorId) {
		try (Connection connection = getConnection(); PreparedStatement ps = connection.prepareStatement(DELETE_SQL)) {

			ps.setInt(1, doctorId);
			int rows = ps.executeUpdate();
			return rows > 0;
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return false;
	}

	private DoctorPOJO mapRowToDoctor(ResultSet rs) throws SQLException {
		int id = rs.getInt("doctor_ID");
		String name = rs.getString("doctor_name");
		String specialization = rs.getString("Specialization");
		int contactNo = rs.getInt("doctor_contact_no");
		String email = rs.getString("doctor_email");
		int consultancyFee = rs.getInt("consulatancy_fee");
		String availabilityStatus = rs.getString("availability_status");

		return new DoctorPOJO(id, name, specialization, contactNo, email, consultancyFee, availabilityStatus);
	}
}

