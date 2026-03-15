<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"
	import="java.util.List,POJO.PaymentPOJO"%>
<%
	// Session check
	javax.servlet.http.HttpSession session1 = request.getSession(false);
	if (session1 == null || session1.getAttribute("user") == null) {
		response.sendRedirect("receptionist?action=loginForm");
		return;
	}

	List<PaymentPOJO> payments = (List<PaymentPOJO>) request.getAttribute("payments");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Payments</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH"
	crossorigin="anonymous">
</head>
<body class="bg-light">
	<nav class="navbar navbar-expand-lg navbar-dark bg-primary mb-4">
		<div class="container-fluid">
			<span class="navbar-brand">Hospital Reception - Payments</span>
			<div class="d-flex">
				<a href="receptionist?action=logout"
					class="btn btn-outline-light btn-sm">Logout</a>
			</div>
		</div>
	</nav>

	<div class="container">
		<div class="d-flex justify-content-between align-items-center mb-3">
			<h1 class="h3 mb-0">Payments</h1>
			<a href="payment?action=form&mode=create" class="btn btn-success">Record
				New Payment</a>
		</div>

		<div class="card shadow-sm">
			<div class="card-body">
				<%
					if (payments == null || payments.isEmpty()) {
				%>
				<p class="text-muted mb-0">No payments found.</p>
				<%
					} else {
				%>
				<div class="table-responsive">
					<table class="table table-striped table-hover align-middle mb-0">
						<thead class="table-primary">
							<tr>
								<th scope="col">Payment ID</th>
								<th scope="col">Appointment ID</th>
								<th scope="col">Patient ID</th>
								<th scope="col">Amount</th>
								<th scope="col">Date (YYYYMMDD)</th>
								<th scope="col">Mode</th>
								<th scope="col">Status</th>
								<th scope="col">Actions</th>
							</tr>
						</thead>
						<tbody>
							<%
								for (PaymentPOJO p : payments) {
							%>
							<tr>
								<td><%=p.getPayment_ID()%></td>
								<td><%=p.getAppointment_ID()%></td>
								<td><%=p.getPatient_ID()%></td>
								<td>₹
									<%=p.getAmount()%></td>
								<td><%=p.getDate()%></td>
								<td><%=p.getMode()%></td>
								<td><span
									class="<%= "PENDING".equalsIgnoreCase(p.getStatus()) ? "text-warning fw-bold"
								: "PAID".equalsIgnoreCase(p.getStatus()) ? "text-success fw-bold" : "" %>">
										<%=p.getStatus()%>
								</span></td>
								<td class="actions"><form action="payment" method="get"
										class="d-inline">
										<input type="hidden" name="action" value="form" /> <input
											type="hidden" name="mode" value="update" /> <input
											type="hidden" name="payment_ID"
											value="<%=p.getPayment_ID()%>" />
										<button type="submit"
											class="btn btn-sm btn-outline-primary">Edit</button>
									</form>
									<form action="payment" method="post" class="d-inline"
										onsubmit="return confirm('Are you sure you want to delete this payment?');">
										<input type="hidden" name="action" value="delete" /> <input
											type="hidden" name="payment_ID"
											value="<%=p.getPayment_ID()%>" />
										<button type="submit"
											class="btn btn-sm btn-outline-danger">Delete</button>
									</form></td>
							</tr>
							<%
								}
							%>
						</tbody>
					</table>
				</div>
				<%
					}
				%>
			</div>
		</div>
	</div>

	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
		crossorigin="anonymous"></script>
</body>
</html>

