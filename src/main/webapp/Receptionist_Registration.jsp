<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	// If already logged in, go to home/dashboard
	javax.servlet.http.HttpSession session1 = request.getSession(false);
	if (session1 != null && session1.getAttribute("user") != null) {
		response.sendRedirect("home.jsp");
		return;
	}

	String error = request.getParameter("error");
	String taken = request.getParameter("taken");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Receptionist Registration</title>
<style>
body {
	font-family: Arial, sans-serif;
	background: #f4f6f8;
	display: flex;
	justify-content: center;
	align-items: center;
	height: 100vh;
	margin: 0;
}

.card {
	background: #fff;
	padding: 24px 32px;
	border-radius: 8px;
	box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
	width: 420px;
	max-height: 90vh;
	overflow-y: auto;
}

h1 {
	margin-top: 0;
	font-size: 22px;
	text-align: center;
	color: #2c3e50;
}

label {
	display: block;
	margin-top: 10px;
	font-weight: bold;
}

input[type="number"], input[type="password"], input[type="email"], input[type="text"]
	{
	width: 100%;
	padding: 8px;
	margin-top: 4px;
	box-sizing: border-box;
	border: 1px solid #ccc;
	border-radius: 4px;
}

.btn {
	margin-top: 18px;
	width: 100%;
	padding: 10px;
	border: none;
	border-radius: 4px;
	background: #27ae60;
	color: #fff;
	font-weight: bold;
	cursor: pointer;
}

.btn:hover {
	background: #1e8449;
}

.message {
	margin-top: 10px;
	font-size: 13px;
	text-align: center;
}

.message.error {
	color: #c0392b;
}

.link {
	margin-top: 10px;
	font-size: 13px;
	text-align: center;
}

a {
	color: #3498db;
	text-decoration: none;
}

a:hover {
	text-decoration: underline;
}
</style>
</head>
<body>
	<div class="card">
		<h1>Receptionist Registration</h1>

		<%
		if ("1".equals(error)) {
		%>
		<div class="message error">There was a problem with your
			registration. Please check your inputs.</div>
		<%
		}
		if ("1".equals(taken)) {
		%>
		<div class="message error">Receptionist ID is already
			registered.</div>
		<%
		}
		%>

		<form action="receptionist" method="post">
			<input type="hidden" name="action" value="register" /> <label
				for="receptionist_id">Receptionist ID</label> <input type="number"
				id="receptionist_id" name="receptionist_id" required /> <label
				for="recep_name">Name</label> <input type="text" id="recep_name"
				name="recep_name" required /> <label for="recep_contact_no">Contact
				Number</label> <input type="number" id="recep_contact_no"
				name="recep_contact_no" required /> <label for="shift_timing">Shift
				Timing (e.g. 1, 2, 3)</label> <input type="number" id="shift_timing"
				name="shift_timing" required /> <label for="email">Email</label> <input
				type="email" id="email" name="email" required /> <label
				for="password">Password</label> <input type="password" id="password"
				name="password" required /> <label for="confirmPassword">Confirm
				Password</label> <input type="password" id="confirmPassword"
				name="confirmPassword" required />

			<button type="submit" class="btn">Register</button>
		</form>

		<div class="link">
			Already registered? <a href="receptionist?action=loginForm">Login here</a>
		</div>
	</div>
</body>
</html>