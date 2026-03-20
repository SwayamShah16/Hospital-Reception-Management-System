package DAO;

import java.sql.*;
import java.util.*;

import Connection.GetConnection;
import POJO.DoctorPOJO;

public class DoctorDAO {

	private Connection getConnection() {
		return new GetConnection().GetConnection();
	}

	// ✅ GET ALL
	public List<DoctorPOJO> getAllDoctors() {

		List<DoctorPOJO> list = new ArrayList<>();

		String sql = "SELECT * FROM Doctor ORDER BY Doctor_ID DESC";

		try (Connection con = getConnection();
				PreparedStatement ps = con.prepareStatement(sql);
				ResultSet rs = ps.executeQuery()) {

			while (rs.next()) {

				DoctorPOJO d = new DoctorPOJO();

				d.setDoctor_ID(rs.getInt("Doctor_ID"));
				d.setName(rs.getString("Name"));
				d.setSpecialization(rs.getString("Specialization"));
				d.setContact_Number(rs.getString("Contact_Number"));
				d.setEmail(rs.getString("Email"));
				d.setConsultation_Fee(rs.getDouble("Consultation_Fee"));
				d.setAvailability_Status(rs.getString("Availability_Status"));

				list.add(d);
			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		return list;
	}

	// ✅ DELETE
	public boolean deleteDoctor(int id) {

		try (Connection con = getConnection();
				PreparedStatement ps = con.prepareStatement("DELETE FROM Doctor WHERE Doctor_ID=?")) {

			ps.setInt(1, id);
			return ps.executeUpdate() > 0;

		} catch (Exception e) {
			e.printStackTrace();
		}

		return false;
	}
}