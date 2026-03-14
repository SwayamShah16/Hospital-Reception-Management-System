package POJO;

public class QueueManagementPOJO {
	private int queue_Id;
	private int patient_ID;
	private int appointment_ID;
	private int token_no;
	private String type;
	private String priority_level;
	private int arrival_time;
	private String status;

	public QueueManagementPOJO(int queue_Id, int patient_ID, int appointment_ID, int token_no, String type,
			String priority_level, int arrival_time, String status) {
		super();
		this.queue_Id = queue_Id;
		this.patient_ID = patient_ID;
		this.appointment_ID = appointment_ID;
		this.token_no = token_no;
		this.type = type;
		this.priority_level = priority_level;
		this.arrival_time = arrival_time;
		this.status = status;
	}

	public int getQueue_Id() {
		return queue_Id;
	}

	public void setQueue_Id(int queue_Id) {
		this.queue_Id = queue_Id;
	}

	public int getPatient_ID() {
		return patient_ID;
	}

	public void setPatient_ID(int patient_ID) {
		this.patient_ID = patient_ID;
	}

	public int getAppointment_ID() {
		return appointment_ID;
	}

	public void setAppointment_ID(int appointment_ID) {
		this.appointment_ID = appointment_ID;
	}

	public int getToken_no() {
		return token_no;
	}

	public void setToken_no(int token_no) {
		this.token_no = token_no;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
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

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

}
