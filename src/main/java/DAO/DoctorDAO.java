package DAO;

import java.sql.*;
import java.util.*;

import Connection.GetConnection;
import POJO.DoctorPOJO;

public class DoctorDAO {

	private Connection getConnection() {
		return GetConnection.GetConnection(); // ✅ FIXED
	}

	public List<DoctorPOJO> getAllDoctors() {

		List<DoctorPOJO> list = new ArrayList<>();

		String sql = "SELECT * FROM doctor;"; // ⚠️ ensure table name is lowercase

		try (Connection con = getConnection();
				PreparedStatement ps = con.prepareStatement(sql);
				ResultSet rs = ps.executeQuery()) {

			while (rs.next()) {

				DoctorPOJO d = new DoctorPOJO();

				d.setDoctor_ID(rs.getInt("doctor_ID"));
				d.setName(rs.getString("name"));
				d.setSpecialization(rs.getString("specialization"));
				d.setContact_Number(rs.getString("contact_Number"));
				d.setEmail(rs.getString("email"));
				d.setConsultation_Fee(rs.getDouble("consultation_Fee"));
				d.setAvailability_Status(rs.getString("availability_Status"));

				list.add(d);
			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		return list;
	}

	public boolean deleteDoctor(int id) {

		try (Connection con = getConnection();
				PreparedStatement ps = con.prepareStatement("DELETE FROM doctor WHERE doctor_ID=?;")) {

			ps.setInt(1, id);
			return ps.executeUpdate() > 0;

		} catch (Exception e) {
			e.printStackTrace();
		}

		return false;
	}
}