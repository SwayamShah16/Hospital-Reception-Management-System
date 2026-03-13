package POJO;

public class DepartmentPOJO {
	private int dept_id;
	private String dept_name;
	private String location;
	private int head_doctor_ID;

	public DepartmentPOJO(int dept_id, String dept_name, String location, int head_doctor_ID) {
		super();
		this.dept_id = dept_id;
		this.dept_name = dept_name;
		this.location = location;
		this.head_doctor_ID = head_doctor_ID;
	}

	public int getDept_id() {
		return dept_id;
	}

	public void setDept_id(int dept_id) {
		this.dept_id = dept_id;
	}

	public String getDept_name() {
		return dept_name;
	}

	public void setDept_name(String dept_name) {
		this.dept_name = dept_name;
	}

	public String getLocation() {
		return location;
	}

	public void setLocation(String location) {
		this.location = location;
	}

	public int getHead_doctor_ID() {
		return head_doctor_ID;
	}

	public void setHead_doctor_ID(int head_doctor_ID) {
		this.head_doctor_ID = head_doctor_ID;
	}

}
