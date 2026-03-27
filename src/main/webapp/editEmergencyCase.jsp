<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page
	import="DAO.EmergencyCaseDAO, POJO.EmergencyCasePOJO, POJO.PatientPOJO, POJO.DoctorPOJO, java.util.List"%>

<%
HttpSession session1 = request.getSession(false);

if (session1 == null || session1.getAttribute("user_id") == null) {
	response.sendRedirect("login.jsp");
	return;
}

int userId = (int) session1.getAttribute("user_id");
String username = (String) session1.getAttribute("username");
String role = (String) session1.getAttribute("role");

if (!("Admin".equals(role) || "Doctor".equals(role))) {
	response.sendRedirect("unauthorized.jsp");
	return;
}

// Get Emergency Data
int id = Integer.parseInt(request.getParameter("id"));
EmergencyCaseDAO dao = new EmergencyCaseDAO();
EmergencyCasePOJO e = dao.getEmergencyById(id);

// Fetch Patients & Doctors
List<PatientPOJO> patients = dao.getAllPatients();
List<DoctorPOJO> doctors = dao.getAllDoctors();
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Edit Emergency Case</title>

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

			<h2 class="mb-4 text-danger">🚨 Edit Emergency Case</h2>

			<form action="emergency" method="post">
				<input type="hidden" name="action" value="update"> <input
					type="hidden" name="id" value="<%=e.getEmergencyId()%>">

				<!-- Patient -->
				<div class="mb-3">
					<label class="form-label">Patient</label> <select name="patient_id"
						class="form-select" required>
						<option value="<%=e.getPatientId()%>">Current</option>
						<%
						for (PatientPOJO p : patients) {
							if (p.getPatientId() != e.getPatientId()) {
						%>
						<option value="<%=p.getPatientId()%>">
							<%=p.getFirstName() + " " + p.getLastName()%>
						</option>
						<%
						}
						}
						%>
					</select>
				</div>

				<!-- Doctor -->
				<div class="mb-3">
					<label class="form-label">Doctor</label> <select name="doctor_id"
						class="form-select" required>
						<option value="<%=e.getDoctorId()%>">Current</option>
						<%
						for (DoctorPOJO d : doctors) {
							if (d.getDoctorId() != e.getDoctorId()) {
						%>
						<option value="<%=d.getDoctorId()%>">
							<%=d.getName()%>
						</option>
						<%
						}
						}
						%>
					</select>
				</div>

				<!-- Emergency Type -->
				<div class="mb-3">
					<label class="form-label">Emergency Type</label> <input type="text"
						name="type" class="form-control" value="<%=e.getEmergencyType()%>"
						required>
				</div>

				<!-- Severity -->
				<div class="mb-3">
					<label class="form-label">Severity Level</label> <select
						name="severity" class="form-select" required>
						<option value="Critical"
							<%="Critical".equals(e.getSeverityLevel()) ? "selected" : ""%>>Critical</option>
						<option value="Serious"
							<%="Serious".equals(e.getSeverityLevel()) ? "selected" : ""%>>Serious</option>
						<option value="Minor"
							<%="Minor".equals(e.getSeverityLevel()) ? "selected" : ""%>>Minor</option>
					</select>
				</div>

				<!-- Priority -->
				<div class="mb-3">
					<label class="form-label">Priority</label> <select name="priority"
						class="form-select" required>
						<option value="High"
							<%="High".equals(e.getPriorityLevel()) ? "selected" : ""%>>High</option>
						<option value="Medium"
							<%="Medium".equals(e.getPriorityLevel()) ? "selected" : ""%>>Medium</option>
						<option value="Low"
							<%="Low".equals(e.getPriorityLevel()) ? "selected" : ""%>>Low</option>
					</select>
				</div>

				<!-- Status -->
				<div class="mb-3">
					<label class="form-label">Status</label> <select name="status"
						class="form-select">
						<option value="Waiting"
							<%="Waiting".equals(e.getStatus()) ? "selected" : ""%>>Waiting</option>
						<option value="In Treatment"
							<%="In Treatment".equals(e.getStatus()) ? "selected" : ""%>>In
							Treatment</option>
						<option value="Completed"
							<%="Completed".equals(e.getStatus()) ? "selected" : ""%>>Completed</option>
					</select>
				</div>

				<!-- Info -->
				<div class="alert alert-warning">
					⚠ Arrival Time cannot be changed.<br> ⚡ Priority can be
					adjusted if needed.
				</div>

				<!-- Buttons -->
				<button type="submit" class="btn btn-danger">Update
					Emergency</button>
				<a href="ViewEmergencyCase.jsp" class="btn btn-secondary">Back</a>

			</form>

		</div>
	</div>

</body>
</html>