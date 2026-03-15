<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"
	import="java.util.List,POJO.StaffPOJO"%>
<%
	// Session check
	javax.servlet.http.HttpSession session1 = request.getSession(false);
	if (session1 == null || session1.getAttribute("user") == null) {
		response.sendRedirect("receptionist?action=loginForm");
		return;
	}

	List<StaffPOJO> staffList = (List<StaffPOJO>) request.getAttribute("staffList");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Staff Management</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH"
	crossorigin="anonymous">
</head>
<body class="bg-light">
	<nav class="navbar navbar-expand-lg navbar-dark bg-primary mb-4">
		<div class="container-fluid">
			<span class="navbar-brand">Hospital Reception - Staff</span>
			<div class="d-flex">
				<a href="receptionist?action=logout"
					class="btn btn-outline-light btn-sm">Logout</a>
			</div>
		</div>
	</nav>

	<div class="container">
		<div class="d-flex justify-content-between align-items-center mb-3">
			<h1 class="h3 mb-0">Staff Management</h1>
			<a href="staff?action=form&mode=create" class="btn btn-success">Add
				New Staff</a>
		</div>

		<div class="card shadow-sm">
			<div class="card-body">
				<%
					if (staffList == null || staffList.isEmpty()) {
				%>
				<p class="text-muted mb-0">No staff records found.</p>
				<%
					} else {
				%>
				<div class="table-responsive">
					<table class="table table-striped table-hover align-middle mb-0">
						<thead class="table-primary">
							<tr>
								<th scope="col">Staff ID</th>
								<th scope="col">Name</th>
								<th scope="col">Role</th>
								<th scope="col">Department ID</th>
								<th scope="col">Contact</th>
								<th scope="col">Email</th>
								<th scope="col">Shift</th>
								<th scope="col">Salary</th>
								<th scope="col">Status</th>
								<th scope="col">Actions</th>
							</tr>
						</thead>
						<tbody>
							<%
								for (StaffPOJO s : staffList) {
							%>
							<tr>
								<td><%=s.getStaff_Id()%></td>
								<td><%=s.getName()%></td>
								<td><%=s.getRole()%></td>
								<td><%=s.getDepartment_ID()%></td>
								<td><%=s.getContact_no()%></td>
								<td><%=s.getEmail()%></td>
								<td><%=s.getShift_timing()%></td>
								<td>₹
									<%=s.getSalary()%></td>
								<td><span
									class="<%= "ACTIVE".equalsIgnoreCase(s.getStatus()) ? "text-success fw-bold"
								: "INACTIVE".equalsIgnoreCase(s.getStatus()) ? "text-secondary fw-bold"
										: "ON_LEAVE".equalsIgnoreCase(s.getStatus()) ? "text-warning fw-bold" : "" %>">
										<%=s.getStatus()%>
								</span></td>
								<td class="actions"><form action="staff" method="get"
										class="d-inline">
										<input type="hidden" name="action" value="form" /> <input
											type="hidden" name="mode" value="update" /> <input
											type="hidden" name="staff_Id" value="<%=s.getStaff_Id()%>" />
										<button type="submit"
											class="btn btn-sm btn-outline-primary">Edit</button>
									</form>
									<form action="staff" method="post" class="d-inline"
										onsubmit="return confirm('Are you sure you want to delete this staff member?');">
										<input type="hidden" name="action" value="delete" /> <input
											type="hidden" name="staff_Id" value="<%=s.getStaff_Id()%>" />
										<button type="submit"
											class="btn btn-sm btn-outline-danger">Delete</button>
									</form></td>
							</tr>
							<%
								}
							%>
						</tbody>
					</table>
				</div>
				<%
					}
				%>
			</div>
		</div>
	</div>

	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
		crossorigin="anonymous"></script>
</body>
</html>

