package DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import Connection.GetConnection;
import POJO.PatientPOJO;

public class PatientDAO {

	private static final String INSERT_SQL = "INSERT INTO patient (patient_ID, patient_first_name, patient_last_name, patient_gender, patient_DOB, patient_contact_no, patient_address, patient_email, BloodGroup, Registration_Date) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

	private static final String SELECT_BY_ID_SQL = "SELECT patient_ID, patient_first_name, patient_last_name, patient_gender, patient_DOB, patient_contact_no, patient_address, patient_email, BloodGroup, Registration_Date FROM patient WHERE patient_ID = ?";

	private static final String SELECT_ALL_SQL = "SELECT patient_ID, patient_first_name, patient_last_name, patient_gender, patient_DOB, patient_contact_no, patient_address, patient_email, BloodGroup, Registration_Date FROM patient";

	private static final String UPDATE_SQL = "UPDATE patient SET patient_first_name = ?, patient_last_name = ?, patient_gender = ?, patient_DOB = ?, patient_contact_no = ?, patient_address = ?, patient_email = ?, BloodGroup = ?, Registration_Date = ? WHERE patient_ID = ?";

	private static final String DELETE_SQL = "DELETE FROM patient WHERE patient_ID = ?";

	private Connection getConnection() {
		return new GetConnection().GetConnection();
	}

	public boolean createPatient(PatientPOJO patient) {
		try (Connection connection = getConnection();
				PreparedStatement preparedStatement = connection.prepareStatement(INSERT_SQL)) {

			preparedStatement.setInt(1, patient.getPatient_ID());
			preparedStatement.setString(2, patient.getPatient_first_name());
			preparedStatement.setString(3, patient.getPatient_last_name());
			preparedStatement.setString(4, patient.getPatient_gender());
			preparedStatement.setInt(5, patient.getPatient_DOB());
			preparedStatement.setInt(6, patient.getPatient_contact_no());
			preparedStatement.setString(7, patient.getPatient_address());
			preparedStatement.setString(8, patient.getPatient_email());
			preparedStatement.setString(9, patient.getBloodGroup());
			preparedStatement.setInt(10, patient.getRegistration_Date());

			int rows = preparedStatement.executeUpdate();
			return rows > 0;
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return false;
	}

	public PatientPOJO getPatientById(int patientId) {
		try (Connection connection = getConnection();
				PreparedStatement preparedStatement = connection.prepareStatement(SELECT_BY_ID_SQL)) {

			preparedStatement.setInt(1, patientId);
			try (ResultSet resultSet = preparedStatement.executeQuery()) {
				if (resultSet.next()) {
					return mapRowToPatient(resultSet);
				}
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return null;
	}

	public List<PatientPOJO> getAllPatients() {
		List<PatientPOJO> patients = new ArrayList<>();
		try (Connection connection = getConnection();
				PreparedStatement preparedStatement = connection.prepareStatement(SELECT_ALL_SQL);
				ResultSet resultSet = preparedStatement.executeQuery()) {

			while (resultSet.next()) {
				patients.add(mapRowToPatient(resultSet));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return patients;
	}

	public boolean updatePatient(PatientPOJO patient) {
		try (Connection connection = getConnection();
				PreparedStatement preparedStatement = connection.prepareStatement(UPDATE_SQL)) {

			preparedStatement.setString(1, patient.getPatient_first_name());
			preparedStatement.setString(2, patient.getPatient_last_name());
			preparedStatement.setString(3, patient.getPatient_gender());
			preparedStatement.setInt(4, patient.getPatient_DOB());
			preparedStatement.setInt(5, patient.getPatient_contact_no());
			preparedStatement.setString(6, patient.getPatient_address());
			preparedStatement.setString(7, patient.getPatient_email());
			preparedStatement.setString(8, patient.getBloodGroup());
			preparedStatement.setInt(9, patient.getRegistration_Date());
			preparedStatement.setInt(10, patient.getPatient_ID());

			int rows = preparedStatement.executeUpdate();
			return rows > 0;
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return false;
	}

	public boolean deletePatient(int patientId) {
		try (Connection connection = getConnection();
				PreparedStatement preparedStatement = connection.prepareStatement(DELETE_SQL)) {

			preparedStatement.setInt(1, patientId);
			int rows = preparedStatement.executeUpdate();
			return rows > 0;
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return false;
	}

	private PatientPOJO mapRowToPatient(ResultSet resultSet) throws SQLException {
		int id = resultSet.getInt("patient_ID");
		String firstName = resultSet.getString("patient_first_name");
		String lastName = resultSet.getString("patient_last_name");
		String gender = resultSet.getString("patient_gender");
		int dob = resultSet.getInt("patient_DOB");
		int contactNo = resultSet.getInt("patient_contact_no");
		String address = resultSet.getString("patient_address");
		String email = resultSet.getString("patient_email");
		String bloodGroup = resultSet.getString("BloodGroup");
		int registrationDate = resultSet.getInt("Registration_Date");

		return new PatientPOJO(id, firstName, lastName, gender, dob, contactNo, address, email, bloodGroup,
				registrationDate);
	}
}

