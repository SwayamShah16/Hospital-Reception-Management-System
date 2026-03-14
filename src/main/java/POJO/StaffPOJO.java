package POJO;

public class StaffPOJO {
	private int staff_Id;
	private String name;
	private String role;
	private int department_ID;
	private int contact_no;
	private String email;
	private int shift_timing;
	private int salary;
	private String status;

	public StaffPOJO(int staff_Id, String name, String role, int department_ID, int contact_no, String email,
			int shift_timing, int salary, String status) {
		super();
		this.staff_Id = staff_Id;
		this.name = name;
		this.role = role;
		this.department_ID = department_ID;
		this.contact_no = contact_no;
		this.email = email;
		this.shift_timing = shift_timing;
		this.salary = salary;
		this.status = status;
	}

	public int getStaff_Id() {
		return staff_Id;
	}

	public void setStaff_Id(int staff_Id) {
		this.staff_Id = staff_Id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getRole() {
		return role;
	}

	public void setRole(String role) {
		this.role = role;
	}

	public int getDepartment_ID() {
		return department_ID;
	}

	public void setDepartment_ID(int department_ID) {
		this.department_ID = department_ID;
	}

	public int getContact_no() {
		return contact_no;
	}

	public void setContact_no(int contact_no) {
		this.contact_no = contact_no;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public int getShift_timing() {
		return shift_timing;
	}

	public void setShift_timing(int shift_timing) {
		this.shift_timing = shift_timing;
	}

	public int getSalary() {
		return salary;
	}

	public void setSalary(int salary) {
		this.salary = salary;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

}
