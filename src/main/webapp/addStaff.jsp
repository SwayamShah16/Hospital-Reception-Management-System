<!DOCTYPE html>
<html>
<head>
<title>Add Staff</title>

<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
	rel="stylesheet">
<link href="style.css" rel="stylesheet">

</head>

<body class="bg-light">

	<div class="container mt-5">

		<div class="card shadow">
			<div class="card-header bg-success text-white">
				<h4>Add New Staff</h4>
			</div>

			<div class="card-body">

				<form action="staff" method="post">

					<div class="row">
						<div class="col-md-6">
							<label>Name</label> <input name="name" class="form-control"
								required>
						</div>

						<div class="col-md-6">
							<label>Role</label> <input name="role" class="form-control">
						</div>
					</div>

					<div class="row mt-3">
						<div class="col-md-6">
							<label>Department ID</label> <input type="number" name="dept"
								class="form-control">
						</div>

						<div class="col-md-6">
							<label>Contact</label> <input name="contact" class="form-control">
						</div>
					</div>

					<div class="row mt-3">
						<div class="col-md-6">
							<label>Email</label> <input name="email" class="form-control">
						</div>

						<div class="col-md-6">
							<label>Shift Timing</label> <input name="shift"
								class="form-control" placeholder="Morning / Evening / Night">
						</div>
					</div>

					<div class="row mt-3">
						<div class="col-md-6">
							<label>Salary</label> <input type="number" step="0.01"
								name="salary" class="form-control">
						</div>

						<div class="col-md-6">
							<label>Status</label> <select name="status" class="form-control">
								<option>Active</option>
								<option>Inactive</option>
							</select>
						</div>
					</div>

					<div class="mt-4">
						<button class="btn btn-success">Add Staff</button>
						<a href="staff?action=list" class="btn btn-secondary">Back</a>
					</div>

				</form>

			</div>
		</div>

	</div>

</body>
</html>