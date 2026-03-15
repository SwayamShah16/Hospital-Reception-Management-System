package POJO;

public class PaymentPOJO {
	private int payment_ID;
	private int appointment_ID;
	private int patient_ID;
	private int amount;
	private int date;
	private String mode;
	private String status;

	public PaymentPOJO(int payment_ID, int appointment_ID, int patient_ID, int amount, int date, String mode,
			String status) {
		super();
		this.payment_ID = payment_ID;
		this.appointment_ID = appointment_ID;
		this.patient_ID = patient_ID;
		this.amount = amount;
		this.date = date;
		this.mode = mode;
		this.status = status;
	}

	public int getPayment_ID() {
		return payment_ID;
	}

	public void setPayment_ID(int payment_ID) {
		this.payment_ID = payment_ID;
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

	public int getAmount() {
		return amount;
	}

	public void setAmount(int amount) {
		this.amount = amount;
	}

	public int getDate() {
		return date;
	}

	public void setDate(int date) {
		this.date = date;
	}

	public String getMode() {
		return mode;
	}

	public void setMode(String mode) {
		this.mode = mode;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

}
