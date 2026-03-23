<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ page
	import="java.util.*, java.text.SimpleDateFormat, POJO.PatientPOJO"%>
<%
List<PatientPOJO> patients = (List<PatientPOJO>) request.getAttribute("patients");
SimpleDateFormat sdf = new SimpleDateFormat("dd-MM-yyyy");
%>
<!DOCTYPE html>
<html>
<head>
<title>Patient Management</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
	rel="stylesheet">
<link
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css"
	rel="stylesheet">
<link
	href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap"
	rel="stylesheet">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
	rel="stylesheet">
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">
<link rel="stylesheet" href="style.css">

</head>
<body>

	<!-- Sidebar -->
	<div class="sidebar" id="sidebar">
		<div
			class="sidebar-header d-flex justify-content-between align-items-center">
			<h4 class="mb-0">Patient's Information</h4>
			<button class="btn btn-sm btn-outline-light d-md-none"
				id="sidebarToggle">
				<i class="bi bi-x"></i>
			</button>
		</div>
		<div class="sidebar-menu">
			<ul class="nav flex-column">
				<li class="nav-item"><a class="nav-link" href=""> <i
						class="fas fa-tachometer-alt"></i> Dashboard
				</a></li>
				<li class="nav-item"><a class="nav-link active"
					href="Patient.jsp"> <i class="fas fa-user-injured"></i> Patient
				</a></li>
				<li class="nav-item"><a class="nav-link" href="Doctor.jsp">
						<i class="fas fa-user-md"></i> Doctor
				</a></li>
				<li class="nav-item"><a class="nav-link" href=""> <i
						class="fas fa-calendar-check"></i> Appointments
				</a></li>
				<li class="nav-item"><a class="nav-link" href=""> <i
						class="fas fa-bed"></i> Rooms
				</a></li>
				<li class="nav-item"><a class="nav-link" href="Medicine.jsp">
						<i class="fas fa-boxes"></i> Medical Inventory
				</a></li>
				<li class="nav-item"><a class="nav-link" href="Ambulance.jsp">
						<i class="fas fa-ambulance"></i> Ambulance Service
				</a></li>
				<li class="nav-item"><a class="nav-link" href="Chatbot.jsp">
						<i class="fas fa-robot"></i> Chatbot
				</a></li>
			</ul>
		</div>
	</div>
	<div class="main-content">
		<!-- Navbar -->
		<nav class="navbar navbar-expand-lg">
			<div class="container-fluid text-center">
				<a class="navbar-brand" href=""> Hospital Reception ERP </a>

				<form action="UserServlet" method="post">
					<input type="hidden" name="action" value="logout">
					<button class="btn btn-light btn-sm">Logout</button>
				</form>

			</div>
		</nav>


		<div class="container py-4">
			<h3 class="mb-4 text-center text-dark">Patients</h3>


			<!-- Orders Table -->
			<div class="card p-3">
				<table class="table table-striped table-bordered mb-0 text-center">
					<thead class="table-dark">
						<tr>
							<th>Patient ID</th>
							<th>Patient Name</th>
							<th>Gender</th>
							<th>Date of Birth</th>
							<th>Contact No.</th>
							<th>Blood Group</th>

						</tr>
					</thead>
					<tbody>

						<%
						if (patients != null && !patients.isEmpty()) {
							for (PatientPOJO p : patients) {

								String dob = (p.getDob() != null) ? sdf.format(p.getDob()) : "N/A";
								String name = p.getFirst_Name() + " " + p.getLast_Name();
						%>

						<tr>
							<td><%=p.getPatient_ID()%></td>
							<td><%=name%></td>
							<td><%=p.getGender()%></td>
							<td><%=dob%></td>
							<td><%=p.getContact_Number()%></td>
							<td><%=p.getBlood_Group()%></td>
							<td><a
								href="patient?action=delete&id=<%=p.getPatient_ID()%>"
								class="btn btn-danger btn-sm">Delete</a></td>
						</tr>

						<%
						}
						} else {
						%>
						<tr>
							<td colspan="7">No Patients found</td>
						</tr>
						<%
						}
						%>
					</tbody>
				</table>
			</div>


		</div>
		<footer class="text-center mt-5 pt-4 pb-3 "">
			<!-- place footer here -->
			&copy; 2026 Hospital Reception ERP System. All rights reserved.
		</footer>
		<script
			src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js"
			integrity="sha384-I7E8VVD/ismYTF4hNIPjVp/Zjvgyol6VFvRkX/vR+Vc4jQkC+hVqc2pM8ODewa9r"
			crossorigin="anonymous"></script>

		<script
			src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.min.js"
			integrity="sha384-BBtl+eGJRgqQAUMxJ7pMwbEyER4l1g+O15P+16Ep7Q9Q+zqX6gSbd85u4mG4QzX+"
			crossorigin="anonymous"></script>

	</div>
</body>
</html>
