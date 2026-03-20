<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ page
	import="java.util.*, java.text.SimpleDateFormat, POJO.PatientPOJO"%>
<%@ page import="java.util.Date"%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Patient Management System</title>

<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
	rel="stylesheet">
<link
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css"
	rel="stylesheet">

<style>
:root {
	--primary: #3b82f6;
	--success: #10b981;
	--warning: #f59e0b;
	--danger: #ef4444;
}

body {
	background-color: #f8fafc;
	font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
}

.card {
	box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
	border: none;
	border-radius: 12px;
}

.status-badge {
	padding: 0.5rem 1rem;
	border-radius: 25px;
	font-size: 0.8rem;
	font-weight: 600;
}

.status-active {
	background: #d1fae5;
	color: var(--success);
}

.status-recent {
	background: #fef3c7;
	color: var(--warning);
}

.avatar {
	width: 45px;
	height: 45px;
	border-radius: 50%;
	background: linear-gradient(135deg, var(--primary), #60a5fa);
	color: white;
	display: flex;
	align-items: center;
	justify-content: center;
	font-weight: 600;
}

.table th {
	background: #f1f5f9;
	font-weight: 600;
	border: none;
}
</style>
</head>

<body>

	<div class="container-fluid py-4">

		<!-- Header -->
		<div class="card mb-4">
			<div
				class="card-body d-flex justify-content-between align-items-center">
				<div>
					<h2 class="mb-1">
						<i class="fas fa-users me-2 text-primary"></i>Patient Management
					</h2>
					<p class="text-muted mb-0">Manage all registered patients</p>
				</div>

				<a href="addPatient.jsp" class="btn btn-primary btn-lg"> <i
					class="fas fa-plus me-2"></i>Add New Patient
				</a>
			</div>
		</div>

		<!-- Filters -->
		<div class="card mb-4">
			<div class="card-body">

				<form method="GET" action="patient">

					<div class="row g-3 align-items-end">

						<div class="col-md-3">
							<label class="form-label fw-semibold">Search Patient</label>
							<div class="input-group">
								<span class="input-group-text"><i class="fas fa-search"></i></span>
								<input type="text" class="form-control" name="search"
									value="<%=request.getParameter("search") != null ? request.getParameter("search") : ""%>"
									placeholder="Name, ID, Phone...">
							</div>
						</div>

						<div class="col-md-2">
							<label class="form-label fw-semibold">Gender</label> <select
								class="form-select" name="gender">
								<option value="">All</option>
								<option value="Male"
									<%="Male".equals(request.getParameter("gender")) ? "selected" : ""%>>Male</option>
								<option value="Female"
									<%="Female".equals(request.getParameter("gender")) ? "selected" : ""%>>Female</option>
							</select>
						</div>

						<div class="col-md-2">
							<label class="form-label fw-semibold">Blood Group</label> <select
								class="form-select" name="bloodGroup">
								<option value="">All</option>
								<option value="A+">A+</option>
								<option value="B+">B+</option>
								<option value="O+">O+</option>
							</select>
						</div>

						<div class="col-md-2">
							<label class="form-label fw-semibold">From Date</label> <input
								type="date" class="form-control" name="fromDate">
						</div>

						<div class="col-md-3">
							<button type="submit" class="btn btn-primary w-100">
								<i class="fas fa-filter me-2"></i>Filter Patients
							</button>
						</div>

					</div>
				</form>

			</div>
		</div>

		<!-- Table -->
		<div class="card">
			<div class="card-body p-0">
				<div class="table-responsive">

					<table class="table table-hover mb-0">

						<thead class="table-light">
							<tr>
								<th>Patient ID</th>
								<th>Patient Details</th>
								<th>DOB</th>
								<th>Contact</th>
								<th>Address</th>
								<th>Blood Group</th>
								<th>Reg Date</th>
								<th>Actions</th>
							</tr>
						</thead>

						<tbody>

							<%
							List<PatientPOJO> patients = (List<PatientPOJO>) request.getAttribute("patients");

							if (patients != null && !patients.isEmpty()) {

								int count = 0;

								for (PatientPOJO p : patients) {
									count++;

									String fullName = p.getFirst_Name() + " " + p.getLast_Name();

									java.util.Date dob = p.getDob();
									java.util.Date regDate = p.getRegistration_Date();

									SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");

									String dobStr = dob != null ? sdf.format(dob) : "N/A";
									String regStr = regDate != null ? sdf.format(regDate) : "N/A";

									String initials = (p.getFirst_Name() != null ? p.getFirst_Name().substring(0, 1) : "")
									+ (p.getLast_Name() != null ? p.getLast_Name().substring(0, 1) : "");

									long age = dob != null ? calculateAge(dob) : 0;
									String statusClass = count <= 5 ? "status-recent" : "status-active";
							%>

							<tr>
								<td>#<%=p.getPatient_ID()%></td>

								<td>
									<div class="d-flex align-items-center">
										<div class="avatar me-3"><%=initials%></div>
										<div>
											<div class="fw-semibold"><%=fullName%></div>
											<small class="text-muted"><%=age%> years | <%=p.getGender()%></small>
										</div>
									</div>
								</td>

								<td><%=dobStr%></td>

								<td><%=p.getContact_Number()%></td>

								<td><%=p.getAddress()%></td>

								<td><span class="badge bg-info"><%=p.getBlood_Group()%></span></td>

								<td><span class="<%=statusClass%> status-badge"><%=regStr%></span></td>

								<td><a
									href="patient?action=delete&id=<%=p.getPatient_ID()%>"
									class="btn btn-danger btn-sm">Delete</a></td>
							</tr>

							<%
							}
							} else {
							%>

							<tr>
								<td colspan="8" class="text-center">No Patients Found</td>
							</tr>

							<%
							}
							%>

						</tbody>
					</table>

				</div>
			</div>
		</div>

	</div>

	<%!private long calculateAge(Date birthDate) {
		Calendar cal = Calendar.getInstance();
		cal.setTime(birthDate);

		Calendar today = Calendar.getInstance();
		int age = today.get(Calendar.YEAR) - cal.get(Calendar.YEAR);

		if (today.get(Calendar.DAY_OF_YEAR) < cal.get(Calendar.DAY_OF_YEAR)) {
			age--;
		}
		return age;
	}%>

</body>
</html>