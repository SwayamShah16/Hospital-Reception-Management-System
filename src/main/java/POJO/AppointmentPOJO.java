package POJO;

public class AppointmentPOJO {
	private int appointment_ID;
	private int patient_ID;
	private int doctor_ID;
	private int receptionist_ID;
	private int appointment_date;
	private int appointment_time;
	private String status;
	private String Remarks;

	public AppointmentPOJO(int appointment_ID, int patient_ID, int doctor_ID, int receptionist_ID, int appointment_date,
			int appointment_time, String status, String remarks) {
		super();
		this.appointment_ID = appointment_ID;
		this.patient_ID = patient_ID;
		this.doctor_ID = doctor_ID;
		this.receptionist_ID = receptionist_ID;
		this.appointment_date = appointment_date;
		this.appointment_time = appointment_time;
		this.status = status;
		Remarks = remarks;
	}

	public int getAppointment_ID() {
		return appointment_ID;
	}

	public void setAppointment_ID(int appointment_ID) {
		this.appointment_ID = appointment_ID;
	}

	public int getPatient_ID() {
		return patient_ID;
	}

	public void setPatient_ID(int patient_ID) {
		this.patient_ID = patient_ID;
	}

	public int getDoctor_ID() {
		return doctor_ID;
	}

	public void setDoctor_ID(int doctor_ID) {
		this.doctor_ID = doctor_ID;
	}

	public int getReceptionist_ID() {
		return receptionist_ID;
	}

	public void setReceptionist_ID(int receptionist_ID) {
		this.receptionist_ID = receptionist_ID;
	}

	public int getAppointment_date() {
		return appointment_date;
	}

	public void setAppointment_date(int appointment_date) {
		this.appointment_date = appointment_date;
	}

	public int getAppointment_time() {
		return appointment_time;
	}

	public void setAppointment_time(int appointment_time) {
		this.appointment_time = appointment_time;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getRemarks() {
		return Remarks;
	}

	public void setRemarks(String remarks) {
		Remarks = remarks;
	}

}
