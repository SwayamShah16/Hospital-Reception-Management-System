package DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import Connection.GetConnection;
import POJO.RoomPOJO;

public class RoomDAO {

	private static final String INSERT_SQL = "INSERT INTO room (room_ID, room_no, room_type, status, charges_per_day) VALUES (?, ?, ?, ?, ?)";

	private static final String SELECT_BY_ID_SQL = "SELECT room_ID, room_no, room_type, status, charges_per_day FROM room WHERE room_ID = ?";

	private static final String SELECT_ALL_SQL = "SELECT room_ID, room_no, room_type, status, charges_per_day FROM room";

	private static final String UPDATE_SQL = "UPDATE room SET room_no = ?, room_type = ?, status = ?, charges_per_day = ? WHERE room_ID = ?";

	private static final String DELETE_SQL = "DELETE FROM room WHERE room_ID = ?";

	private Connection getConnection() {
		return new GetConnection().GetConnection();
	}

	public boolean createRoom(RoomPOJO room) {
		try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(INSERT_SQL)) {

			ps.setInt(1, room.getRoom_ID());
			ps.setInt(2, room.getRoom_no());
			ps.setString(3, room.getRoom_type());
			ps.setString(4, room.getStatus());
			ps.setInt(5, room.getCharges_per_day());

			int rows = ps.executeUpdate();
			return rows > 0;
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return false;
	}

	public RoomPOJO getRoomById(int roomId) {
		try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(SELECT_BY_ID_SQL)) {

			ps.setInt(1, roomId);
			try (ResultSet rs = ps.executeQuery()) {
				if (rs.next()) {
					return mapRowToRoom(rs);
				}
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return null;
	}

	public List<RoomPOJO> getAllRooms() {
		List<RoomPOJO> rooms = new ArrayList<>();
		try (Connection conn = getConnection();
				PreparedStatement ps = conn.prepareStatement(SELECT_ALL_SQL);
				ResultSet rs = ps.executeQuery()) {

			while (rs.next()) {
				rooms.add(mapRowToRoom(rs));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return rooms;
	}

	public boolean updateRoom(RoomPOJO room) {
		try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(UPDATE_SQL)) {

			ps.setInt(1, room.getRoom_no());
			ps.setString(2, room.getRoom_type());
			ps.setString(3, room.getStatus());
			ps.setInt(4, room.getCharges_per_day());
			ps.setInt(5, room.getRoom_ID());

			int rows = ps.executeUpdate();
			return rows > 0;
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return false;
	}

	public boolean deleteRoom(int roomId) {
		try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(DELETE_SQL)) {

			ps.setInt(1, roomId);
			int rows = ps.executeUpdate();
			return rows > 0;
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return false;
	}

	private RoomPOJO mapRowToRoom(ResultSet rs) throws SQLException {
		int id = rs.getInt("room_ID");
		int no = rs.getInt("room_no");
		String type = rs.getString("room_type");
		String status = rs.getString("status");
		int charges = rs.getInt("charges_per_day");

		return new RoomPOJO(id, no, type, status, charges);
	}
}

