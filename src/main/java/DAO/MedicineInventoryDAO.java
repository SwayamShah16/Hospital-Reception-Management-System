package DAO;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import Connection.GetConnection;
import POJO.MedicineInventoryPOJO;

public class MedicineInventoryDAO {

	private static final String INSERT_SQL = "INSERT INTO medicine_inventory (medicine_id, name, generic_name, category, manufacturer, batch_no, expiry_date, quantity_in_stock, reorder_level, unit_price) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

	private static final String SELECT_BY_ID_SQL = "SELECT medicine_id, name, generic_name, category, manufacturer, batch_no, expiry_date, quantity_in_stock, reorder_level, unit_price FROM medicine_inventory WHERE medicine_id = ?";

	private static final String SELECT_ALL_SQL = "SELECT medicine_id, name, generic_name, category, manufacturer, batch_no, expiry_date, quantity_in_stock, reorder_level, unit_price FROM medicine_inventory";

	private static final String UPDATE_SQL = "UPDATE medicine_inventory SET name = ?, generic_name = ?, category = ?, manufacturer = ?, batch_no = ?, expiry_date = ?, quantity_in_stock = ?, reorder_level = ?, unit_price = ? WHERE medicine_id = ?";

	private static final String DELETE_SQL = "DELETE FROM medicine_inventory WHERE medicine_id = ?";

	private Connection getConnection() {
		return new GetConnection().GetConnection();
	}

	public boolean createMedicine(MedicineInventoryPOJO med) {
		try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(INSERT_SQL)) {

			ps.setInt(1, med.getMedicine_id());
			ps.setString(2, med.getName());
			ps.setString(3, med.getGeneric_name());
			ps.setString(4, med.getCategory());
			ps.setString(5, med.getManufacturer());
			ps.setString(6, med.getBatch_no());
			ps.setDate(7, med.getExpiry_date());
			ps.setInt(8, med.getQuantity_in_stock());
			ps.setInt(9, med.getReorder_level());
			ps.setDouble(10, med.getUnit_price());

			int rows = ps.executeUpdate();
			return rows > 0;
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return false;
	}

	public MedicineInventoryPOJO getMedicineById(int medicineId) {
		try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(SELECT_BY_ID_SQL)) {

			ps.setInt(1, medicineId);
			try (ResultSet rs = ps.executeQuery()) {
				if (rs.next()) {
					return mapRowToMedicine(rs);
				}
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return null;
	}

	public List<MedicineInventoryPOJO> getAllMedicines() {
		List<MedicineInventoryPOJO> list = new ArrayList<>();
		try (Connection conn = getConnection();
				PreparedStatement ps = conn.prepareStatement(SELECT_ALL_SQL);
				ResultSet rs = ps.executeQuery()) {

			while (rs.next()) {
				list.add(mapRowToMedicine(rs));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return list;
	}

	public boolean updateMedicine(MedicineInventoryPOJO med) {
		try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(UPDATE_SQL)) {

			ps.setString(1, med.getName());
			ps.setString(2, med.getGeneric_name());
			ps.setString(3, med.getCategory());
			ps.setString(4, med.getManufacturer());
			ps.setString(5, med.getBatch_no());
			ps.setDate(6, med.getExpiry_date());
			ps.setInt(7, med.getQuantity_in_stock());
			ps.setInt(8, med.getReorder_level());
			ps.setDouble(9, med.getUnit_price());
			ps.setInt(10, med.getMedicine_id());

			int rows = ps.executeUpdate();
			return rows > 0;
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return false;
	}

	public boolean deleteMedicine(int medicineId) {
		try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(DELETE_SQL)) {

			ps.setInt(1, medicineId);
			int rows = ps.executeUpdate();
			return rows > 0;
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return false;
	}

	private MedicineInventoryPOJO mapRowToMedicine(ResultSet rs) throws SQLException {
		int id = rs.getInt("medicine_id");
		String name = rs.getString("name");
		String genericName = rs.getString("generic_name");
		String category = rs.getString("category");
		String manufacturer = rs.getString("manufacturer");
		String batchNo = rs.getString("batch_no");
		Date expiryDate = rs.getDate("expiry_date");
		int quantity = rs.getInt("quantity_in_stock");
		int reorderLevel = rs.getInt("reorder_level");
		double unitPrice = rs.getDouble("unit_price");

		return new MedicineInventoryPOJO(id, name, genericName, category, manufacturer, batchNo, expiryDate, quantity,
				reorderLevel, unitPrice);
	}
}

