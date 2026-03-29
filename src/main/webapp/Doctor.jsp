<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ page
	import="java.util.*, java.text.SimpleDateFormat, POJO.DoctorPOJO,DAO.DoctorDAO"%>
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
String keyword = request.getParameter("keyword");
if (keyword == null)
	keyword = "";
%>
<%!public String highlight(String text, String keyword) {
		if (text == null)
			return "";
		if (keyword == null || keyword.trim().isEmpty())
			return text;

		return text.replaceAll("(?i)(" + keyword + ")", "<span style='background:yellow;font-weight:bold;'>$1</span>");
	}%>
<%
DoctorDAO dao = new DoctorDAO();
List<DoctorPOJO> list = dao.getAllDoctors();
%>
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
				<li class="nav-item"><a class="nav-link" href="dashboard">
						<i class="fas fa-tachometer-alt"></i> Dashboard
				</a></li>
				<li class="nav-item"><a class="nav-link" href="patient"> <i
						class="fas fa-user-injured"></i> Patient
				</a></li>
				<li class="nav-item"><a class="nav-link active" href="doctor">
						<i class="fas fa-user-md"></i> Doctor
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
			</ul>
		</div>
	</div>
	<div class="main-content">
		<!-- Navbar -->

		<header>
			<nav class="navbar">
				<div class="container-fluid text-center text-dark">
					<a class="navbar-brand text-dark" href="dashboard">
						Hospital ERP </a> <span class="me-3 text-dark">Logged in: <b
						class="bi bi-person"><%=username%> (<%=role%>) </b></span>
					<form action="UserServlet" method="post">
						<input type="hidden" name="action" value="logout">
						<button class="btn btn-warning btn-sm">Logout</button>
					</form>

				</div>
			</nav>
		</header>


		<div class="container py-4">
			<h3 class="mb-4 text-center text-dark">Doctors</h3>

			<div class="container p-3 mb-3">
				<form action="doctor" method="get"
					class="d-flex mb-2 align-item-center">
					<input type="hidden" name="action" value="search"> <input
						class="col-md-6" type="text" name="keyword" class="form-control "
						placeholder="Search Doctor Name or Specialization"><br>
					<button class="btn btn-primary">Search</button>
					<br> <a href="doctor?action=list" class="btn btn-secondary">
						Reset </a><br> <a href="addDoctor.jsp" class="btn btn-success">
						+ Add Doctor </a>
				</form>
			</div>
			<!-- CARD GRID -->
			<div class="row">

				<%
				for (DoctorPOJO d : list) {
				%>

				<div class="col-md-4 mb-4">
					<div class="card shadow h-100">

						<div class="card-body text-center">

							<!-- Doctor Name -->
							<h5 class="card-title fw-bold"><%=highlight(d.getName(), keyword)%></h5>

							<!-- Specialization -->
							<p class="text-muted"><%=highlight(d.getSpecialization(), keyword)%></p>

							<!-- Fee -->
							<p class="fw-semibold">
								₹
								<%=d.getConsultationFee()%></p>

							<!-- Status Badge -->
							<%
							if ("Available".equals(d.getAvailabilityStatus())) {
							%>
							<span class="badge bg-success px-3 py-2">Available</span>
							<%
							} else {
							%>
							<span class="badge bg-danger px-3 py-2">Unavailable</span>
							<%
							}
							%>

							<hr>

							<!-- Contact -->
							<p>
								<i class="bi bi-telephone"></i>
								<%=highlight(d.getContactNumber(), keyword)%></p>

							<!-- Email -->
							<p>
								<i class="bi bi-envelope"></i>
								<%=d.getEmail()%></p>

							<!-- Actions -->
							<div class="mt-3">
								<a href="doctor?action=edit&id=<%=d.getDoctorId()%>"
									class="btn btn-warning btn-sm">Edit</a> <a
									href="doctor?action=delete&id=<%=d.getDoctorId()%>"
									class="btn btn-danger btn-sm">Delete</a>
							</div>

						</div>

					</div>
				</div>

				<%
				}
				%>


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
