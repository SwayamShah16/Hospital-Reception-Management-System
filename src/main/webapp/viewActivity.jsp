<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>

<%
HttpSession session1 = request.getSession(false);

if (session1 == null || session1.getAttribute("user_id") == null) {
	response.sendRedirect("login.jsp");
	return;
}

String username = (String) session1.getAttribute("username");
String role = (String) session1.getAttribute("role");

List<String> activities = (List<String>) request.getAttribute("activities");
%>

<!DOCTYPE html>

<html>
<head>
<meta charset="UTF-8">
<title>All Activities</title>

<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
	rel="stylesheet">

<style>
body {
	background: #f8f9fc;
	font-family: 'Inter', sans-serif;
}

.container-box {
	background: white;
	padding: 25px;
	border-radius: 15px;
	box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
	margin-top: 30px;
}

.activity-item {
	padding: 12px;
	border-bottom: 1px solid #eee;
}

.activity-item:last-child {
	border-bottom: none;
}

.header-bar {
	display: flex;
	justify-content: space-between;
	align-items: center;
	margin-bottom: 20px;
}
</style>

</head>

<body>

	<div class="container">

		```
		<!-- Header -->
		<div class="header-bar mt-4">
			<h3>All Activity Logs</h3>
			<div>
				<span class="me-3">Logged in: <b><%=username%> (<%=role%>)</b></span>
				<a href="dashboard" class="btn btn-secondary btn-sm">Back</a>
			</div>
		</div>

		<!-- Activity Box -->
		<div class="container-box">

			<%
			if (activities != null && !activities.isEmpty()) {
				for (String act : activities) {
			%>
			<div class="activity-item">
				<%=act%>
			</div>
			<%
			}
			} else {
			%>
			<p>No activity found.</p>
			<%
			}
			%>

		</div>
		```

	</div>

</body>
</html>
