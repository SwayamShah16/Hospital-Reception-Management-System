package DAO;

import java.sql.*;
import java.util.*;
import POJO.StaffPOJO;
import Connection.GetConnection;

public class StaffDAO {

	public List<StaffPOJO> getAllStaff() {
		List<StaffPOJO> list = new ArrayList<>();

		try (Connection con = GetConnection.getConnection()) {

			Statement st = con.createStatement();
			ResultSet rs = st.executeQuery("SELECT * FROM Staff");

			while (rs.next()) {
				StaffPOJO s = new StaffPOJO();

				s.setStaffId(rs.getInt("Staff_ID"));
				s.setName(rs.getString("Name"));
				s.setRole(rs.getString("Role"));
				s.setDepartmentId(rs.getInt("Department_ID"));
				s.setContactNumber(rs.getString("Contact_Number"));
				s.setEmail(rs.getString("Email"));
				s.setShiftTiming(rs.getString("Shift_Timing"));
				s.setSalary(rs.getDouble("Salary"));
				s.setStatus(rs.getString("Status"));

				list.add(s);
			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		return list;
	}

	public boolean addStaff(StaffPOJO s) {
		try (Connection con = GetConnection.getConnection()) {

			String sql = "INSERT INTO Staff (Name, Role, Department_ID, Contact_Number, Email, Shift_Timing, Salary, Status) VALUES (?,?,?,?,?,?,?,?)";

			PreparedStatement ps = con.prepareStatement(sql);

			ps.setString(1, s.getName());
			ps.setString(2, s.getRole());
			ps.setInt(3, s.getDepartmentId());
			ps.setString(4, s.getContactNumber());
			ps.setString(5, s.getEmail());
			ps.setString(6, s.getShiftTiming());
			ps.setDouble(7, s.getSalary());
			ps.setString(8, s.getStatus());

			return ps.executeUpdate() > 0;

		} catch (Exception e) {
			e.printStackTrace();
		}
		return false;
	}

	public boolean deleteStaff(int id) {
		try (Connection con = GetConnection.getConnection()) {

			PreparedStatement ps = con.prepareStatement("DELETE FROM Staff WHERE Staff_ID=?");
			ps.setInt(1, id);

			return ps.executeUpdate() > 0;

		} catch (Exception e) {
			e.printStackTrace();
		}
		return false;
	}

	public StaffPOJO getStaffById(int id) {
		StaffPOJO s = new StaffPOJO();

		try (Connection con = GetConnection.getConnection()) {

			PreparedStatement ps = con.prepareStatement("SELECT * FROM Staff WHERE Staff_ID=?");
			ps.setInt(1, id);

			ResultSet rs = ps.executeQuery();

			if (rs.next()) {
				s.setStaffId(rs.getInt("Staff_ID"));
				s.setName(rs.getString("Name"));
				s.setRole(rs.getString("Role"));
				s.setDepartmentId(rs.getInt("Department_ID"));
				s.setContactNumber(rs.getString("Contact_Number"));
				s.setEmail(rs.getString("Email"));
				s.setShiftTiming(rs.getString("Shift_Timing"));
				s.setSalary(rs.getDouble("Salary"));
				s.setStatus(rs.getString("Status"));
			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		return s;
	}

	public boolean updateStaff(StaffPOJO s) {
		try (Connection con = GetConnection.getConnection()) {

			String sql = "UPDATE Staff SET Name=?, Role=?, Department_ID=?, Contact_Number=?, Email=?, Shift_Timing=?, Salary=?, Status=? WHERE Staff_ID=?";

			PreparedStatement ps = con.prepareStatement(sql);

			ps.setString(1, s.getName());
			ps.setString(2, s.getRole());
			ps.setInt(3, s.getDepartmentId());
			ps.setString(4, s.getContactNumber());
			ps.setString(5, s.getEmail());
			ps.setString(6, s.getShiftTiming());
			ps.setDouble(7, s.getSalary());
			ps.setString(8, s.getStatus());
			ps.setInt(9, s.getStaffId());

			return ps.executeUpdate() > 0;

		} catch (Exception e) {
			e.printStackTrace();
		}

		return false;
	}

	public List<StaffPOJO> searchStaff(String keyword) {
		List<StaffPOJO> list = new ArrayList<>();

		try (Connection con = GetConnection.getConnection()) {

			String sql = "SELECT * FROM Staff WHERE Name LIKE ? OR Role LIKE ? OR Contact_Number LIKE ?";

			PreparedStatement ps = con.prepareStatement(sql);

			String k = "%" + keyword + "%";

			ps.setString(1, k);
			ps.setString(2, k);
			ps.setString(3, k);

			ResultSet rs = ps.executeQuery();

			while (rs.next()) {
				StaffPOJO s = new StaffPOJO();

				s.setStaffId(rs.getInt("Staff_ID"));
				s.setName(rs.getString("Name"));
				s.setRole(rs.getString("Role"));
				s.setDepartmentId(rs.getInt("Department_ID"));
				s.setContactNumber(rs.getString("Contact_Number"));
				s.setEmail(rs.getString("Email"));
				s.setShiftTiming(rs.getString("Shift_Timing"));
				s.setSalary(rs.getDouble("Salary"));
				s.setStatus(rs.getString("Status"));

				list.add(s);
			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		return list;
	}
}