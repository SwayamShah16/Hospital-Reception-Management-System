package DAO;

import java.sql.*;
import java.util.*;
import POJO.RoomPOJO;
import Connection.GetConnection;

public class RoomDAO {

	public List<RoomPOJO> getAllRooms() {
		List<RoomPOJO> list = new ArrayList<>();

		try (Connection con = GetConnection.getConnection()) {

			Statement st = con.createStatement();
			ResultSet rs = st.executeQuery("SELECT * FROM Room");

			while (rs.next()) {
				RoomPOJO r = new RoomPOJO();

				r.setRoomId(rs.getInt("Room_ID"));
				r.setRoomNumber(rs.getString("Room_Number"));
				r.setRoomType(rs.getString("Room_Type"));
				r.setStatus(rs.getString("Status"));
				r.setChargesPerDay(rs.getDouble("Charges_Per_Day"));

				list.add(r);
			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		return list;
	}

	public boolean addRoom(RoomPOJO r) {
		try (Connection con = GetConnection.getConnection()) {

			String sql = "INSERT INTO Room (Room_Number, Room_Type, Status, Charges_Per_Day) VALUES (?,?,?,?)";

			PreparedStatement ps = con.prepareStatement(sql);

			ps.setString(1, r.getRoomNumber());
			ps.setString(2, r.getRoomType());
			ps.setString(3, r.getStatus());
			ps.setDouble(4, r.getChargesPerDay());

			return ps.executeUpdate() > 0;

		} catch (Exception e) {
			e.printStackTrace();
		}
		return false;
	}

	public boolean deleteRoom(int id) {
		try (Connection con = GetConnection.getConnection()) {

			PreparedStatement ps = con.prepareStatement("DELETE FROM Room WHERE Room_ID=?");
			ps.setInt(1, id);

			return ps.executeUpdate() > 0;

		} catch (Exception e) {
			e.printStackTrace();
		}
		return false;
	}

	public RoomPOJO getRoomById(int id) {
		RoomPOJO r = new RoomPOJO();

		try (Connection con = GetConnection.getConnection()) {

			PreparedStatement ps = con.prepareStatement("SELECT * FROM Room WHERE Room_ID=?");
			ps.setInt(1, id);

			ResultSet rs = ps.executeQuery();

			if (rs.next()) {
				r.setRoomId(rs.getInt("Room_ID"));
				r.setRoomNumber(rs.getString("Room_Number"));
				r.setRoomType(rs.getString("Room_Type"));
				r.setStatus(rs.getString("Status"));
				r.setChargesPerDay(rs.getDouble("Charges_Per_Day"));
			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		return r;
	}

	public boolean updateRoom(RoomPOJO r) {
		try (Connection con = GetConnection.getConnection()) {

			String sql = "UPDATE Room SET Room_Number=?, Room_Type=?, Status=?, Charges_Per_Day=? WHERE Room_ID=?";

			PreparedStatement ps = con.prepareStatement(sql);

			ps.setString(1, r.getRoomNumber());
			ps.setString(2, r.getRoomType());
			ps.setString(3, r.getStatus());
			ps.setDouble(4, r.getChargesPerDay());
			ps.setInt(5, r.getRoomId());

			return ps.executeUpdate() > 0;

		} catch (Exception e) {
			e.printStackTrace();
		}

		return false;
	}

	public List<RoomPOJO> searchRooms(String keyword) {
		List<RoomPOJO> list = new ArrayList<>();

		try (Connection con = GetConnection.getConnection()) {

			String sql = "SELECT * FROM Room WHERE Room_Number LIKE ? OR Room_Type LIKE ?";

			PreparedStatement ps = con.prepareStatement(sql);

			String k = "%" + keyword + "%";

			ps.setString(1, k);
			ps.setString(2, k);

			ResultSet rs = ps.executeQuery();

			while (rs.next()) {
				RoomPOJO r = new RoomPOJO();

				r.setRoomId(rs.getInt("Room_ID"));
				r.setRoomNumber(rs.getString("Room_Number"));
				r.setRoomType(rs.getString("Room_Type"));
				r.setStatus(rs.getString("Status"));
				r.setChargesPerDay(rs.getDouble("Charges_Per_Day"));

				list.add(r);
			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		return list;
	}
}