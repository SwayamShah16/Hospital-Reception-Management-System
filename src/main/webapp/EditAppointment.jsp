<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page
	import="DAO.AppointmentDAO, POJO.AppointmentPOJO, POJO.PatientPOJO, POJO.DoctorPOJO, POJO.ReceptionistPOJO, java.util.List"%>
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
if (!("Admin".equals(role) || "Doctor".equals(role) || "Staff".equals(role))) {
	response.sendRedirect("unauthorized.jsp");
	return;
}
%>
<%
int id = Integer.parseInt(request.getParameter("id"));
AppointmentDAO dao = new AppointmentDAO();
AppointmentPOJO a = dao.getAppointmentById(id);
List<PatientPOJO> patients = dao.getAllPatients();
List<DoctorPOJO> doctors = dao.getAllDoctors();
List<ReceptionistPOJO> receptionists = dao.getAllReceptionists();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Edit Appointment</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
	rel="stylesheet">
</head>
<body>
	<div class="container mt-5">
		<h2 class="mb-4">Edit Appointment</h2>
		<form action="appointment" method="post">
			<input type="hidden" name="action" value="edit"> <input
				type="hidden" name="appointment_id"
				value="<%=a.getAppointmentId()%>">
			<!-- Patient -->
			<div class="mb-3">
				<label class="form-label">Patient</label> <select name="patient_id"
					class="form-select" required>
					<option value="<%=a.getPatientId()%>">Current</option>
					<%
					for (PatientPOJO p : patients) {
						if (p.getPatientId() != a.getPatientId()) {
					%>
					<option value="<%=p.getPatientId()%>"><%=p.getFirstName() + " " + p.getLastName()%></option>
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
					<option value="<%=a.getDoctorId()%>">Current</option>
					<%
					for (DoctorPOJO d : doctors) {
						if (d.getDoctorId() != a.getDoctorId()) {
					%>
					<option value="<%=d.getDoctorId()%>"><%=d.getName()%></option>
					<%
					}
					}
					%>
				</select>
			</div>
			<!-- Receptionist -->
			<div class="mb-3">
				<label class="form-label">Receptionist</label> <select
					name="receptionist_id" class="form-select" required>
					<option value="<%=a.getReceptionistId()%>">Current</option>
					<%
					for (ReceptionistPOJO r : receptionists) {
						if (r.getReceptionistId() != a.getReceptionistId()) {
					%>
					<option value="<%=r.getReceptionistId()%>"><%=r.getName()%></option>
					<%
					}
					}
					%>
				</select>
			</div>
			<div class="mb-3">
				<label class="form-label">Date</label> <input type="date"
					name="appointment_date" class="form-control"
					value="<%=a.getAppointmentDate()%>" required>
			</div>
			<div class="mb-3">
				<label class="form-label">Time</label> <input type="time"
					name="appointment_time" class="form-control"
					value="<%=a.getAppointmentTime()%>" required>
			</div>
			<div class="mb-3">
				<label class="form-label">Priority</label> <select name="priority"
					class="form-select" required>
					<option value="High"
						<%="High".equals(a.getPriority()) ? "selected" : ""%>>High</option>
					<option value="Normal"
						<%="Normal".equals(a.getPriority()) ? "selected" : ""%>>Normal</option>
					<option value="Low"
						<%="Low".equals(a.getPriority()) ? "selected" : ""%>>Low</option>
				</select>
			</div>
			<div class="mb-3">
				<label class="form-label">Remarks</label>
				<textarea name="remarks" class="form-control" rows="3"><%=a.getRemarks()%></textarea>
			</div>
			<button type="submit" class="btn btn-primary">Update</button>
			<a href="ViewAppointments.jsp" class="btn btn-secondary">Back</a>
		</form>
	</div>
</body>
</html>