<!DOCTYPE html>
<html>
<head>
<title>Add Doctor</title>

<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
	rel="stylesheet">
<link href="style.css" rel="stylesheet">

</head>

<body class="bg-light">

	<div class="container mt-5">

		<div class="card shadow">
			<div class="card-header bg-success text-white">
				<h4>Add New Doctor</h4>
			</div>

			<div class="card-body">

				<form action="doctor" method="post">

					<div class="row">
						<div class="col-md-6">
							<label>Name</label> <input name="name" class="form-control"
								required>
						</div>

						<div class="col-md-6">
							<label>Specialization</label> <input name="specialization"
								class="form-control">
						</div>
					</div>

					<div class="row mt-3">
						<div class="col-md-6">
							<label>Contact</label> <input name="contact" class="form-control">
						</div>

						<div class="col-md-6">
							<label>Email</label> <input name="email" class="form-control">
						</div>
					</div>

					<div class="row mt-3">
						<div class="col-md-6">
							<label>Consultation Fee</label> <input name="fee"
								class="form-control">
						</div>

						<div class="col-md-6">
							<label>Status</label> <select name="status" class="form-control">
								<option>Available</option>
								<option>Unavailable</option>
							</select>
						</div>
					</div>

					<div class="mt-4">
						<button class="btn btn-success">Add Doctor</button>
						<a href="doctor?action=list" class="btn btn-secondary">Back</a>
					</div>

				</form>

			</div>
		</div>

	</div>

</body>
</html>