<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page
	import="DAO.AppointmentDAO, POJO.AppointmentPOJO, java.util.List, POJO.PatientPOJO, POJO.DoctorPOJO,POJO.ReceptionistPOJO"%>
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
if (!("Admin".equals(role) || "Doctor".equals(role))) {
    response.sendRedirect("unauthorized.jsp");
    return;
}
%>
<%
AppointmentDAO dao = new AppointmentDAO(); // DAO manages DB connection
List<PatientPOJO> patients = dao.getAllPatients();
List<DoctorPOJO> doctors = dao.getAllDoctors();
List<ReceptionistPOJO> receptionists = dao.getAllReceptionists();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Add Appointment</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
	rel="stylesheet">
</head>
<body>
	<div class="container mt-5">
		<h2 class="mb-4">Add New Appointment</h2>
		<form action="appointment" method="post">
			<input type="hidden" name="action" value="add">
			<div class="mb-3">
				<label class="form-label">Patient</label> <select name="patient_id"
					class="form-select" required>
					<option value="">-- Select Patient --</option>
					<%
					for (PatientPOJO p : patients) {
					%>
					<option value="<%=p.getPatientId()%>"><%=p.getFirstName() + " " + p.getLastName()%></option>
					<%
					}
					%>
				</select>
			</div>
			<div class="mb-3">
				<label class="form-label">Doctor</label> <select name="doctor_id"
					class="form-select" required>
					<option value="">-- Select Doctor --</option>
					<%
					for (DoctorPOJO d : doctors) {
					%>
					<option value="<%=d.getDoctorId()%>"><%=d.getName()%></option>
					<%
					}
					%>
				</select>
			</div>
			<div class="mb-3">
				<label class="form-label">Receptionist</label> <select
					name="receptionist_id" class="form-select" required>
					<option value="">-- Select Receptionist --</option>
					<%
					for (ReceptionistPOJO r : receptionists) {
					%>
					<option value="<%=r.getReceptionistId()%>"><%=r.getName()%></option>
					<%
					}
					%>
				</select>
			</div>
			<div class="mb-3">
				<label class="form-label">Appointment Date</label> <input
					type="date" name="appointment_date" class="form-control" required>
			</div>
			<div class="mb-3">
				<label class="form-label">Appointment Time</label> <input
					type="time" name="appointment_time" class="form-control" required>
			</div>
			<div class="mb-3">
				<label class="form-label">Priority</label> <select name="priority"
					class="form-select" required>
					<option value="High">High</option>
					<option value="Normal" selected>Normal</option>
					<option value="Low">Low</option>
				</select>
			</div>
			<div class="mb-3">
				<label class="form-label">Remarks</label>
				<textarea name="remarks" class="form-control" rows="3"></textarea>
			</div>
			<button type="submit" class="btn btn-primary">Add
				Appointment</button>
			<a href="ViewAppointment.jsp" class="btn btn-secondary">Back</a>
		</form>
	</div>
</body>
</html>