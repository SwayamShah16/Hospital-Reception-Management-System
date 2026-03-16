<!DOCTYPE html>
<html>
<head>
<title>Registration</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
	rel="stylesheet">
<style>
body {
	font-family: cursive;
	background: linear-gradient(135deg, #0f2027, #2c5364);
	background-repeat: no-repeat;
	background-size: cover;
	background-position: center;
	min-height: 100vh;
}
</style>
<script>
	function showPopup(event) {
		event.preventDefault(); // stop immediate form submission
		alert("Successful Register!");
		event.target.submit(); // submit form after showing popup
	}
</script>
</head>
<body class="d-flex align-items-center">
	<div class="container">
		<div class="row justify-content-center">
			<div class="col-md-5">
				<div class="card shadow p-4 rounded-4">
					<h3 class="mb-3 text-center">Registration</h3>

					<form action="UserServlet" method="post"
						onsubmit="showPopup(event)">
						<input type="hidden" name="action" value="register">

						<div class="form-floating my-3">
							<input type="text" class="form-control" name="username"
								id="Username" placeholder="" required /> <label for="portId">Username</label>
						</div>

						<div class="form-floating my-3">
							<input type="password" class="form-control" name="password"
								id="password" placeholder="" required /> <label for="password">Password</label>
						</div>

						<div class="form-floating my-3">
							<input type="text" class="form-control" name="role" id="Role"
								placeholder="" required /> <label for="name">Role</label>
						</div>

						<button class="btn btn-primary w-100">Register</button>
					</form>

					<div class="text-center mt-3">
						Already have an account? <a href="login.jsp">Login</a>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>
