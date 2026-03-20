package POJO;

import java.util.Date;

public class PatientPOJO {

	private int patient_ID;
	private String first_Name;
	private String last_Name;
	private String gender;
	private Date dob;
	private String contact_Number;
	private String address;
	private String email;
	private String blood_Group;
	private Date registration_Date;

	public PatientPOJO() {
	}

	public PatientPOJO(int patient_ID, String first_Name, String last_Name, String gender, Date dob,
			String contact_Number, String address, String email, String blood_Group, Date registration_Date) {

		this.patient_ID = patient_ID;
		this.first_Name = first_Name;
		this.last_Name = last_Name;
		this.gender = gender;
		this.dob = dob;
		this.contact_Number = contact_Number;
		this.address = address;
		this.email = email;
		this.blood_Group = blood_Group;
		this.registration_Date = registration_Date;
	}

	// Getters & Setters
	public int getPatient_ID() {
		return patient_ID;
	}

	public void setPatient_ID(int patient_ID) {
		this.patient_ID = patient_ID;
	}

	public String getFirst_Name() {
		return first_Name;
	}

	public void setFirst_Name(String first_Name) {
		this.first_Name = first_Name;
	}

	public String getLast_Name() {
		return last_Name;
	}

	public void setLast_Name(String last_Name) {
		this.last_Name = last_Name;
	}

	public String getGender() {
		return gender;
	}

	public void setGender(String gender) {
		this.gender = gender;
	}

	public Date getDob() {
		return dob;
	}

	public void setDob(Date dob) {
		this.dob = dob;
	}

	public String getContact_Number() {
		return contact_Number;
	}

	public void setContact_Number(String contact_Number) {
		this.contact_Number = contact_Number;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getBlood_Group() {
		return blood_Group;
	}

	public void setBlood_Group(String blood_Group) {
		this.blood_Group = blood_Group;
	}

	public Date getRegistration_Date() {
		return registration_Date;
	}

	public void setRegistration_Date(Date registration_Date) {
		this.registration_Date = registration_Date;
	}
}