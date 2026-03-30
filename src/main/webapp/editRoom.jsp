<%@ page import="POJO.RoomPOJO"%>

<%
RoomPOJO r = (RoomPOJO) request.getAttribute("room");
%>
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
if (!("Admin".equals(role))) {
	response.sendRedirect("unauthorized.jsp");
	return;
}
%>
<!DOCTYPE html>
<html>
<head>
<title>Edit Room</title>

<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
	rel="stylesheet">
<link href="style.css" rel="stylesheet">

</head>

<body class="bg-light">

	<div class="container mt-5">
		<div class="card shadow">

			<div class="card-header bg-warning">
				<h4>Edit Room</h4>
			</div>

			<div class="card-body">

				<form action="room" method="post">

					<input type="hidden" name="action" value="update"> <input
						type="hidden" name="id" value="<%=r.getRoomId()%>"> <label>Room
						Number</label> <input type="text" name="roomNumber"
						value="<%=r.getRoomNumber()%>" class="form-control"> <label
						class="mt-2">Room Type</label> <input type="text" name="roomType"
						value="<%=r.getRoomType()%>" class="form-control"> <label
						class="mt-2">Status</label> <select name="status"
						class="form-control">

						<option <%=r.getStatus().equals("Available") ? "selected" : ""%>>
							Available</option>

						<option <%=r.getStatus().equals("Occupied") ? "selected" : ""%>>
							Occupied</option>

					</select> <label class="mt-2">Charges Per Day</label> <input type="text"
						name="charges" value="<%=r.getChargesPerDay()%>"
						class="form-control">

					<div class="mt-3">
						<button class="btn btn-success">Update</button>
						<a href="room?action=list" class="btn btn-secondary">Back</a>
					</div>

				</form>

			</div>
		</div>
	</div>

</body>
</html>