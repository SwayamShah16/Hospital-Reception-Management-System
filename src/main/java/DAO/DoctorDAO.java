package DAO;

import java.sql.*;
import java.util.*;
import POJO.DoctorPOJO;
import Connection.GetConnection;

public class DoctorDAO {

	public List<DoctorPOJO> getAllDoctors() {
		List<DoctorPOJO> list = new ArrayList<>();

		try (Connection con = GetConnection.getConnection()) {
			Statement st = con.createStatement();
			ResultSet rs = st.executeQuery("SELECT * FROM Doctor");

			while (rs.next()) {
				DoctorPOJO d = new DoctorPOJO();

				d.setDoctorId(rs.getInt("Doctor_ID"));
				d.setName(rs.getString("Name"));
				d.setSpecialization(rs.getString("Specialization"));
				d.setContactNumber(rs.getString("Contact_Number"));
				d.setEmail(rs.getString("Email"));
				d.setConsultationFee(rs.getDouble("Consultation_Fee"));
				d.setAvailabilityStatus(rs.getString("Availability_Status"));

				list.add(d);
			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		return list;
	}

	public boolean addDoctor(DoctorPOJO d) {
		try (Connection con = GetConnection.getConnection()) {

			String sql = "INSERT INTO Doctor (Name, Specialization, Contact_Number, Email, Consultation_Fee, Availability_Status) VALUES (?,?,?,?,?,?)";

			PreparedStatement ps = con.prepareStatement(sql);

			ps.setString(1, d.getName());
			ps.setString(2, d.getSpecialization());
			ps.setString(3, d.getContactNumber());
			ps.setString(4, d.getEmail());
			ps.setDouble(5, d.getConsultationFee());
			ps.setString(6, d.getAvailabilityStatus());

			return ps.executeUpdate() > 0;

		} catch (Exception e) {
			e.printStackTrace();
		}
		return false;
	}

	public boolean deleteDoctor(int id) {
		try (Connection con = GetConnection.getConnection()) {

			PreparedStatement ps = con.prepareStatement("DELETE FROM Doctor WHERE Doctor_ID=?");
			ps.setInt(1, id);

			return ps.executeUpdate() > 0;

		} catch (Exception e) {
			e.printStackTrace();
		}
		return false;
	}

	public DoctorPOJO getDoctorById(int id) {
		DoctorPOJO d = new DoctorPOJO();

		try (Connection con = GetConnection.getConnection()) {

			PreparedStatement ps = con.prepareStatement("SELECT * FROM Doctor WHERE Doctor_ID=?");
			ps.setInt(1, id);

			ResultSet rs = ps.executeQuery();

			if (rs.next()) {
				d.setDoctorId(rs.getInt("Doctor_ID"));
				d.setName(rs.getString("Name"));
				d.setSpecialization(rs.getString("Specialization"));
				d.setContactNumber(rs.getString("Contact_Number"));
				d.setEmail(rs.getString("Email"));
				d.setConsultationFee(rs.getDouble("Consultation_Fee"));
				d.setAvailabilityStatus(rs.getString("Availability_Status"));
			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		return d;
	}

	public boolean updateDoctor(DoctorPOJO d) {
		try (Connection con = GetConnection.getConnection()) {

			String sql = "UPDATE Doctor SET Name=?, Specialization=?, Contact_Number=?, Email=?, Consultation_Fee=?, Availability_Status=? WHERE Doctor_ID=?";

			PreparedStatement ps = con.prepareStatement(sql);

			ps.setString(1, d.getName());
			ps.setString(2, d.getSpecialization());
			ps.setString(3, d.getContactNumber());
			ps.setString(4, d.getEmail());
			ps.setDouble(5, d.getConsultationFee());
			ps.setString(6, d.getAvailabilityStatus());
			ps.setInt(7, d.getDoctorId());

			return ps.executeUpdate() > 0;

		} catch (Exception e) {
			e.printStackTrace();
		}

		return false;
	}

	public List<DoctorPOJO> searchDoctors(String keyword) {
		List<DoctorPOJO> list = new ArrayList<>();

		try (Connection con = GetConnection.getConnection()) {

			String sql = "SELECT * FROM Doctor WHERE Name LIKE ? OR Specialization LIKE ? OR Contact_Number LIKE ?";

			PreparedStatement ps = con.prepareStatement(sql);

			String k = "%" + keyword + "%";

			ps.setString(1, k);
			ps.setString(2, k);
			ps.setString(3, k);

			ResultSet rs = ps.executeQuery();

			while (rs.next()) {
				DoctorPOJO d = new DoctorPOJO();

				d.setDoctorId(rs.getInt("Doctor_ID"));
				d.setName(rs.getString("Name"));
				d.setSpecialization(rs.getString("Specialization"));
				d.setContactNumber(rs.getString("Contact_Number"));
				d.setEmail(rs.getString("Email"));
				d.setConsultationFee(rs.getDouble("Consultation_Fee"));
				d.setAvailabilityStatus(rs.getString("Availability_Status"));

				list.add(d);
			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		return list;
	}
}