<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<title>Login - Secure Portal</title>

<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
	rel="stylesheet">

<style>

/* BACKGROUND */
body {
	margin: 0;
	font-family: cursive;
	background: linear-gradient(135deg, #0f2027, #2c5364);
	height: 100vh;
	display: flex;
	justify-content: center;
	align-items: center;
}

/* MAIN CARD */
.login-card {
	display: flex;
	width: 900px; /* 🔥 Bigger size */
	max-width: 95%;
	height: 450px;
	border-radius: 20px;
	overflow: hidden;
	box-shadow: 0 15px 40px rgba(0, 0, 0, 0.4);
	background: white;
	border-radius: 20px;
}

/* IMAGE SIDE */
.image-side {
	width: 50%;
	background:
		url('https://images.unsplash.com/photo-1579684385127-1ef15d508118')
		no-repeat center;
	background-size: cover;
}

/* FORM SIDE */
.form-side {
	width: 45%;
	padding: 50px;
}

/* MOBILE */
@media ( max-width : 768px) {
	.login-card {
		flex-direction: column;
		width: 90%;
	}
	.image-side {
		height: 200px;
		width: 100%;
	}
	.form-side {
		width: 100%;
		padding: 30px;
	}
}
</style>

</head>

<body>

	<div class="login-card">

		<!-- IMAGE -->
		<div class="image-side"></div>

		<!-- FORM -->
		<div class="form-side">

			<h3 class="text-center mb-3">Login</h3>

			<form action="UserServlet" method="post">
				<input type="hidden" name="action" value="login">

				<div class="form-floating mb-3">
					<input type="text" class="form-control" name="username" required>
					<label>Username</label>
				</div>

				<div class="form-floating mb-3">
					<input type="password" class="form-control" name="password"
						required> <label>Password</label>
				</div>

				<div class="form-floating mb-3">
					<input type="text" class="form-control" name="role" required>
					<label>Role</label>
				</div>

				<button class="btn btn-success w-100">Login</button>
			</form>

			<div class="text-center mt-3">
				New user? <a href="register.jsp">Register</a>
			</div>

			<%
			if ("1".equals(request.getParameter("error"))) {
			%>
			<div class="alert alert-danger mt-3">Invalid Username or
				Password or Role</div>
			<%
			}
			%>

		</div>

	</div>

</body>
</html>