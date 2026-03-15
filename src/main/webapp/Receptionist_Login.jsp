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
	String registered = request.getParameter("registered");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Receptionist Login</title>
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
	width: 340px;
}

h1 {
	margin-top: 0;
	font-size: 22px;
	text-align: center;
	color: #2c3e50;
}

label {
	display: block;
	margin-top: 12px;
	font-weight: bold;
}

input[type="number"], input[type="password"] {
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
	background: #3498db;
	color: #fff;
	font-weight: bold;
	cursor: pointer;
}

.btn:hover {
	background: #2980b9;
}

.message {
	margin-top: 10px;
	font-size: 13px;
	text-align: center;
}

.message.error {
	color: #c0392b;
}

.message.success {
	color: #27ae60;
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
		<h1>Receptionist Login</h1>
		<%
		if ("1".equals(error)) {
		%>
		<div class="message error">Invalid receptionist ID or password.</div>
		<%
		}
		if ("1".equals(registered)) {
		%>
		<div class="message success">Registration successful. Please
			login.</div>
		<%
		}
		%>
		<form action="receptionist" method="post">
			<input type="hidden" name="action" value="login" /> <label
				for="receptionist_id">Receptionist ID</label> <input type="number"
				id="receptionist_id" name="receptionist_id" required /> <label
				for="password">Password</label> <input type="password" id="password"
				name="password" required />
			<button type="submit" class="btn">Login</button>
		</form>
		<div class="link">
			New receptionist? <a href="receptionist?action=registerForm">Register
				here</a>
		</div>
	</div>
</body>
</html>