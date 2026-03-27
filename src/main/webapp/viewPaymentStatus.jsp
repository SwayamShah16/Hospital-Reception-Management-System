<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ page import="java.util.*,POJO.PaymentPOJO,DAO.PaymentDAO"%>
<%
HttpSession session1 = request.getSession(false);

if (session1 == null || session1.getAttribute("user_id") == null) {
	response.sendRedirect("login.jsp");
	return;
}

int userId = (int) session1.getAttribute("user_id");
String username = (String) session1.getAttribute("username");
String role = (String) session1.getAttribute("role");
%>
<!DOCTYPE html>
<html>
<head>
<title>Payment Status</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
	rel="stylesheet">
</head>
<body>
	<div class="container mt-5">
		<div class="card shadow-sm mx-auto" style="max-width: 700px;">
			<div class="card-header bg-info text-white">
				<h5 class="mb-0 text-center">Check Payment Status</h5>
			</div>
			<div class="card-body">
				<!-- Form to enter Appointment ID -->
				<form method="get" action="paymentStatus">
					<div class="mb-3">
						<label class="form-label">Appointment ID</label> <input
							type="number" name="appointmentId" class="form-control"
							placeholder="Enter Appointment ID" required>
					</div>
					<div class="text-center">
						<button type="submit" class="btn btn-primary">Check
							Status</button>
						<button href="addPayment.jsp" class="btn btn-warning ">Back
							to Add Payment</button>
					</div>
				</form>

				<!-- Display Payment Status -->
				<%
				PaymentPOJO payment = (PaymentPOJO) request.getAttribute("payment");
				String message = (String) request.getAttribute("message");

				if (payment != null) {
				%>
				<div class="mt-4">
					<h5 class="text-center mb-3">
						Payment Details for Appointment ID: <strong><%=payment.getAppointmentId()%></strong>
					</h5>
					<table class="table table-bordered">
						<tr>
							<th>Patient ID</th>
							<td><%=payment.getPatientId()%></td>
						</tr>
						<tr>
							<th>Amount</th>
							<td><%=payment.getAmount()%></td>
						</tr>
						<tr>
							<th>Payment Mode</th>
							<td><%=payment.getPaymentMode()%></td>
						</tr>
						<tr>
							<th>Status</th>
							<td><span
								class="<%=payment.getPaymentStatus().equals("Success") ? "text-success" : "text-danger"%>">
									<%=payment.getPaymentStatus()%>
							</span></td>
						</tr>
					</table>
				</div>
				<%
				} else if (message != null) {
				%>
				<div class="alert alert-warning mt-3" role="alert">
					<%=message%>
				</div>
				<%
				}
				%>
			</div>
		</div>
	</div>

	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>