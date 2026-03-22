<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ page
	import="java.util.*, java.text.SimpleDateFormat, POJO.DoctorPOJO"%>

<!DOCTYPE html>
<html>
<head>
<title>Doctor Management</title>
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
			<h4 class="mb-0">Hospital Dashboard</h4>
			<button class="btn btn-sm btn-outline-light d-md-none"
				id="sidebarToggle">
				<i class="bi bi-x"></i>
			</button>
		</div>
		<div class="sidebar-menu">
			<ul class="nav flex-column">
				<li class="nav-item"><a class="nav-link " href=""> <i
						class="bi bi-dashboard"></i> Dashboard
				</a></li>
				<li class="nav-item"><a class="nav-link " href="Patient.jsp">
						<i class="bi bi-speedometer2"></i> Patient
				</a></li>
				<li class="nav-item"><a class="nav-link active"
					href="Doctor.jsp"> <i class="bi bi-cart3"></i> Doctor
				</a></li>
				<li class="nav-item"><a class="nav-link" href=""> <i
						class="bi bi-exclamation-triangle"></i> Appointments
				</a></li>
				<li class="nav-item"><a class="nav-link" href=""> <i
						class="bi bi-person"></i> Rooms
				</a></li>
				<li class="nav-item"><a class="nav-link " href=""> <i
						class="bi bi-robot"></i> Medical Inventory
				</a></li>
				<li class="nav-item"><a class="nav-link " href=""> <i
						class="bi bi-chat-dots"></i> Chatbot
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

						<tr>
							<%
							List<DoctorPOJO> doctors = (List<DoctorPOJO>) request.getAttribute("doctorList");

							if (doctors != null && !doctors.isEmpty()) {
								for (DoctorPOJO d : doctors) {
							%>
							<td><%=d.getDoctor_ID()%></td>
							<td><%=d.getName()%></td>
							<td><%=d.getSpecialization()%></td>
							<td><%=d.getContact_Number()%></td>
							<td><%=d.getEmail()%></td>
							<td><%=d.getConsultation_Fee()%></td>
							<td><%=d.getAvailability_Status()%></td>

							<td><a
								href="DoctorServlet?action=edit&doctor_id=<%=d.getDoctor_ID()%>"
								class="btn btn-warning btn-sm">Edit</a> <a
								href="DoctorServlet?action=delete&doctor_id=<%=d.getDoctor_ID()%>"
								class="btn btn-danger btn-sm"
								onclick="return confirm('Are you sure?')">Delete</a></td>
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
