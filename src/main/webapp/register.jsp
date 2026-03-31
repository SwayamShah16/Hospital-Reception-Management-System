<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<title>Registration</title>

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
.register-card {
	display: flex;
	width: 900px;
	height: 450px;
	border-radius: 20px; overflow : hidden; box-shadow : 0 15px 40px rgba(
	0, 0, 0, 0.4);
	background: white;
	border-radius: 20px;
	overflow: hidden;
	box-shadow: 0 15px 40px rgba(0, 0, 0, 0.4);
	overflow: hidden;
	box-shadow: 0 15px 40px rgba(0, 0, 0, 0.4);
	border-radius: 20px;
	overflow: hidden;
	box-shadow: 0 15px 40px rgba(0, 0, 0, 0.4);
}

/* IMAGE SIDE */
.image-side {
	width: 50%;
	background:
		url('https://images.unsplash.com/photo-1586773860418-d37222d8fce3')
		no-repeat center;
	background-size: cover;
}

/* FORM SIDE */
.form-side {
	width: 50%;
	padding: 30px;
}

/* MOBILE */
@media ( max-width : 768px) {
	.register-card {
		flex-direction: column;
		width: 90%;
	}
	.image-side {
		height: 200px;
		width: 100%;
	}
	.form-side {
		width: 100%;
	}
}
</style>

<script>
	function showPopup(event) {
		event.preventDefault();
		alert("Successful Register!");
		event.target.submit();
	}
</script>

</head>

<body>

	<div class="register-card">

		<!-- IMAGE -->
		<div class="image-side"></div>

		<!-- FORM -->
		<div class="form-side">

			<h3 class="text-center mb-3">Registration</h3>

			<form action="UserServlet" method="post" onsubmit="showPopup(event)">
				<input type="hidden" name="action" value="register">

				<div class="form-floating mb-3">
					<input type="text" class="form-control" name="username"
						id="username" required> <label for="username">Username</label>
				</div>

				<div class="form-floating mb-3">
					<input type="password" class="form-control" name="password"
						id="password" required> <label for="password">Password</label>
				</div>

				<div class="form-floating mb-3">
					<input type="text" class="form-control" name="role" id="role"
						required> <label for="role">Role</label>
				</div>

				<button class="btn btn-primary w-100">Register</button>
			</form>

			<div class="text-center mt-3">
				Already have an account? <a href="login.jsp">Login</a>
			</div>

		</div>

	</div>

</body>
</html>