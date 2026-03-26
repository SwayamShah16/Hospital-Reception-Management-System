<%@ page import="POJO.StaffPOJO"%>
<%
StaffPOJO s = (StaffPOJO) request.getAttribute("staff");
%>

<!DOCTYPE html>
<html>
<head>
<title>Edit Staff</title>

<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
	rel="stylesheet">
<link href="style.css" rel="stylesheet">

</head>

<body class="bg-light">

	<div class="container mt-5">

		<div class="card shadow">
			<div class="card-header bg-warning">
				<h4>Edit Staff</h4>
			</div>

			<div class="card-body">

				<form action="staff" method="post">

					<input type="hidden" name="action" value="update"> <input
						type="hidden" name="id" value="<%=s.getStaffId()%>">

					<div class="row">
						<div class="col-md-6">
							<label>Name</label> <input name="name" value="<%=s.getName()%>"
								class="form-control">
						</div>

						<div class="col-md-6">
							<label>Role</label> <input name="role" value="<%=s.getRole()%>"
								class="form-control">
						</div>
					</div>

					<div class="row mt-3">
						<div class="col-md-6">
							<label>Department ID</label> <input type="number" name="dept"
								value="<%=s.getDepartmentId()%>" class="form-control">
						</div>

						<div class="col-md-6">
							<label>Contact</label> <input name="contact"
								value="<%=s.getContactNumber()%>" class="form-control">
						</div>
					</div>

					<div class="row mt-3">
						<div class="col-md-6">
							<label>Email</label> <input name="email"
								value="<%=s.getEmail()%>" class="form-control">
						</div>

						<div class="col-md-6">
							<label>Shift Timing</label> <input name="shift"
								value="<%=s.getShiftTiming()%>" class="form-control">
						</div>
					</div>

					<div class="row mt-3">
						<div class="col-md-6">
							<label>Salary</label> <input type="number" step="0.01"
								name="salary" value="<%=s.getSalary()%>" class="form-control">
						</div>

						<div class="col-md-6">
							<label>Status</label> <select name="status" class="form-control">
								<option <%=s.getStatus().equals("Active") ? "selected" : ""%>>Active</option>
								<option <%=s.getStatus().equals("Inactive") ? "selected" : ""%>>Inactive</option>
							</select>
						</div>
					</div>

					<div class="mt-4">
						<button class="btn btn-warning">Update Staff</button>
						<a href="staff?action=list" class="btn btn-secondary">Back</a>
					</div>

				</form>

			</div>
		</div>

	</div>

</body>
</html>