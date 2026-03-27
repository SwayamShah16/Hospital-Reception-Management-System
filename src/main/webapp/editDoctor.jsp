<%@ page import="POJO.DoctorPOJO"%>
<%
DoctorPOJO d = (DoctorPOJO) request.getAttribute("doctor");
%>
<%
HttpSession session1 = request.getSession(false);

if (session1 == null || session1.getAttribute("user_id") == null) {
	response.sendRedirect("login.jsp");
	return;
}

int userId = (int) session1.getAttribute("user_id");
String username = (String) session1.getAttribute("username");
String role = (String) session1.getAttribute("role");
%>
<%
if (!"Admin".equals(role)) {
	response.sendRedirect("unauthorized.jsp");
	return;
}
%>
<!DOCTYPE html>
<html>
<head>
<title>Edit Doctor</title>

<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
	rel="stylesheet">
<link href="style.css" rel="stylesheet">

</head>

<body class="bg-light">

	<div class="container mt-5">

		<div class="card shadow">
			<div class="card-header bg-warning">
				<h4>Edit Doctor</h4>
			</div>

			<div class="card-body">

				<form action="doctor" method="post">

					<input type="hidden" name="action" value="update"> <input
						type="hidden" name="id" value="<%=d.getDoctorId()%>">

					<div class="row">
						<div class="col-md-6">
							<label>Name</label> <input name="name" value="<%=d.getName()%>"
								class="form-control">
						</div>

						<div class="col-md-6">
							<label>Specialization</label> <input name="specialization"
								value="<%=d.getSpecialization()%>" class="form-control">
						</div>
					</div>

					<div class="row mt-3">
						<div class="col-md-6">
							<label>Contact</label> <input name="contact"
								value="<%=d.getContactNumber()%>" class="form-control">
						</div>

						<div class="col-md-6">
							<label>Email</label> <input name="email"
								value="<%=d.getEmail()%>" class="form-control">
						</div>
					</div>

					<div class="row mt-3">
						<div class="col-md-6">
							<label>Consultation Fee</label> <input name="fee"
								value="<%=d.getConsultationFee()%>" class="form-control">
						</div>

						<div class="col-md-6">
							<label>Status</label> <select name="status" class="form-control">
								<option
									<%=d.getAvailabilityStatus().equals("Available") ? "selected" : ""%>>Available</option>
								<option
									<%=d.getAvailabilityStatus().equals("Unavailable") ? "selected" : ""%>>Unavailable</option>
							</select>
						</div>
					</div>

					<div class="mt-4">
						<button class="btn btn-warning">Update Doctor</button>
						<a href="doctor?action=list" class="btn btn-secondary">Back</a>
					</div>

				</form>

			</div>
		</div>

	</div>

</body>
</html>