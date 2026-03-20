<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ page import="java.util.*, POJO.DoctorPOJO"%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Doctor Management System</title>

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

.status-inactive {
	background: #fee2e2;
	color: var(--danger);
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
						<i class="fas fa-user-md me-2 text-primary"></i>Doctor Management
					</h2>
					<p class="text-muted mb-0">Manage all registered doctors</p>
				</div>

				<a href="addDoctor.jsp" class="btn btn-primary btn-lg"> <i
					class="fas fa-plus me-2"></i>Add New Doctor
				</a>
			</div>
		</div>

		<!-- Doctors Table -->
		<div class="card">
			<div class="card-body p-0">
				<div class="table-responsive">

					<table class="table table-hover mb-0">

						<thead class="table-light">
							<tr>
								<th><i class="fas fa-hashtag me-2"></i>Doctor ID</th>
								<th><i class="fas fa-user-md me-2"></i>Doctor Details</th>
								<th><i class="fas fa-stethoscope me-2"></i>Specialization</th>
								<th><i class="fas fa-phone me-2"></i>Contact</th>
								<th><i class="fas fa-envelope me-2"></i>Email</th>
								<th><i class="fas fa-money-bill-wave me-2"></i>Fee</th>
								<th><i class="fas fa-toggle-on me-2"></i>Status</th>
								<th><i class="fas fa-cogs me-2"></i>Actions</th>
							</tr>
						</thead>

						<tbody>

							<%
							List<DoctorPOJO> doctors = (List<DoctorPOJO>) request.getAttribute("doctors");

							if (doctors != null && !doctors.isEmpty()) {

								int count = 0;

								for (DoctorPOJO d : doctors) {
									count++;

									String name = d.getName();

									String initials = "";
									if (name != null && name.length() >= 2) {
								String[] parts = name.split(" ");
								for (String part : parts) {
									initials += part.charAt(0);
								}
									}

									String status = d.getAvailability_Status();
									String statusClass = "Available".equalsIgnoreCase(status) ? "status-active" : "status-inactive";
							%>

							<tr>
								<td><strong>#<%=d.getDoctor_ID()%></strong></td>

								<td>
									<div class="d-flex align-items-center">
										<div class="avatar me-3"><%=initials%></div>
										<div>
											<div class="fw-semibold"><%=name%></div>
											<small class="text-muted"><%=d.getSpecialization()%></small>
										</div>
									</div>
								</td>

								<td><%=d.getSpecialization()%></td>

								<td><a href="tel:<%=d.getContact_Number()%>"
									class="text-decoration-none"> <i class="fas fa-phone me-1"></i><%=d.getContact_Number()%>
								</a></td>

								<td><%=d.getEmail()%></td>

								<td><strong>₹<%=d.getConsultation_Fee()%></strong></td>

								<td><span class="status-badge <%=statusClass%>"> <%=status%>
								</span></td>

								<td>
									<div class="btn-group">

										<a href="editDoctor.jsp?id=<%=d.getDoctor_ID()%>"
											class="btn btn-sm btn-outline-warning"> <i
											class="fas fa-edit"></i>
										</a> <a href="doctor?action=delete&id=<%=d.getDoctor_ID()%>"
											class="btn btn-sm btn-outline-danger"
											onclick="return confirm('Delete this doctor?')"> <i
											class="fas fa-trash"></i>
										</a>

									</div>
								</td>

							</tr>

							<%
							}
							} else {
							%>

							<tr>
								<td colspan="8" class="text-center py-5"><i
									class="fas fa-user-md fa-3x text-muted mb-3"></i>
									<h5 class="text-muted">No doctors found</h5></td>
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

</body>
</html>