<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"
	import="POJO.StaffPOJO"%>
<%
	// Session check
	javax.servlet.http.HttpSession session1 = request.getSession(false);
	if (session1 == null || session1.getAttribute("user") == null) {
		response.sendRedirect("receptionist?action=loginForm");
		return;
	}

	String mode = (String) request.getAttribute("mode");
	if (mode == null) {
		mode = "create";
	}

	StaffPOJO staff = (StaffPOJO) request.getAttribute("staff");

	String staff_Id = staff != null ? String.valueOf(staff.getStaff_Id()) : "";
	String name = staff != null ? staff.getName() : "";
	String role = staff != null ? staff.getRole() : "";
	String department_ID = staff != null ? String.valueOf(staff.getDepartment_ID()) : "";
	String contact_no = staff != null ? String.valueOf(staff.getContact_no()) : "";
	String email = staff != null ? staff.getEmail() : "";
	String shift_timing = staff != null ? String.valueOf(staff.getShift_timing()) : "";
	String salary = staff != null ? String.valueOf(staff.getSalary()) : "";
	String status = staff != null ? staff.getStatus() : "";
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title><%= "create".equalsIgnoreCase(mode) ? "Add Staff" : "Edit Staff" %></title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH"
	crossorigin="anonymous">
</head>
<body class="bg-light">
	<div class="container">
		<div class="row justify-content-center">
			<div class="col-lg-6">
				<div class="card shadow-sm mt-4">
					<div class="card-body">
						<h1 class="h4 mb-3 text-center">
							<%= "create".equalsIgnoreCase(mode) ? "Add New Staff" : "Edit Staff" %></h1>

						<form action="staff" method="post">
							<input type="hidden" name="action"
								value="<%= "create".equalsIgnoreCase(mode) ? "create" : "update" %>" />

							<div class="mb-3">
								<label for="staff_Id" class="form-label">Staff ID</label> <input
									type="number" class="form-control" id="staff_Id"
									name="staff_Id" required value="<%= staff_Id %>"
									<%= "update".equalsIgnoreCase(mode) ? "readonly" : "" %> />
							</div>

							<div class="mb-3">
								<label for="name" class="form-label">Name</label> <input
									type="text" class="form-control" id="name" name="name"
									required value="<%= name %>" />
							</div>

							<div class="mb-3">
								<label for="role" class="form-label">Role</label> <input
									type="text" class="form-control" id="role" name="role"
									required value="<%= role %>" />
							</div>

							<div class="mb-3">
								<label for="department_ID" class="form-label">Department
									ID</label> <input type="number" class="form-control"
									id="department_ID" name="department_ID" required
									value="<%= department_ID %>" />
							</div>

							<div class="mb-3">
								<label for="contact_no" class="form-label">Contact No</label> <input
									type="number" class="form-control" id="contact_no"
									name="contact_no" required value="<%= contact_no %>" />
							</div>

							<div class="mb-3">
								<label for="email" class="form-label">Email</label> <input
									type="email" class="form-control" id="email" name="email"
									required value="<%= email %>" />
							</div>

							<div class="mb-3">
								<label for="shift_timing" class="form-label">Shift Timing
									(e.g. 1, 2, 3)</label> <input type="number" class="form-control"
									id="shift_timing" name="shift_timing" required
									value="<%= shift_timing %>" />
							</div>

							<div class="mb-3">
								<label for="salary" class="form-label">Salary</label> <input
									type="number" class="form-control" id="salary" name="salary"
									required value="<%= salary %>" />
							</div>

							<div class="mb-3">
								<label for="status" class="form-label">Status</label> <select
									class="form-select" id="status" name="status" required>
									<option value="">--Select--</option>
									<option value="ACTIVE"
										<%= "ACTIVE".equalsIgnoreCase(status) ? "selected" : "" %>>Active</option>
									<option value="INACTIVE"
										<%= "INACTIVE".equalsIgnoreCase(status) ? "selected" : "" %>>Inactive</option>
									<option value="ON_LEAVE"
										<%= "ON_LEAVE".equalsIgnoreCase(status) ? "selected" : "" %>>On
										Leave</option>
								</select>
							</div>

							<div class="d-flex justify-content-between mt-4">
								<a href="staff?action=list"
									class="btn btn-outline-secondary">Back to Staff</a>
								<button type="submit" class="btn btn-primary">
									<%= "create".equalsIgnoreCase(mode) ? "Save Staff" : "Update Staff" %>
								</button>
							</div>
						</form>
					</div>
				</div>
			</div>
		</div>
	</div>

	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
		crossorigin="anonymous"></script>
</body>
</html>

