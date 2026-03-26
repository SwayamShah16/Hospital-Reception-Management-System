<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>Add Patient</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
	rel="stylesheet">
</head>

<body class="bg-light">

	<div class="container mt-5">
		<div class="card shadow">
			<div class="card-header bg-primary text-white">
				<h4>Add New Patient</h4>
			</div>

			<div class="card-body">

				<!-- 🔥 IMPORTANT LINE -->
				<form action="patient" method="post">

					<div class="row">
						<div class="col-md-6">
							<label>First Name</label> <input type="text" name="firstName"
								class="form-control" required>
						</div>

						<div class="col-md-6">
							<label>Last Name</label> <input type="text" name="lastName"
								class="form-control" required>
						</div>
					</div>

					<div class="mt-3">
						<label>Gender</label> <select name="gender" class="form-control">
							<option>Male</option>
							<option>Female</option>
							<option>Other</option>
						</select>
					</div>

					<div class="mt-3">
						<label>DOB</label> <input type="date" name="dob"
							class="form-control" required>
					</div>

					<div class="mt-3">
						<label>Contact</label> <input type="text" name="contact"
							class="form-control">
					</div>

					<div class="mt-3">
						<label>Address</label>
						<textarea name="address" class="form-control"></textarea>
					</div>

					<div class="mt-3">
						<label>Email</label> <input type="email" name="email"
							class="form-control">
					</div>

					<div class="mt-3">
						<label>Blood Group</label> <input type="text" name="bloodGroup"
							class="form-control">
					</div>

					<div class="mt-4">
						<button class="btn btn-success">Add Patient</button>

						<!-- Go to list -->
						<a href="patient?action=list" class="btn btn-secondary"> View
							Patients </a>
					</div>

				</form>

			</div>
		</div>
	</div>

</body>
</html>