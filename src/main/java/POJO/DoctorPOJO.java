package POJO;

public class DoctorPOJO {

	private int doctor_ID;
	private String name;
	private String specialization;
	private double contact_Number;
	private String email;
	private double consultation_Fee;
	private String availability_Status;

	public DoctorPOJO() {
	}

	public DoctorPOJO(int doctor_ID, String name, String specialization, double contact_Number, String email,
			double consultation_Fee, String availability_Status) {

		this.doctor_ID = doctor_ID;
		this.name = name;
		this.specialization = specialization;
		this.contact_Number = contact_Number;
		this.email = email;
		this.consultation_Fee = consultation_Fee;
		this.availability_Status = availability_Status;
	}

	public int getDoctor_ID() {
		return doctor_ID;
	}

	public void setDoctor_ID(int doctor_ID) {
		this.doctor_ID = doctor_ID;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getSpecialization() {
		return specialization;
	}

	public void setSpecialization(String specialization) {
		this.specialization = specialization;
	}

	public double getContact_Number() {
		return contact_Number;
	}

	public void setContact_Number(double contact_Number) {
		this.contact_Number = contact_Number;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public double getConsultation_Fee() {
		return consultation_Fee;
	}

	public void setConsultation_Fee(double consultation_Fee) {
		this.consultation_Fee = consultation_Fee;
	}

	public String getAvailability_Status() {
		return availability_Status;
	}

	public void setAvailability_Status(String availability_Status) {
		this.availability_Status = availability_Status;
	}
}