package POJO;

public class EmergencyCasePOJO {
	private int emergencyId;
	private int patientId;
	private String emergencyType;
	private String severityLevel;
	private String priorityLevel;
	private java.sql.Timestamp arrivalTime;
	private int doctorId;
	private String status;

	// Getters & Setters
	public int getEmergencyId() {
		return emergencyId;
	}

	public void setEmergencyId(int emergencyId) {
		this.emergencyId = emergencyId;
	}

	public int getPatientId() {
		return patientId;
	}

	public void setPatientId(int patientId) {
		this.patientId = patientId;
	}

	public String getEmergencyType() {
		return emergencyType;
	}

	public void setEmergencyType(String emergencyType) {
		this.emergencyType = emergencyType;
	}

	public String getSeverityLevel() {
		return severityLevel;
	}

	public void setSeverityLevel(String severityLevel) {
		this.severityLevel = severityLevel;
	}

	public String getPriorityLevel() {
		return priorityLevel;
	}

	public void setPriorityLevel(String priorityLevel) {
		this.priorityLevel = priorityLevel;
	}

	public java.sql.Timestamp getArrivalTime() {
		return arrivalTime;
	}

	public void setArrivalTime(java.sql.Timestamp arrivalTime) {
		this.arrivalTime = arrivalTime;
	}

	public int getDoctorId() {
		return doctorId;
	}

	public void setDoctorId(int doctorId) {
		this.doctorId = doctorId;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}
}