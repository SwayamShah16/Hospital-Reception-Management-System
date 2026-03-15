package POJO;

public class AdmissionPOJO {
	private int admit_ID;
	private int patient_ID;
	private int room_ID;
	private int admit_date;
	private int discharge_date;
	private int doctor_ID;
	private int total_bill;

	public AdmissionPOJO(int admit_ID, int patient_ID, int room_ID, int admit_date, int discharge_date, int doctor_ID,
			int total_bill) {
		super();
		this.admit_ID = admit_ID;
		this.patient_ID = patient_ID;
		this.room_ID = room_ID;
		this.admit_date = admit_date;
		this.discharge_date = discharge_date;
		this.doctor_ID = doctor_ID;
		this.total_bill = total_bill;
	}

	public int getAdmit_ID() {
		return admit_ID;
	}

	public void setAdmit_ID(int admit_ID) {
		this.admit_ID = admit_ID;
	}

	public int getPatient_ID() {
		return patient_ID;
	}

	public void setPatient_ID(int patient_ID) {
		this.patient_ID = patient_ID;
	}

	public int getRoom_ID() {
		return room_ID;
	}

	public void setRoom_ID(int room_ID) {
		this.room_ID = room_ID;
	}

	public int getAdmit_date() {
		return admit_date;
	}

	public void setAdmit_date(int admit_date) {
		this.admit_date = admit_date;
	}

	public int getDischarge_date() {
		return discharge_date;
	}

	public void setDischarge_date(int discharge_date) {
		this.discharge_date = discharge_date;
	}

	public int getDoctor_ID() {
		return doctor_ID;
	}

	public void setDoctor_ID(int doctor_ID) {
		this.doctor_ID = doctor_ID;
	}

	public int getTotal_bill() {
		return total_bill;
	}

	public void setTotal_bill(int total_bill) {
		this.total_bill = total_bill;
	}

}
