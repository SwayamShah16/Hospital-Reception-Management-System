package POJO;

public class RoomPOJO {
	private int room_ID;
	private int room_no;
	private String room_type;
	private String status;
	private int charges_per_day;

	public RoomPOJO(int room_ID, int room_no, String room_type, String status, int charges_per_day) {
		super();
		this.room_ID = room_ID;
		this.room_no = room_no;
		this.room_type = room_type;
		this.status = status;
		this.charges_per_day = charges_per_day;
	}

	public int getRoom_ID() {
		return room_ID;
	}

	public void setRoom_ID(int room_ID) {
		this.room_ID = room_ID;
	}

	public int getRoom_no() {
		return room_no;
	}

	public void setRoom_no(int room_no) {
		this.room_no = room_no;
	}

	public String getRoom_type() {
		return room_type;
	}

	public void setRoom_type(String room_type) {
		this.room_type = room_type;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public int getCharges_per_day() {
		return charges_per_day;
	}

	public void setCharges_per_day(int charges_per_day) {
		this.charges_per_day = charges_per_day;
	}

}
