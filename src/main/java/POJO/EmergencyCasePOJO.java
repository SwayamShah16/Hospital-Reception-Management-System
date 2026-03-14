package POJO;

public class EmergencyCasePOJO {
	private int emergency_Id;
	private int patient_Id;
	private String emergency_type;
	private String severity_level;
	private String priority_level;
	private int arrival_time;
	private int assigned_doctor_ID;
	private String status;

	public EmergencyCasePOJO(int emergency_Id, int patient_Id, String emergency_type, String severity_level,
			String priority_level, int arrival_time, int assigned_doctor_ID, String status) {
		super();
		this.emergency_Id = emergency_Id;
		this.patient_Id = patient_Id;
		this.emergency_type = emergency_type;
		this.severity_level = severity_level;
		this.priority_level = priority_level;
		this.arrival_time = arrival_time;
		this.assigned_doctor_ID = assigned_doctor_ID;
		this.status = status;
	}

	public int getEmergency_Id() {
		return emergency_Id;
	}

	public void setEmergency_Id(int emergency_Id) {
		this.emergency_Id = emergency_Id;
	}

	public int getPatient_Id() {
		return patient_Id;
	}

	public void setPatient_Id(int patient_Id) {
		this.patient_Id = patient_Id;
	}

	public String getEmergency_type() {
		return emergency_type;
	}

	public void setEmergency_type(String emergency_type) {
		this.emergency_type = emergency_type;
	}

	public String getSeverity_level() {
		return severity_level;
	}

	public void setSeverity_level(String severity_level) {
		this.severity_level = severity_level;
	}

	public String getPriority_level() {
		return priority_level;
	}

	public void setPriority_level(String priority_level) {
		this.priority_level = priority_level;
	}

	public int getArrival_time() {
		return arrival_time;
	}

	public void setArrival_time(int arrival_time) {
		this.arrival_time = arrival_time;
	}

	public int getAssigned_doctor_ID() {
		return assigned_doctor_ID;
	}

	public void setAssigned_doctor_ID(int assigned_doctor_ID) {
		this.assigned_doctor_ID = assigned_doctor_ID;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

}
