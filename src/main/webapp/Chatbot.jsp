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
<title>Hospital Chatbot</title>
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
/* Chat UI (kept minimal to match your theme) */
.chat-box {
	height: 400px;
	overflow-y: auto;
	padding: 15px;
	border-radius: 10px;
	background-color: #f8f9fc;
}

.msg-user {
	text-align: right;
	margin: 10px 0;
}

.msg-user span {
	background-color: var(--primary-color);
	color: white;
	padding: 8px 12px;
	border-radius: 15px;
	display: inline-block;
}

.msg-bot {
	text-align: left;
	margin: 10px 0;
}

.msg-bot span {
	background-color: #e2e6ea;
	padding: 8px 12px;
	border-radius: 15px;
	display: inline-block;
}
</style>
<script>
function sendMessage() {

	let msg = document.getElementById("msg").value;

	if (msg.trim() === "") return;

	fetch("chatbot", {
		method: "POST",
		headers: {
			"Content-Type": "application/x-www-form-urlencoded"
		},
		body: "message=" + encodeURIComponent(msg)
	})
	.then(res => res.text())
	.then(data => {

		let box = document.getElementById("chatBox");

		// User message
		let userDiv = document.createElement("div");
		userDiv.className = "msg-user";
		userDiv.innerHTML = "<span>" + msg + "</span>";

		// Bot reply
		let botDiv = document.createElement("div");
		botDiv.className = "msg-bot";
		botDiv.innerHTML = "<span>" + data + "</span>";

		box.appendChild(userDiv);
		box.appendChild(botDiv);

		box.scrollTop = box.scrollHeight;

		document.getElementById("msg").value = "";
	});
}
</script>

</head>

<body>

	<!-- Sidebar -->
	<div class="sidebar" id="sidebar">
		<div
			class="sidebar-header d-flex justify-content-between align-items-center">
			<h4 class="mb-0">Reception Help Desk</h4>
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
				<li class="nav-item"><a class="nav-link" href="staff"> <i
						class="fas fa-id-badge"></i> Staff
				</a></li>
				<li class="nav-item"><a class="nav-link" href="payment"> <i
						class="fas fa-money-bills"></i> Payment
				</a></li>
				<li class="nav-item"><a class="nav-link" href="Medicine.jsp">
						<i class="fas fa-boxes"></i> Medical Inventory
				</a></li>
				<li class="nav-item"><a class="nav-link" href="Ambulance.jsp">
						<i class="fas fa-ambulance"></i> Ambulance Service
				</a></li>
				<li class="nav-item"><a class="nav-link active" href="chatbot">
						<i class="fas fa-robot"></i> Chatbot
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

		<!-- Content -->
		<div class="container py-4">

			<h3 class="mb-4 text-center text-dark">Hospital Chatbot</h3>

			<div class="card p-3">

				<!-- Chat Area -->
				<div id="chatBox" class="chat-box">
					<div class="msg-bot">
						<span>Hello! Ask me about appointments, doctors, or
							timings.</span>
					</div>
				</div>

				<!-- Input -->
				<div class="input-group mt-3">
					<input type="text" id="msg" class="form-control"
						placeholder="Type your message...">
					<button type="button" class="btn btn-success"
						onclick="sendMessage()">Send</button>
				</div>

			</div>

		</div>
		<!-- Footer -->
		<footer class="text-center mt-5 pt-4 pb-3"> &copy; 2026
			Hospital Reception ERP System. All rights reserved. </footer>

	</div>

	<!-- Bootstrap JS -->
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.min.js"></script>

</body>
</html>