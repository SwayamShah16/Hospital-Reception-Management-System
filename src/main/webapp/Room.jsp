<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ page
	import="java.util.*, java.text.SimpleDateFormat, POJO.RoomPOJO,DAO.RoomDAO"%>
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
if (!("Admin".equals(role) || "Staff".equals(role))) {
	response.sendRedirect("unauthorized.jsp");
	return;
}
%>
<%
String keyword = request.getParameter("keyword");

if (keyword == null) {
	keyword = "";
}
%>
<%!public String highlight(String text, String keyword) {
		if (text == null)
			return "";
		if (keyword == null || keyword.trim().isEmpty())
			return text;

		return text.replaceAll("(?i)(" + keyword + ")", "<span style='background:yellow;font-weight:bold;'>$1</span>");
	}%>
<!DOCTYPE html>
<html>
<head>
<title>Room Management</title>
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
	<%
	RoomDAO dao = new RoomDAO();
	List<RoomPOJO> list = dao.getAllRooms();
	%>
	<!-- Sidebar -->
	<div class="sidebar" id="sidebar">
		<div
			class="sidebar-header d-flex justify-content-between align-items-center">
			<h4 class="mb-0">Room Occupancy</h4>
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
				<li class="nav-item"><a class="nav-link active" href="room">
						<i class="fas fa-bed"></i> Rooms
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
					<a class="navbar-brand text-dark" href="dashboard"> Hospital
						ERP </a> <span class="me-3 text-dark">Logged in: <b
						class="bi bi-person"><%=username%> (<%=role%>) </b></span>
					<form action="UserServlet" method="get">
						<input type="hidden" name="action" value="logout">
						<button class="btn btn-warning btn-sm">Logout</button>
					</form>

				</div>
			</nav>
		</header>

		<div class="container py-4">
			<h3 class="mb-4 text-center text-dark">Rooms</h3>
			<div class="card p-3 mb-3">
				<form action="room" method="get" class="d-flex">
					<input type="hidden" name="action" value="search"> <input
						type="text" name="keyword" class="form-control me-2"
						placeholder="Search Room No or Type">
					<button class="btn btn-primary">Search</button>
				</form>
			</div>
			<!-- Patients Table -->
			<div class="card p-3">
				<table class="table table-striped table-bordered mb-0 text-center">
					<thead class="table-dark">
						<tr>
							<th>ID</th>
							<th>Room No</th>
							<th>Type</th>
							<th>Status</th>
							<th>Charges</th>
							<th>Action</th>
						</tr>
					</thead>
					<tbody>

						<%
						for (RoomPOJO r : list) {
						%>
						<tr>
							<td><%=r.getRoomId()%></td>
							<td><%=highlight(r.getRoomNumber(), keyword)%></td>
							<td><%=highlight(r.getRoomType(), keyword)%></td>

							<td>
								<%
								if ("Available".equals(r.getStatus())) {
								%> <span class="badge bg-success fs-6 px-2 py-1">Available</span>
								<%
								} else {
								%> <span class="badge bg-danger fs-6 px-2 py-1">Occupied</span>
								<%
								}
								%>
							</td>

							<td><%=r.getChargesPerDay()%></td>

							<td><a href="room?action=edit&id=<%=r.getRoomId()%>"
								class="btn btn-warning btn-sm">Edit</a></td>
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
