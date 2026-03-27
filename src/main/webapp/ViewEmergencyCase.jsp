<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page
	import="DAO.EmergencyCaseDAO, POJO.EmergencyCasePOJO, java.util.List"%>

<%
HttpSession session1 = request.getSession(false);

if (session1 == null || session1.getAttribute("user_id") == null) {
	response.sendRedirect("login.jsp");
	return;
}

int userId = (int) session1.getAttribute("user_id");
String username = (String) session1.getAttribute("username");
String role = (String) session1.getAttribute("role");

if (!("Admin".equals(role) || "Doctor".equals(role) || "Staff".equals(role))) {
	response.sendRedirect("unauthorized.jsp");
	return;
}

EmergencyCaseDAO dao = new EmergencyCaseDAO();
String keyword = request.getParameter("keyword") == null ? "" : request.getParameter("keyword");
List<EmergencyCasePOJO> list = dao.getAllEmergencies();
%>

<!DOCTYPE html>
<html>
<head>
<title>Emergency Management</title>

<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
	rel="stylesheet">
<link
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css"
	rel="stylesheet">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css"
	rel="stylesheet">
<link rel="stylesheet" href="style.css">
<style>
.priority-high {
	background-color: #f8d7da;
}

.priority-medium {
	background-color: #fff3cd;
}

.priority-low {
	background-color: #d1e7dd;
}

.status-waiting {
	font-weight: bold;
	color: red;
}

.status-progress {
	font-weight: bold;
	color: orange;
}

.status-done {
	font-weight: bold;
	color: green;
}
</style>
</head>

<body>

	<!-- Sidebar -->
	<div class="sidebar" id="sidebar">
		<div class="sidebar-header">
			<h4>Emergency Cases</h4>
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
				<li class="nav-item"><a class="nav-link active"
					href="emergency"> <i class="fas fa-calendar-check"></i>
						Emergency Cases
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
				<li class="nav-item"><a class="nav-link" href=""> <i
						class="fas fa-robot"></i> Chatbot
				</a></li>
			</ul>
		</div>
	</div>

	<div class="main-content">

		<!-- Navbar -->
		<nav class="navbar navbar-expand-lg">
			<div class="container-fluid text-center">
				<a class="navbar-brand" href="profile.jsp"> Hospital ERP </a> <span
					class="me-3 text-white">Logged in: <b class="bi bi-person"><%=username%>
						(<%=role%>) </b></span>
				<form action="UserServlet" method="post">
					<input type="hidden" name="action" value="logout">
					<button class="btn btn-light btn-sm">Logout</button>
				</form>

			</div>
		</nav>

		<div class="container p-3">

			<div class="d-flex justify-content-between mb-3">
				<h2>Emergency Cases</h2>
				<a href="addEmergencyCase.jsp" class="btn btn-danger">+ Add
					Emergency</a>
			</div>

			<!-- Search -->
			<form class="row g-2 mb-3" method="get">
				<div class="col-auto">
					<input type="text" name="keyword" class="form-control"
						placeholder="Search by patient or type" value="<%=keyword%>">
				</div>
				<div class="col-auto">
					<button class="btn btn-primary">Search</button>
				</div>
			</form>

			<!-- Table -->
			<table class="table table-bordered table-hover text-center">
				<thead class="table-dark">
					<tr>
						<th>ID</th>
						<th>Patient</th>
						<th>Doctor</th>
						<th>Type</th>
						<th>Severity</th>
						<th>Priority</th>
						<th>Arrival</th>
						<th>Status</th>
						<th>Action</th>
					</tr>
				</thead>

				<tbody>
					<%
					for (EmergencyCasePOJO e : list) {

						String rowClass = "priority-low";
						if ("High".equals(e.getPriorityLevel()))
							rowClass = "priority-high";
						else if ("Medium".equals(e.getPriorityLevel()))
							rowClass = "priority-medium";

						String statusClass = "status-waiting";
						if ("In Treatment".equals(e.getStatus()))
							statusClass = "status-progress";
						else if ("Completed".equals(e.getStatus()))
							statusClass = "status-done";
					%>

					<tr class="<%=rowClass%>">
						<td><%=e.getEmergencyId()%></td>
						<td><%=dao.getPatientName(e.getPatientId())%></td>
						<td><%=dao.getDoctorName(e.getDoctorId())%></td>
						<td><%=e.getEmergencyType()%></td>
						<td><%=e.getSeverityLevel()%></td>
						<td><%=e.getPriorityLevel()%></td>
						<td><%=e.getArrivalTime()%></td>
						<td class="<%=statusClass%>"><%=e.getStatus()%></td>

						<td class="table-actions"><a
							href="editEmergencyCase.jsp?id=<%=e.getEmergencyId()%>"
							class="btn btn-sm btn-primary">Edit</a>

							<form action="emergency" method="post" style="display: inline;">
								<input type="hidden" name="action" value="delete"> <input
									type="hidden" name="id" value="<%=e.getEmergencyId()%>">
								<button class="btn btn-sm btn-danger">Delete</button>
							</form></td>
					</tr>

					<%
					}
					%>
				</tbody>
			</table>

		</div>

		<footer class="text-center mt-4"> &copy; 2026 Hospital ERP </footer>

	</div>

</body>
</html>