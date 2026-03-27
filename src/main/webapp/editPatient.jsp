<%@ page
	import="POJO.PatientPOJO,DAO.PatientDAO,java.text.SimpleDateFormat"%>
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
<%
int id = Integer.parseInt(request.getParameter("id"));
PatientDAO dao = new PatientDAO();
PatientPOJO p = dao.getPatientById(id);
%>

<!DOCTYPE html>
<html>
<head>
<title>Edit Patient</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
	rel="stylesheet">
</head>

<body class="bg-light">

	<div class="container mt-5">
		<div class="card shadow">
			<div class="card-header bg-warning">
				<h4>Edit Patient</h4>
			</div>

			<div class="card-body">

				<!-- 🔥 FIXED ACTION -->
				<form action="patient?action=update" method="post">

					<input type="hidden" name="id" value="<%=p.getPatientId()%>">

					<label>First Name</label> <input type="text" name="firstName"
						value="<%=p.getFirstName()%>" class="form-control"> <label
						class="mt-2">Last Name</label> <input type="text" name="lastName"
						value="<%=p.getLastName()%>" class="form-control"> <label
						class="mt-2">Gender</label> <input type="text" name="gender"
						value="<%=p.getGender()%>" class="form-control"> <label
						class="mt-2">DOB</label> <input type="date" name="dob"
						class="form-control"
						value="<%=new java.text.SimpleDateFormat("yyyy-MM-dd").format(p.getDob())%>">

					<label class="mt-2">Contact</label> <input type="text"
						name="contact" value="<%=p.getContactNumber()%>"
						class="form-control"> <label class="mt-2">Address</label>
					<textarea name="address" class="form-control"><%=p.getAddress()%></textarea>

					<!-- ✅ NEW FIELD -->
					<label class="mt-2">Email</label> <input type="email" name="email"
						value="<%=p.getEmail()%>" class="form-control">

					<!-- ✅ NEW FIELD -->
					<label class="mt-2">Blood Group</label> <input type="text"
						name="bloodGroup" value="<%=p.getBloodGroup()%>"
						class="form-control">

					<div class="mt-3">
						<button class="btn btn-success">Update</button>
						<a href="patient?action=list" class="btn btn-secondary">Back</a>
					</div>

				</form>

			</div>
		</div>
	</div>

</body>
</html>