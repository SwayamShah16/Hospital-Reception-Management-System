<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ page
	import="java.util.*, java.text.SimpleDateFormat, POJO.DoctorPOJO"%>

<!DOCTYPE html>
<html>
<head>
<title>Doctor Management</title>
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
			<h4 class="mb-0">Doctor's Information</h4>
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
				<li class="nav-item"><a class="nav-link" href="Patient.jsp">
						<i class="fas fa-user-injured"></i> Patient
				</a></li>
				<li class="nav-item"><a class="nav-link active"
					href="Doctor.jsp"> <i class="fas fa-user-md"></i> Doctor
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
		<form action="Doctor" method="post">
			<input type="hidden" name="action" value="add"> Name: <input
				type="text" name="name"> Specialization: <input type="text"
				name="specialization"> Contact: <input type="text"
				name="contact"> Email: <input type="text" name="email">
			Fee: <input type="text" name="fee"> Status: <input
				type="text" name="status">

			<button type="submit">Add Doctor</button>
		</form>
		<form action="Doctor" method="get">
			<input type="hidden" name="action" value="filter">

			Specialization: <input type="text" name="specialization">
			Status: <input type="text" name="availability">

			<button type="submit">Filter</button>
		</form>
		<div class="container py-4">
			<h3 class="mb-4 text-center text-dark">Doctors</h3>
			<!-- Orders Table -->
			<div class="card p-3">
				<table class="table table-striped table-bordered mb-0 text-center">
					<thead class="table-dark">
						<tr>
							<th>Doctor ID</th>
							<th>Doctor Name</th>
							<th>Specialization</th>
							<th>Contact No.</th>
							<th>Email</th>
							<th>Fee</th>
							<th>Status</th>

						</tr>
					</thead>
					<tbody>
						<%
						List<DoctorPOJO> doctors = (List<DoctorPOJO>) request.getAttribute("doctorList");

						if (doctors != null && !doctors.isEmpty()) {
							for (DoctorPOJO d : doctors) {
						%>
						<tr>
							<td><%=d.getDoctor_ID()%></td>
							<td><%=d.getName()%></td>
							<td><%=d.getSpecialization()%></td>
							<td><%=d.getContact_Number()%></td>
							<td><%=d.getEmail()%></td>
							<td><%=d.getConsultation_Fee()%></td>
							<td><%=d.getAvailability_Status()%></td>

							<td><a href="Doctor?action=delete&id=<%=d.getDoctor_ID()%>">Delete</a>
							</td>
						</tr>
						<%
						}
						} else {
						%>
						<tr>
							<td colspan="8">No Doctors Found</td>
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
