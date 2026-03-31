<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page
	import="DAO.AppointmentDAO, POJO.AppointmentPOJO, java.util.List"%>
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
<%!public String highlight(String text, String keyword) {
		if (text == null)
			return "";
		if (keyword == null || keyword.trim().isEmpty())
			return text;

		return text.replaceAll("(?i)(" + keyword + ")", "<span style='background:yellow;font-weight:bold;'>$1</span>");
	}%>
<%
AppointmentDAO dao = new AppointmentDAO();
String keyword = request.getParameter("keyword") == null ? "" : request.getParameter("keyword");
List<AppointmentPOJO> list = dao.getAllAppointments(keyword);
%>
<!DOCTYPE html>
<html>
<head>
<title>Appointment Management</title>
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
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
	rel="stylesheet">
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
}

.priority-high {
	background-color: #f8d7da;
} /* Red-ish for High */
.priority-normal {
	background-color: #fff3cd;
} /* Yellow-ish for Normal */
.priority-low {
	background-color: #d1e7dd;
} /* Green-ish for Low */
.table-actions a {
	margin-right: 5px;
}
</style>
</head>
<body>

	<!-- Sidebar -->
	<div class="sidebar" id="sidebar">
		<div
			class="sidebar-header d-flex justify-content-between align-items-center">
			<h4 class="mb-0">Appointments</h4>
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
				<li class="nav-item"><a class="nav-link active"
					href="appointment"> <i class="fas fa-calendar-check"></i>
						Appointments
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
	<div class="main-content">
		<header>
			<nav class="navbar navbar-expand-lg">
				<div class="container-fluid text-center">
					<a class="navbar-brand" href="dashboard"> Hospital ERP </a> <span
						class="me-3 text-dark">Logged in: <b class="bi bi-person"><%=username%>
							(<%=role%>) </b></span>
					<form action="UserServlet" method="get">
						<input type="hidden" name="action" value="logout">
						<button class="btn btn-warning btn-sm">Logout</button>
					</form>

				</div>
			</nav>
		</header>
		<div class="container p-3 mb-3">
			<div class="d-flex justify-content-between align-items-center mb-4">
				<h2>Appointments</h2>
				<a href="AddAppointment.jsp" class="btn btn-success">Add New
					Appointment</a>
			</div>

			<div class="card p-3 mb-3">

				<form action="appointment" method="get"
					class="row g-2 align-items-center">

					<input type="hidden" name="action" value="search">

					<!-- Search Input -->
					<div class="col-md-6">
						<input type="text" name="keyword" class="form-control"
							placeholder="Search by Patient or Doctor">
					</div>

					<!-- Buttons -->
					<div class="col-md-6 text-end">

						<button class="btn btn-primary">
							<i class="fas fa-search"></i> Search
						</button>

					</div>

				</form>

			</div>

			<div class="container">
				<table class="table table-hover table-bordered align-middle">
					<thead class="table-dark text-center">
						<tr>
							<th>ID</th>
							<th>Patient</th>
							<th>Doctor</th>
							<th>Receptionist</th>
							<th>Date</th>
							<th>Time</th>
							<th>Priority</th>
							<th>Remarks</th>
							<th>Action</th>
						</tr>
					</thead>
					<tbody>
						<%
						for (AppointmentPOJO a : list) {
							String cls = "priority-low";
							if ("High".equals(a.getPriority()))
								cls = "priority-high";
							else if ("Normal".equals(a.getPriority()))
								cls = "priority-normal";
						%>
						<tr class="<%=cls%> text-center">
							<td><%=a.getAppointmentId()%></td>
							<td><%=highlight(dao.getPatientName(a.getPatientId()), keyword)%></td>
							<td><%=highlight(dao.getDoctorName(a.getDoctorId()), keyword)%></td>
							<td><%=dao.getReceptionistName(a.getReceptionistId())%></td>
							<td><%=a.getAppointmentDate()%></td>
							<td><%=a.getAppointmentTime()%></td>
							<td><%=a.getPriority()%></td>
							<td><%=a.getRemarks()%></td>
							<td class="table-actions"><a
								href="EditAppointment.jsp?id=<%=a.getAppointmentId()%>"
								class="btn btn-sm btn-primary">Edit</a></td>
						</tr>
						<%
						}
						%>
					</tbody>
				</table>
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
