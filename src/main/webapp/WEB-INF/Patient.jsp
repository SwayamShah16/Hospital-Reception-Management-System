<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"
	import="java.util.List,DAO.PatientDAO,POJO.PatientPOJO"%>
<%
// Session check
javax.servlet.http.HttpSession session1 = request.getSession(false);
if (session1 == null || session.getAttribute("user") == null) {
	response.sendRedirect("login.jsp");
	return;
}

// Get patients (either from servlet attribute or directly via DAO)
List<PatientPOJO> patients = (List<PatientPOJO>) request.getAttribute("patients");
if (patients == null) {
	PatientDAO dao = new PatientDAO();
	patients = dao.getAllPatients();
}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Patient List</title>
<style>
body {
	font-family: Arial, sans-serif;
	margin: 20px;
}

h1 {
	color: #2c3e50;
}

table {
	border-collapse: collapse;
	width: 100%;
	margin-top: 15px;
}

th, td {
	border: 1px solid #ccc;
	padding: 8px;
	text-align: left;
}

th {
	background-color: #f0f0f0;
}

.actions a, .actions form {
	display: inline-block;
	margin-right: 5px;
}

.top-actions {
	margin-bottom: 10px;
}

.top-actions a {
	padding: 6px 12px;
	background: #3498db;
	color: #fff;
	text-decoration: none;
	border-radius: 4px;
}

.top-actions a:hover {
	background: #2980b9;
}

input[type="submit"] {
	padding: 4px 8px;
}
</style>
</head>
<body>
	<h1>Patient List</h1>

	<div class="top-actions">
		<a href="patient-form.jsp?action=create">Register New Patient</a>
	</div>

	<%
	if (patients == null || patients.isEmpty()) {
	%>
	<p>No patients found.</p>
	<%
	} else {
	%>
	<table>
		<thead>
			<tr>
				<th>ID</th>
				<th>First Name</th>
				<th>Last Name</th>
				<th>Gender</th>
				<th>Contact</th>
				<th>Email</th>
				<th>Blood Group</th>
				<th>Registration Date</th>
				<th>Actions</th>
			</tr>
		</thead>
		<tbody>
			<%
			for (PatientPOJO p : patients) {
			%>
			<tr>
				<td><%=p.getPatient_ID()%></td>
				<td><%=p.getPatient_first_name()%></td>
				<td><%=p.getPatient_last_name()%></td>
				<td><%=p.getPatient_gender()%></td>
				<td><%=p.getPatient_contact_no()%></td>
				<td><%=p.getPatient_email()%></td>
				<td><%=p.getBloodGroup()%></td>
				<td><%=p.getRegistration_Date()%></td>
				<td class="actions">
					<!-- Edit: open form pre-filled -->
					<form action="patient-form.jsp" method="get"
						style="display: inline;">
						<input type="hidden" name="action" value="update" /> <input
							type="hidden" name="patient_ID" value="<%=p.getPatient_ID()%>" />
						<input type="hidden" name="patient_first_name"
							value="<%=p.getPatient_first_name()%>" /> <input type="hidden"
							name="patient_last_name" value="<%=p.getPatient_last_name()%>" />
						<input type="hidden" name="patient_gender"
							value="<%=p.getPatient_gender()%>" /> <input type="hidden"
							name="patient_DOB" value="<%=p.getPatient_DOB()%>" /> <input
							type="hidden" name="patient_contact_no"
							value="<%=p.getPatient_contact_no()%>" /> <input type="hidden"
							name="patient_address" value="<%=p.getPatient_address()%>" />
						<input type="hidden" name="patient_email"
							value="<%=p.getPatient_email()%>" /> <input type="hidden"
							name="BloodGroup" value="<%=p.getBloodGroup()%>" /> <input
							type="hidden" name="Registration_Date"
							value="<%=p.getRegistration_Date()%>" /> <input type="submit"
							value="Edit" />
					</form> <!-- Delete: posts to servlet -->
					<form action="patient" method="post" style="display: inline;"
						onsubmit="return confirm('Are you sure you want to delete this patient?');">
						<input type="hidden" name="action" value="delete" /> <input
							type="hidden" name="patient_ID" value="<%=p.getPatient_ID()%>" />
						<input type="submit" value="Delete" />
					</form>
				</td>
			</tr>
			<%
			}
			%>
		</tbody>
	</table>
	<%
	}
	%>
</body>
</html>