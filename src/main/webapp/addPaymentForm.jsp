<%@ page import="java.util.*,POJO.PaymentPOJO,DAO.PaymentDAO"%>
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
if (!("Admin".equals(role) || "Doctor".equals(role) || "Staff".equals(role))) {
	response.sendRedirect("unauthorized.jsp");
	return;
}
%>
<!DOCTYPE html>
<html>
<head>
<title>Add Payment</title>
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
			<h4 class="mb-0">Payment</h4>
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
				<li class="nav-item"><a class="nav-link active" href="payment">
						<i class="fas fa-money-bills"></i> Payment
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

		<br>
		<div class="container">
			<h3 class="mb-4 text-center text-dark">Add Payment</h3>

			<div class="container-fluid mt-4">
				<div class="card shadow-sm">
					<div class="card-header bg-primary text-white">
						<h5 class="mb-0">Process Payment</h5>
					</div>
					<div class="card-body">
						<form action="payment" method="post">
							<div class="mb-3">
								<label class="form-label">Appointment ID</label> <input
									type="number" name="appointmentId" class="form-control"
									placeholder="Enter Appointment ID" required>
							</div>

							<div class="mb-3">
								<label class="form-label">Patient ID</label> <input
									type="number" name="patientId" class="form-control"
									placeholder="Enter Patient ID" required>
							</div>

							<div class="mb-3">
								<label class="form-label">Amount</label> <input type="text"
									name="amount" class="form-control" placeholder="Enter Amount"
									required>
							</div>

							<div class="mb-3">
								<label class="form-label">Payment Date</label> <input
									type="date" name="paymentDate" class="form-control" required>
							</div>

							<div class="mb-3">
								<label class="form-label">Payment Mode</label> <select
									name="paymentMode" class="form-select" required>
									<option value="Cash">Cash</option>
									<option value="Card">Card</option>
									<option value="UPI">UPI</option>
									<option value="Cheque">Cheque</option>
								</select>
							</div>

							<button type="submit" class="btn btn-success">Pay Now</button>


						</form>
						<!-- Payment completion message -->
						<%
						String message = (String) request.getAttribute("message");
						if (message != null) {
							String alertClass = message.toLowerCase().contains("success") ? "alert-success" : "alert-danger";
						%>
						<div class="alert <%=alertClass%> mt-3" role="alert">
							<%=message%>
						</div>
						<%
						}
						%>
					</div>
					<div class="text-center my-2">
						<form action="paymentStatus" method="get">
							<button type="submit" class="btn btn-warning ">View
								Payments</button>
						</form>
					</div>
				</div>
			</div>
		</div>

		<footer class="text-center mt-5 pt-4 pb-3 "">
			<!-- place footer here -->
			&copy; 2026 Hospital Reception ERP System. All rights reserved.
		</footer>
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
