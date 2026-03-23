package DAO;

import java.sql.*;
import java.util.*;

import Connection.GetConnection;
import POJO.DoctorPOJO;

public class DoctorDAO {

	// ✅ ADD
	public boolean addDoctor(DoctorPOJO d) {
		try (Connection con = GetConnection.getConnection()) {

			String sql = "INSERT INTO doctor (name, specialization, contact_number, email, consultation_fee, availability_status) VALUES (?, ?, ?, ?, ?, ?)";
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setInt(1, d.getDoctor_ID());
			ps.setString(2, d.getName());
			ps.setString(3, d.getSpecialization());
			ps.setDouble(4, d.getContact_Number());
			ps.setString(5, d.getEmail());
			ps.setDouble(6, d.getConsultation_Fee());
			ps.setString(7, d.getAvailability_Status());

			return ps.executeUpdate() > 0;

		} catch (Exception e) {
			e.printStackTrace();
		}
		return false;
	}

	// ✅ GET ALL
	public List<DoctorPOJO> getAllDoctors() {
		List<DoctorPOJO> doctors = new ArrayList<>();

		try (Connection con = GetConnection.getConnection()) {

			String sql = "SELECT * FROM doctor";
			PreparedStatement ps = con.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();

			while (rs.next()) {
				DoctorPOJO d = new DoctorPOJO(rs.getInt(1), rs.getString(2), rs.getString(3), rs.getDouble(4),
						rs.getString(5), rs.getDouble(6), rs.getString(7));
				doctors.add(d);
			}

		} catch (Exception e) {
			e.printStackTrace();
		}
		return doctors;
	}

	// ✅ DELETE
	public boolean deleteDoctor(int id) {
		try (Connection con = GetConnection.getConnection()) {

			String sql = "DELETE FROM doctor WHERE Doctor_ID=?";
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setInt(1, id);

			return ps.executeUpdate() > 0;

		} catch (Exception e) {
			e.printStackTrace();
		}
		return false;
	}

	// ✅ UPDATE
	public boolean updateDoctor(DoctorPOJO d) {
		try (Connection con = GetConnection.getConnection()) {

			String sql = "UPDATE doctor SET name=?, specialization=?, contact_number=?, email=?, consultation_fee=?, availability_status=? WHERE Doctor_ID=?";
			PreparedStatement ps = con.prepareStatement(sql);

			ps.setString(1, d.getName());
			ps.setString(2, d.getSpecialization());
			ps.setDouble(3, d.getContact_Number());
			ps.setString(4, d.getEmail());
			ps.setDouble(5, d.getConsultation_Fee());
			ps.setString(6, d.getAvailability_Status());
			ps.setInt(7, d.getDoctor_ID());

			return ps.executeUpdate() > 0;

		} catch (Exception e) {
			e.printStackTrace();
		}
		return false;
	}

	// ✅ FILTER
	public List<DoctorPOJO> filterDoctors(String specialization, String availability) {
		List<DoctorPOJO> list = new ArrayList<>();

		try (Connection con = GetConnection.getConnection()) {

			String sql = "SELECT * FROM doctor WHERE 1=1";

			if (specialization != null && !specialization.isEmpty()) {
				sql += " AND Specialization=?";
			}
			if (availability != null && !availability.isEmpty()) {
				sql += " AND Availability_Status=?";
			}

			PreparedStatement ps = con.prepareStatement(sql);

			int i = 1;
			if (specialization != null && !specialization.isEmpty()) {
				ps.setString(i++, specialization);
			}
			if (availability != null && !availability.isEmpty()) {
				ps.setString(i++, availability);
			}

			ResultSet rs = ps.executeQuery();

			while (rs.next()) {
				DoctorPOJO d = new DoctorPOJO(rs.getInt("Doctor_ID"), rs.getString("Name"),
						rs.getString("Specialization"), rs.getDouble("Contact_Number"), rs.getString("Email"),
						rs.getDouble("Consultation_Fee"), rs.getString("Availability_Status"));
				list.add(d);
			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		return list;
	}
}