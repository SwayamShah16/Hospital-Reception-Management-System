package POJO;

public class DoctorPOJO {
	private int doctor_ID;
	private String doctor_name;
	private String Specialization;
	private int doctor_contact_no;
	private String doctor_email;
	private int consulatancy_fee;
	private String availability_status;

	public DoctorPOJO(int doctor_ID, String doctor_name, String specialization, int doctor_contact_no,
			String doctor_email, int consulatancy_fee, String availability_status) {
		super();
		this.doctor_ID = doctor_ID;
		this.doctor_name = doctor_name;
		Specialization = specialization;
		this.doctor_contact_no = doctor_contact_no;
		this.doctor_email = doctor_email;
		this.consulatancy_fee = consulatancy_fee;
		this.availability_status = availability_status;
	}

	public int getDoctor_ID() {
		return doctor_ID;
	}

	public void setDoctor_ID(int doctor_ID) {
		this.doctor_ID = doctor_ID;
	}

	public String getDoctor_name() {
		return doctor_name;
	}

	public void setDoctor_name(String doctor_name) {
		this.doctor_name = doctor_name;
	}

	public String getSpecialization() {
		return Specialization;
	}

	public void setSpecialization(String specialization) {
		Specialization = specialization;
	}

	public int getDoctor_contact_no() {
		return doctor_contact_no;
	}

	public void setDoctor_contact_no(int doctor_contact_no) {
		this.doctor_contact_no = doctor_contact_no;
	}

	public String getDoctor_email() {
		return doctor_email;
	}

	public void setDoctor_email(String doctor_email) {
		this.doctor_email = doctor_email;
	}

	public int getConsulatancy_fee() {
		return consulatancy_fee;
	}

	public void setConsulatancy_fee(int consulatancy_fee) {
		this.consulatancy_fee = consulatancy_fee;
	}

	public String getAvailability_status() {
		return availability_status;
	}

	public void setAvailability_status(String availability_status) {
		this.availability_status = availability_status;
	}

}
