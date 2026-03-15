package POJO;

public class PatientPOJO {
	private int patient_ID;
	private String patient_first_name;
	private String patient_last_name;
	private String patient_gender;
	private int patient_DOB;
	private int patient_contact_no;
	private String patient_address;
	private String patient_email;
	private String BloodGroup;
	private int Registration_Date;

	public PatientPOJO(int patient_ID, String patient_first_name, String patient_last_name, String patient_gender,
			int patient_DOB, int patient_contact_no, String patient_address, String patient_email, String bloodGroup,
			int registration_Date) {
		super();
		this.patient_ID = patient_ID;
		this.patient_first_name = patient_first_name;
		this.patient_last_name = patient_last_name;
		this.patient_gender = patient_gender;
		this.patient_DOB = patient_DOB;
		this.patient_contact_no = patient_contact_no;
		this.patient_address = patient_address;
		this.patient_email = patient_email;
		BloodGroup = bloodGroup;
		Registration_Date = registration_Date;
	}

	@Override
	public String toString() {
		return "PatientPOJO [patient_ID=" + patient_ID + ", patient_first_name=" + patient_first_name
				+ ", patient_last_name=" + patient_last_name + ", patient_gender=" + patient_gender + ", patient_DOB="
				+ patient_DOB + ", patient_contact_no=" + patient_contact_no + ", patient_address=" + patient_address
				+ ", patient_email=" + patient_email + ", BloodGroup=" + BloodGroup + ", Registration_Date="
				+ Registration_Date + "]";
	}

	public int getPatient_ID() {
		return patient_ID;
	}

	public void setPatient_ID(int patient_ID) {
		this.patient_ID = patient_ID;
	}

	public String getPatient_first_name() {
		return patient_first_name;
	}

	public void setPatient_first_name(String patient_first_name) {
		this.patient_first_name = patient_first_name;
	}

	public String getPatient_last_name() {
		return patient_last_name;
	}

	public void setPatient_last_name(String patient_last_name) {
		this.patient_last_name = patient_last_name;
	}

	public String getPatient_gender() {
		return patient_gender;
	}

	public void setPatient_gender(String patient_gender) {
		this.patient_gender = patient_gender;
	}

	public int getPatient_DOB() {
		return patient_DOB;
	}

	public void setPatient_DOB(int patient_DOB) {
		this.patient_DOB = patient_DOB;
	}

	public int getPatient_contact_no() {
		return patient_contact_no;
	}

	public void setPatient_contact_no(int patient_contact_no) {
		this.patient_contact_no = patient_contact_no;
	}

	public String getPatient_address() {
		return patient_address;
	}

	public void setPatient_address(String patient_address) {
		this.patient_address = patient_address;
	}

	public String getPatient_email() {
		return patient_email;
	}

	public void setPatient_email(String patient_email) {
		this.patient_email = patient_email;
	}

	public String getBloodGroup() {
		return BloodGroup;
	}

	public void setBloodGroup(String bloodGroup) {
		BloodGroup = bloodGroup;
	}

	public int getRegistration_Date() {
		return Registration_Date;
	}

	public void setRegistration_Date(int registration_Date) {
		Registration_Date = registration_Date;
	}

}
