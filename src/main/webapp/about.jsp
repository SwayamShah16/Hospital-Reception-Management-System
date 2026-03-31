<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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

<!DOCTYPE html>
<html>
<head>
<title>About Us</title>
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
<style>
.sidebar {
	position: fixed;
	top: 0;
	left: 0;
	width: 250px;
	height: 100vh;
	overflow-y: auto;
	overflow-x: hidden;
	padding-top: 20px;
	background: #1e1e2f;
}

body {
	background: #f8f9fa; /* light grey background */
	font-family: 'Segoe UI', sans-serif;
	color: #212529; /* dark text */
}

/* MAIN CONTENT */
.main-content {
	margin-left: 250px;
	padding: 20px;
	height: 100vh;
	overflow: hidden; /* since you only want sidebar scroll */
}

/* PAGE TITLE */
.page-title {
	font-size: 28px;
	font-weight: bold;
	color: #0d6efd; /* Bootstrap blue */
	margin-bottom: 20px;
}

/* CARDS */
.card-custom {
	background: #ffffff;
	border-radius: 12px;
	padding: 20px;
	border: 1px solid #dee2e6;
	transition: 0.3s;
	color: #212529;
}

.card-custom:hover {
	box-shadow: 0 6px 15px rgba(0, 0, 0, 0.1);
}

/* FEATURES */
.feature-box {
	text-align: center;
	padding: 15px;
}

.feature-box i {
	font-size: 30px;
	color: #0d6efd;
	margin-bottom: 10px;
}

/* STATS */
.stats-box {
	background: #ffffff;
	border: 1px solid #dee2e6;
	padding: 15px;
	border-radius: 10px;
	text-align: center;
}

.stats-box h3 {
	color: #0d6efd;
}
</style>

</head>
<body>
	<!-- Sidebar -->
	<div class="sidebar" id="sidebar">
		<div
			class="sidebar-header d-flex justify-content-between align-items-center">
			<h4 class="mb-0">About Us</h4>
			<button class="btn btn-sm btn-outline-light d-md-none"
				id="sidebarToggle">
				<i class="bi bi-x"></i>
			</button>
		</div>
		<div class="sidebar-menu">
			<ul class="nav flex-column">
				<li class="nav-item"><a class="nav-link" href="dashboard">
						<i class="fas fa-tachometer-alt"></i> Dashboard
				</a></li>
				<li class="nav-item"><a class="nav-link" href="patient"> <i
						class="fas fa-user-injured"></i> Patient
				</a></li>
				<li class="nav-item"><a class="nav-link" href="doctor"> <i
						class="fas fa-user-md"></i> Doctor
				</a></li>
				<li class="nav-item"><a class="nav-link" href="appointment">
						<i class="fas fa-calendar-check"></i> Appointments
				</a></li>
				<li class="nav-item"><a class="nav-link" href="emergency">
						<i class="fas fa-calendar-check"></i> Emergency Cases
				</a></li>
				<li class="nav-item"><a class="nav-link" href="room"> <i
						class="fas fa-bed"></i> Rooms
				</a></li>
				<li class="nav-item"><a class="nav-link" href="payment"> <i
						class="fas fa-money-bills"></i> Payment
				</a></li>
				<li class="nav-item"><a class="nav-link" href="staff"> <i
						class="fas fa-id-badge"></i> Staff
				</a></li>
				<li class="nav-item"><a class="nav-link" href="Medicine.jsp">
						<i class="fas fa-boxes"></i> Medical Inventory
				</a></li>
				<li class="nav-item"><a class="nav-link" href="Ambulance.jsp">
						<i class="fas fa-ambulance"></i> Ambulance Service
				</a></li>
				<li class="nav-item"><a class="nav-link" href="chatbot"> <i
						class="fas fa-robot"></i> Chatbot
				</a></li>
				<li class="nav-item"><a class="nav-link active"
					href="about.jsp"> <i class="bi bi-info-circle"></i> About
				</a></li>
				<li class="nav-item"><a class="nav-link" href="contact.jsp">
						<i class="bi bi-person-rolodex"></i> Contact Us
				</a></li>
				<li class="nav-item"><a class="nav-link" href="DiseaseInfo.jsp">
						<i class="fa fa-book-medical"></i> Disease Info
				</a></li>
			</ul>
		</div>
	</div>
	<div class="main-content">
		<!-- Navbar (UNCHANGED) -->
		<header>
			<nav class="navbar">
				<div class="container-fluid text-center text-dark">
					<a class="navbar-brand text-dark" href="dashboard"> Hospital
						ERP </a> <span class="me-3 text-dark"> Logged in: <b
						class="bi bi-person"> <%=username%> (<%=role%>)
					</b>
					</span>

					<form action="UserServlet" method="get">
						<input type="hidden" name="action" value="logout">
						<button class="btn btn-warning btn-sm">Logout</button>
					</form>
				</div>
			</nav>
		</header>

		<!-- PAGE TITLE -->
		<div class="page-title">
			<i class="bi bi-info-circle"></i> About System
		</div>

		<!-- INTRO -->
		<div class="card-custom mb-4">
			<p class="mb-0">This Hospital Reception Management System is
				designed to streamline hospital operations by managing patient
				registration, appointments, billing, and doctor availability
				efficiently. It reduces manual work and ensures faster service for
				patients.</p>
		</div>

		<!-- MISSION & VISION -->
		<div class="row g-4 mb-4">
			<div class="col-md-6">
				<div class="card-custom h-100">
					<h5 class="mb-2">🎯 Mission</h5>
					<p class="mb-0">To provide a reliable and efficient system that
						enhances patient experience and minimizes administrative workload.</p>
				</div>
			</div>

			<div class="col-md-6">
				<div class="card-custom h-100">
					<h5 class="mb-2">🚀 Vision</h5>
					<p class="mb-0">To transform hospital management through
						digital innovation and seamless workflow automation.</p>
				</div>
			</div>
		</div>

		<!-- FEATURES -->
		<div class="card-custom mb-4">
			<h5 class="mb-3">Key Features</h5>
			<div class="row text-center">

				<div class="col-md-4 mb-3 feature-box">
					<i class="bi bi-person-plus"></i>
					<p class="mt-2 mb-0">Patient Registration</p>
				</div>

				<div class="col-md-4 mb-3 feature-box">
					<i class="bi bi-calendar-check"></i>
					<p class="mt-2 mb-0">Appointment Scheduling</p>
				</div>

				<div class="col-md-4 mb-3 feature-box">
					<i class="bi bi-cash-stack"></i>
					<p class="mt-2 mb-0">Billing Management</p>
				</div>

				<div class="col-md-4 mb-3 feature-box">
					<i class="bi bi-person-badge"></i>
					<p class="mt-2 mb-0">Doctor Management</p>
				</div>

				<div class="col-md-4 mb-3 feature-box">
					<i class="bi bi-clock-history"></i>
					<p class="mt-2 mb-0">Activity Logs</p>
				</div>

				<div class="col-md-4 mb-3 feature-box">
					<i class="bi bi-shield-lock"></i>
					<p class="mt-2 mb-0">Secure Access</p>
				</div>

			</div>
		</div>

		<!-- STATS -->
		<div class="row g-3 mb-4">
			<div class="col-md-3">
				<div class="stats-box">
					<h3>500+</h3>
					<p class="mb-0">Patients</p>
				</div>
			</div>

			<div class="col-md-3">
				<div class="stats-box">
					<h3>50+</h3>
					<p class="mb-0">Doctors</p>
				</div>
			</div>

			<div class="col-md-3">
				<div class="stats-box">
					<h3>1000+</h3>
					<p class="mb-0">Appointments</p>
				</div>
			</div>

			<div class="col-md-3">
				<div class="stats-box">
					<h3>24/7</h3>
					<p class="mb-0">Availability</p>
				</div>
			</div>
		</div>
	</div>
	<!-- FOOTER FIXED -->
	<div>
		<footer class="text-center mt-4 pb-3"> &copy; 2026 Hospital
			Reception ERP System. All rights reserved. </footer>
	</div>

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
