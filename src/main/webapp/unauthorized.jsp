<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>Access Denied</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
	rel="stylesheet">

<style>
body {
	background: linear-gradient(to right, #e3f2fd, #ffffff);
	font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
}

.card {
	border-radius: 15px;
	box-shadow: 0 8px 20px rgba(0, 0, 0, 0.1);
}

.icon {
	font-size: 60px;
}

.btn-custom {
	border-radius: 25px;
	padding: 10px 25px;
}
</style>
</head>

<body>

	<div
		class="container d-flex justify-content-center align-items-center vh-100">
		<div class="card p-5 text-center"
			style="max-width: 500px; width: 100%;">

			<div class="icon text-danger mb-3">❌</div>

			<h2 class="text-danger fw-bold">Access Denied</h2>

			<p class="mt-3 text-muted">
				You do not have permission to access this page.<br> Please
				contact the administrator if you believe this is a mistake.
			</p>

			<div class="mt-4">
				<a href="dashboard.jsp" class="btn btn-primary btn-custom me-2">
					🏠 Go to Dashboard </a> <a href="UserServlet?action=logout"
					class="btn btn-outline-danger btn-custom"> 🔓 Logout </a>
			</div>

		</div>
	</div>

</body>
</html>