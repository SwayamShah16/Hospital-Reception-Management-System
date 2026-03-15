package DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import Connection.GetConnection;
import POJO.StaffPOJO;

public class StaffDAO {

	private static final String INSERT_SQL = "INSERT INTO staff (staff_Id, name, role, department_ID, contact_no, email, shift_timing, salary, status) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";

	private static final String SELECT_BY_ID_SQL = "SELECT staff_Id, name, role, department_ID, contact_no, email, shift_timing, salary, status FROM staff WHERE staff_Id = ?";

	private static final String SELECT_ALL_SQL = "SELECT staff_Id, name, role, department_ID, contact_no, email, shift_timing, salary, status FROM staff";

	private static final String UPDATE_SQL = "UPDATE staff SET name = ?, role = ?, department_ID = ?, contact_no = ?, email = ?, shift_timing = ?, salary = ?, status = ? WHERE staff_Id = ?";

	private static final String DELETE_SQL = "DELETE FROM staff WHERE staff_Id = ?";

	private Connection getConnection() {
		return new GetConnection().GetConnection();
	}

	public boolean createStaff(StaffPOJO s) {
		try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(INSERT_SQL)) {

			ps.setInt(1, s.getStaff_Id());
			ps.setString(2, s.getName());
			ps.setString(3, s.getRole());
			ps.setInt(4, s.getDepartment_ID());
			ps.setInt(5, s.getContact_no());
			ps.setString(6, s.getEmail());
			ps.setInt(7, s.getShift_timing());
			ps.setInt(8, s.getSalary());
			ps.setString(9, s.getStatus());

			return ps.executeUpdate() > 0;
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return false;
	}

	public StaffPOJO getStaffById(int id) {
		try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(SELECT_BY_ID_SQL)) {

			ps.setInt(1, id);
			try (ResultSet rs = ps.executeQuery()) {
				if (rs.next()) {
					return mapRowToStaff(rs);
				}
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return null;
	}

	public List<StaffPOJO> getAllStaff() {
		List<StaffPOJO> list = new ArrayList<>();
		try (Connection conn = getConnection();
				PreparedStatement ps = conn.prepareStatement(SELECT_ALL_SQL);
				ResultSet rs = ps.executeQuery()) {

			while (rs.next()) {
				list.add(mapRowToStaff(rs));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return list;
	}

	public boolean updateStaff(StaffPOJO s) {
		try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(UPDATE_SQL)) {

			ps.setString(1, s.getName());
			ps.setString(2, s.getRole());
			ps.setInt(3, s.getDepartment_ID());
			ps.setInt(4, s.getContact_no());
			ps.setString(5, s.getEmail());
			ps.setInt(6, s.getShift_timing());
			ps.setInt(7, s.getSalary());
			ps.setString(8, s.getStatus());
			ps.setInt(9, s.getStaff_Id());

			return ps.executeUpdate() > 0;
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return false;
	}

	public boolean deleteStaff(int id) {
		try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(DELETE_SQL)) {

			ps.setInt(1, id);
			return ps.executeUpdate() > 0;
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return false;
	}

	private StaffPOJO mapRowToStaff(ResultSet rs) throws SQLException {
		int staffId = rs.getInt("staff_Id");
		String name = rs.getString("name");
		String role = rs.getString("role");
		int deptId = rs.getInt("department_ID");
		int contact = rs.getInt("contact_no");
		String email = rs.getString("email");
		int shift = rs.getInt("shift_timing");
		int salary = rs.getInt("salary");
		String status = rs.getString("status");

		return new StaffPOJO(staffId, name, role, deptId, contact, email, shift, salary, status);
	}
}

