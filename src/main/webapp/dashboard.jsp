<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="java.util.List"%>
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
if (request.getAttribute("patients") == null) {
	response.sendRedirect("dashboard");
	return;
}
%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Dashboard</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
	rel="stylesheet">
<link
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css"
	rel="stylesheet">
<link
	href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap"
	rel="stylesheet">
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<!-- Angular CDN -->
<script src="https://cdn.jsdelivr.net/npm/angular@1.8.2/angular.min.js"></script>


<style>
:root {
	--sidebar-width: 250px;
	--primary: #dc3545;
	--primary-dark: #c82333;
	--success: #198754;
	--warning: #ffc107;
	--danger: #dc3545;
	--info: #0dcaf0;
	--light: #f8f9fa;
	--dark: #212529;
}

* {
	margin: 0;
	padding: 0;
	box-sizing: border-box;
}

body {
	font-family: 'Inter', sans-serif;
	background: var(--bg-main, linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%));
	color: var(--text-main, #000);
}

.sidebar {
	position: fixed;
	top: 0;
	left: 0;
	width: 250px;
	height: 100vh;
	overflow-y: auto;
	overflow-x: hidden;
	padding-top: 20px;
	background: linear-gradient(to right, #1A2980, #26D0CE);
	z-index: 1000;
	scrollbar-width: medium;
	scroll-behavior: smooth;
}

.main-content {
	margin-left: var(--sidebar-width) !important;
	min-height: 100vh;
	transition: margin-left 0.3s ease;
	background-color: var(--bg-main, #f8f9fc);
	padding: 2rem 1rem;
}

@media ( max-width : 768px) {
	.sidebar {
		transform: translateX(-100%);
	}
	.sidebar.active {
		transform: translateX(0);
	}
	.main-content {
		margin-left: 0 !important;
	}
}

.sidebar-overlay {
	display: none;
	position: fixed;
	top: 0;
	left: 0;
	width: 100%;
	height: 100%;
	background: rgba(0, 0, 0, 0.5);
	z-index: 999;
}

.sidebar-overlay.show {
	display: block;
}

.sidebar-header {
	padding: 1.5rem;
	border-bottom: 1px solid rgba(255, 255, 255, 0.1);
}

.sidebar-menu .nav-link {
	color: rgba(255, 255, 255, 0.8);
	padding: 0.75rem 1.5rem;
	margin-bottom: 0.5rem;
	border-left: 3px solid transparent;
	text-decoration: none;
}

.sidebar-menu .nav-link:hover, .sidebar-menu .nav-link.active {
	color: white;
	background-color: rgba(255, 255, 255, 0.1);
	border-left: 3px solid white;
}

.sidebar-menu .nav-link i {
	margin-right: 10px;
	font-size: 1.1rem;
	width: 20px;
}

/* Ambulance Stats Cards */
.stat-card {
	border: none;
	border-radius: 20px;
	box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
	transition: all 0.4s ease;
	overflow: hidden;
	height: 120px;
	position: relative;
}

.stat-card:hover {
	transform: translateY(-10px);
	box-shadow: 0 20px 40px rgba(0, 0, 0, 0.15);
}

.stat-card::before {
	content: '';
	position: absolute;
	top: 0;
	left: 0;
	right: 0;
	height: 4px;
}

.stat-primary::before {
	background: linear-gradient(90deg, var(--primary), #fd7e14);
}

.stat-success::before {
	background: linear-gradient(90deg, var(--success), #20c997);
}

.stat-warning::before {
	background: linear-gradient(90deg, var(--warning), #e83e8c);
}

.stat-info::before {
	background: linear-gradient(90deg, var(--info), #6610f2);
}

.stat-number {
	font-size: 2.5rem;
	font-weight: 700;
	line-height: 1;
}

.stat-icon {
	width: 60px;
	height: 60px;
	border-radius: 15px;
	display: flex;
	align-items: center;
	justify-content: center;
	font-size: 1.5rem;
	opacity: 0.9;
}

.alert-section {
	background: white;
	border-radius: 15px;
	padding: 1.5rem;
	box-shadow: 0 5px 15px rgba(0, 0, 0, 0.08);
	margin-bottom: 1rem;
	height: 100%;
}

.activity-box {
	height: 250px; /* fixed size */
	overflow-y: auto; /* scroll when overflow */
	padding-right: 5px;
}

.alert-item {
	display: flex;
	justify-content: space-between;
	align-items: center;
	padding: 0.75rem 0;
	border-bottom: 1px solid #eee;
	font-size: 0.9rem;
}

.alert-item:last-child {
	border-bottom: none;
}

.status-badge {
	font-size: 0.7rem;
	padding: 0.25rem 0.5rem;
}

.table-card {
	border-radius: 20px;
	overflow: hidden;
	box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
}

.table thead th {
	background: linear-gradient(135deg, var(--primary), var(--primary-dark));
	color: white;
	border: none;
	font-weight: 600;
	padding: 1.25rem 1rem;
}

.fade-in {
	animation: fadeIn 0.6s ease-in;
}

@
keyframes fadeIn {from { opacity:0;
	transform: translateY(20px);
}

to {
	opacity: 1;
	transform: translateY(0);
}

}

/* Ambulance Status Colors */
.status-available {
	background-color: #d4edda;
	color: #155724;
}

.status-busy {
	background-color: #fff3cd;
	color: #856404;
}

.status-maintenance {
	background-color: #f8d7da;
	color: #721c24;
}
/* DARK MODE VARIABLES */
body.dark-mode {
	--bg-main: #121212;
	--bg-card: #1e1e1e;
	--bg-sidebar: linear-gradient(to right, #0f2027, #203a43, #2c5364);
	--text-main: #ffffff;
	--text-muted: #b0b0b0;
	--border-color: #2c2c2c;
}
/* Cards */
.dark-mode .stat-card, .dark-mode .alert-section, .dark-mode .table-card
	{
	background-color: var(--bg-card);
	color: var(--text-main);
	box-shadow: 0 10px 25px rgba(0, 0, 0, 0.6);
}

/* Activity & Alerts */
.dark-mode .alert-item {
	border-bottom: 1px solid var(--border-color);
	color: var(--text-main);
}

/* Navbar */
.dark-mode .navbar {
	background-color: #1e1e1e;
}

/* Footer */
.dark-mode footer {
	background-color: #1e1e1e;
	color: var(--text-muted);
}

.dark-mode .table {
	color: white;
}

.dark-mode .table thead th {
	background: #333 !important;
}

.dark-mode .badge {
	opacity: 0.9;
}

.dark-mode .sidebar-menu .nav-link {
	color: rgba(255, 255, 255, 0.7);
}

.dark-mode .sidebar-menu .nav-link:hover, .dark-mode .sidebar-menu .nav-link.active
	{
	background-color: rgba(255, 255, 255, 0.15);
	color: white;
}

body, .card, .alert-section, .navbar {
	transition: all 0.3s ease;
}
/* Fix navbar text in dark mode */
.dark-mode .navbar-brand, .dark-mode .navbar span, .dark-mode .navbar b
	{
	color: #ffffff !important;
}
</style>
</head>

<body ng-app="AmbulanceApp">
	<!-- Sidebar Overlay -->
	<div class="sidebar-overlay" id="sidebarOverlay"></div>

	<!-- Sidebar -->
	<div class="sidebar" id="sidebar">
		<div
			class="sidebar-header d-flex justify-content-between align-items-center">
			<h4 class="mb-0 text-white">Dashboard</h4>
			<button class="btn btn-sm btn-outline-light d-md-none"
				id="sidebarToggle">
				<i class="fas fa-times"></i>
			</button>
		</div>
		<div class="sidebar-menu">
			<ul class="nav flex-column">
				<li class="nav-item"><a class="nav-link active"
					href="dashboard"> <i class="fas fa-tachometer-alt"></i>
						Dashboard
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
				<li class="nav-item"><a class="nav-link" href="about.jsp">
						<i class="bi bi-info-circle"></i> About
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

	<!-- Main Content -->
	<div class="main-content" ng-controller="DashboardController">
		<header>
			<nav class="navbar navbar-expand-lg">
				<div class="container-fluid text-center">
					<a class="navbar-brand" href="dashboard.jsp"> Hospital ERP </a> <span
						class="me-3 ">Logged in: <b class="bi bi-person"><%=username%>
							(<%=role%>) </b></span>
					<button onclick="toggleDarkMode()" class="btn btn-dark btn-sm">🌙</button>

					<form action="UserServlet" method="get">
						<input type="hidden" name="action" value="logout">
						<button class="btn btn-warning btn-sm">Logout</button>
					</form>

				</div>
			</nav>
		</header>
		<div class="container mt-4 fade-in">

			<!-- STATS -->
			<div class="row g-4 justify-content-center">

				<!-- First Row -->
				<div class="col-md-3">
					<div class="card stat-card stat-info p-3 text-center">
						<h6>Total Patients</h6>
						<h2 class="stat-number"><%=request.getAttribute("patients")%></h2>
					</div>
				</div>

				<div class="col-md-3">
					<div class="card stat-card stat-success p-3 text-center">
						<h6>Total Doctors</h6>
						<h2 class="stat-number"><%=request.getAttribute("doctors")%></h2>
					</div>
				</div>

				<div class="col-md-3">
					<div class="card stat-card stat-warning p-3 text-center">
						<h6>Appointments</h6>
						<h2 class="stat-number"><%=request.getAttribute("appointments")%></h2>
					</div>
				</div>

				<div class="col-md-3">
					<div class="card stat-card stat-info p-3 text-center">
						<h6>Total Revenue</h6>
						<h2 class="stat-number">
							₹
							<%=request.getAttribute("revenue")%></h2>
					</div>
				</div>

			</div>

			<div class="row g-4 justify-content-center mt-2">

				<div class="col-md-3">
					<div class="card stat-card stat-success p-3 text-center">
						<h6>Total Staff</h6>
						<h2 class="stat-number">
							<%=request.getAttribute("staff") != null ? request.getAttribute("staff") : 0%>
						</h2>
					</div>
				</div>

				<div class="col-md-3">
					<div class="card stat-card stat-warning p-3 text-center">
						<h6>Total Rooms</h6>
						<h2 class="stat-number">
							<%=request.getAttribute("rooms") != null ? request.getAttribute("rooms") : 0%>
						</h2>
					</div>
				</div>

			</div>
		</div>

		<div class="row mt-5 pt-3">

			<!-- Activity Logs -->
			<div class="col-md-6">
				<div class="alert-section">

					<!-- Header with button -->
					<div class="d-flex justify-content-between align-items-center mb-2">
						<h5 class="mb-0">Recent Activity</h5>
						<a href="viewActivity" class="btn btn-sm btn-primary">View All</a>
					</div>

					<!-- Scrollable Box -->
					<div class="activity-box">

						<%
						List<String> activities = (List<String>) request.getAttribute("activities");

						if (activities != null && !activities.isEmpty()) {
							for (String act : activities) {
						%>
						<div class="alert-item">
							<span><%=act%></span> <span class="badge bg-success status-badge">Recent</span>
						</div>
						<%
						}
						} else {
						%>
						<div class="alert-item">
							<span>No recent activity</span>
						</div>
						<%
						}
						%>

					</div>

				</div>
			</div>

			<!-- Announcements -->
			<div class="col-md-6">
				<div class="alert-section h-100">
					<h5>Important Announcements</h5>

					<div class="alert-item">
						<span>COVID guidelines updated</span> <span
							class="badge bg-danger status-badge">New</span>
					</div>

					<div class="alert-item">
						<span>New cardiologist joined</span> <span
							class="badge bg-success status-badge">Info</span>
					</div>

					<div class="alert-item">
						<span>Maintenance on Sunday</span> <span
							class="badge bg-warning status-badge">Alert</span>
					</div>

					<div class="alert-item">
						<span>Emergency ward expansion</span> <span
							class="badge bg-primary status-badge">Update</span>
					</div>

				</div>
			</div>

		</div>
		<div>
			<footer class="text-center mt-5 pt-4 pb-3 "">
				<!-- place footer here -->
				&copy; 2026 Hospital Reception ERP System. All rights reserved.
			</footer>
		</div>
	</div>

	<!-- Bootstrap JS -->
	<script>
		function toggleDarkMode() {
			document.body.classList.toggle("dark-mode");

			if (document.body.classList.contains("dark-mode")) {
				localStorage.setItem("theme", "dark");
			} else {
				localStorage.setItem("theme", "light");
			}
		}

		// IMPORTANT FIX
		document.addEventListener("DOMContentLoaded", function() {
			if (localStorage.getItem("theme") === "dark") {
				document.body.classList.add("dark-mode");
			}
		});
	</script>
	</script>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

	<!-- Angular Controller & Sidebar Toggle -->
	<script
		src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js"
		integrity="sha384-I7E8VVD/ismYTF4hNIPjVp/Zjvgyol6VFvRkX/vR+Vc4jQkC+hVqc2pM8ODewa9r"
		crossorigin="anonymous"></script>

	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.min.js"
		integrity="sha384-BBtl+eGJRgqQAUMxJ7pMwbEyER4l1g+O15P+16Ep7Q9Q+zqX6gSbd85u4mG4QzX+"
		crossorigin="anonymous"></script>
</body>
</html>