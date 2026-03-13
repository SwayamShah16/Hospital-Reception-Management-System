package POJO;

public class ReceptionistPOJO {
	private int receptionist_id;
	private String recep_name;
	private String password;
	private int recep_contact_no;
	private int shift_timing;
	private String email;

	public ReceptionistPOJO(int receptionist_id, String recep_name, String password, int recep_contact_no,
			int shift_timing, String email) {
		super();
		this.receptionist_id = receptionist_id;
		this.recep_name = recep_name;
		this.password = password;
		this.recep_contact_no = recep_contact_no;
		this.shift_timing = shift_timing;
		this.email = email;
	}

	public int getReceptionist_id() {
		return receptionist_id;
	}

	public void setReceptionist_id(int receptionist_id) {
		this.receptionist_id = receptionist_id;
	}

	public String getRecep_name() {
		return recep_name;
	}

	public void setRecep_name(String recep_name) {
		this.recep_name = recep_name;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public int getRecep_contact_no() {
		return recep_contact_no;
	}

	public void setRecep_contact_no(int recep_contact_no) {
		this.recep_contact_no = recep_contact_no;
	}

	public int getShift_timing() {
		return shift_timing;
	}

	public void setShift_timing(int shift_timing) {
		this.shift_timing = shift_timing;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

}
