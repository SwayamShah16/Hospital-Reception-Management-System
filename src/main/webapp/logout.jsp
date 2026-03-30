<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
// Get existing session (do NOT create new one)
HttpSession session1 = request.getSession(false);

// Invalidate session if exists
if (session1 != null) {
	session1.invalidate();
}

// Redirect to login page with message
response.sendRedirect("login.jsp?msg=loggedout");
%>