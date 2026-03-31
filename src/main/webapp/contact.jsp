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
<title>Contact Us</title>
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
/* MAIN CONTENT FIX */
.main-content {
	margin-left: 250px;
	padding: 20px;
	height: 100vh;
}

/* PAGE TITLE */
.page-title {
	font-size: 28px;
	font-weight: bold;
	color: #0d6efd;
	margin-bottom: 20px;
}

/* CARD DESIGN */
.card-custom {
	background: #ffffff;
	border-radius: 12px;
	padding: 20px;
	border: 1px solid #dee2e6;
	transition: 0.3s;
}

.card-custom:hover {
	box-shadow: 0 6px 15px rgba(0, 0, 0, 0.1);
}

/* FORM INPUT */
.form-control {
	border-radius: 8px;
}

/* CONTACT ICON */
.contact-icon {
	font-size: 22px;
	color: #0d6efd;
	margin-right: 10px;
}

/* BUTTON */
.btn-custom {
	background-color: #0d6efd;
	color: white;
	border-radius: 8px;
}

.btn-custom:hover {
	background-color: #0b5ed7;
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
				<li class="nav-item"><a class="nav-link" href="about.jsp">
						<i class="bi bi-info-circle"></i> About
				</a></li>
				<li class="nav-item"><a class="nav-link active"
					href="contact.jsp"> <i class="bi bi-person-rolodex"></i>
						Contact Us
				</a></li>
				<li class="nav-item"><a class="nav-link" href="DiseaseInfo.jsp">
						<i class="fa fa-book-medical"></i> Disease Info
				</a></li>
			</ul>
		</div>
	</div>
	<div class="main-content">

		<!-- Navbar (keep same as yours) -->
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

		<!-- TITLE -->
		<div class="page-title">
			<i class="bi bi-telephone"></i> Contact Us
		</div>

		<div class="row g-4">

			<!-- CONTACT INFO -->
			<div class="col-md-5">
				<div class="card-custom h-100">
					<h5 class="mb-3">Get in Touch</h5>

					<p>
						<i class="bi bi-geo-alt contact-icon"></i> XYZ Hospital, Mumbai,
						Maharashtra
					</p>

					<p>
						<i class="bi bi-telephone contact-icon"></i> +91 98765 43210
					</p>

					<p>
						<i class="bi bi-envelope contact-icon"></i> support@hospital.com
					</p>

					<p>
						<i class="bi bi-clock contact-icon"></i> Mon - Sat: 9 AM – 8 PM
					</p>

					<hr>

					<h6>Emergency</h6>
					<p class="text-danger fw-bold">
						<i class="bi bi-ambulance"></i> 102 / 108
					</p>
				</div>
			</div>

			<!-- CONTACT FORM -->
			<div class="col-md-7">
				<div class="card-custom">
					<h5 class="mb-3">Send Message</h5>
					<%
					String msg = request.getParameter("msg");
					if ("success".equals(msg)) {
					%>
					<div class="alert alert-success">Message sent successfully!</div>
					<%
					} else if ("error".equals(msg)) {
					%>
					<div class="alert alert-danger">Something went wrong!</div>
					<%
					}
					%>
					<form action="contact" method="post">

						<div class="mb-3">
							<label class="form-label">Full Name</label> <input type="text"
								name="name" class="form-control" required>
						</div>

						<div class="mb-3">
							<label class="form-label">Email</label> <input type="email"
								name="email" class="form-control" required>
						</div>

						<div class="mb-3">
							<label class="form-label">Phone</label> <input type="text"
								name="phone" class="form-control">
						</div>

						<div class="mb-3">
							<label class="form-label">Message</label>
							<textarea name="message" class="form-control" rows="4" required></textarea>
						</div>

						<button type="submit" class="btn btn-custom w-100">Send
							Message</button>

					</form>
				</div>
			</div>

		</div>

		<!-- FOOTER -->
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
