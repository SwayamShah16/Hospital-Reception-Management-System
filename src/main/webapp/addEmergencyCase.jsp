<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page
	import="DAO.PatientDAO, DAO.DoctorDAO, POJO.PatientPOJO, POJO.DoctorPOJO, java.util.List,POJO.EmergencyCasePOJO,DAO.EmergencyCaseDAO"%>

<%
HttpSession session1 = request.getSession(false);

if (session1 == null || session1.getAttribute("user_id") == null) {
	response.sendRedirect("login.jsp");
	return;
}

int userId = (int) session1.getAttribute("user_id");
String username = (String) session1.getAttribute("username");
String role = (String) session1.getAttribute("role");

if (!("Admin".equals(role) || "Doctor".equals(role) || "Staff".equals(role))) {
	response.sendRedirect("unauthorized.jsp");
	return;
}

EmergencyCaseDAO dao = new EmergencyCaseDAO(); // DAO manages DB connection
List<PatientPOJO> patients = dao.getAllPatients();
List<DoctorPOJO> doctors = dao.getAllDoctors();
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Add Emergency Case</title>

<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
	rel="stylesheet">

<style>
body {
	background-color: #f8f9fa;
}

.card {
	border-radius: 12px;
}
</style>

</head>
<body>

	<div class="container mt-5">
		<div class="card shadow p-4">
			<h2 class="mb-4 text-danger">Add Emergency Case</h2>

			<form action="emergency" method="post">
				<input type="hidden" name="action" value="insert">

				<!-- Patient -->
				<div class="mb-3">
					<label class="form-label">Patient</label> <select name="patient_id"
						class="form-select" required>
						<option value="">-- Select Patient --</option>
						<%
						for (PatientPOJO p : patients) {
						%>
						<option value="<%=p.getPatientId()%>">
							<%=p.getFirstName() + " " + p.getLastName()%>
						</option>
						<%
						}
						%>
					</select>
				</div>

				<!-- Doctor -->
				<div class="mb-3">
					<label class="form-label">Doctor</label> <select name="doctor_id"
						class="form-select" required>
						<option value="">-- Select Doctor --</option>
						<%
						for (DoctorPOJO d : doctors) {
						%>
						<option value="<%=d.getDoctorId()%>">
							<%=d.getName()%>
						</option>
						<%
						}
						%>
					</select>
				</div>

				<!-- Emergency Type -->
				<div class="mb-3">
					<label class="form-label">Emergency Type</label> <input type="text"
						name="type" class="form-control"
						placeholder="e.g. Accident, Cardiac Arrest" required>
				</div>

				<!-- Severity -->
				<div class="mb-3">
					<label class="form-label">Severity Level</label> <select
						name="severity" class="form-select" required>
						<option value="Critical">Critical</option>
						<option value="Serious">Serious</option>
						<option value="Minor">Minor</option>
					</select>
				</div>

				<!-- Status -->
				<div class="mb-3">
					<label class="form-label">Status</label> <select name="status"
						class="form-select">
						<option value="Waiting">Waiting</option>
						<option value="In Treatment">In Treatment</option>
						<option value="Completed">Completed</option>
					</select>
				</div>

				<!-- Info Note -->
				<div class="alert alert-info">
					⏱ Arrival Time will be recorded automatically.<br> ⚡ Priority
					will be auto-assigned based on severity.
				</div>

				<!-- Buttons -->
				<button type="submit" class="btn btn-danger">Add Emergency</button>
				<a href="ViewEmergencyCase.jsp" class="btn btn-secondary">Back</a>

			</form>
		</div>
	</div>

</body>
</html>