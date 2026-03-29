package Controller;

import java.io.IOException;
import java.sql.*;

import Connection.GetConnection;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/UserServlet")
public class UserServlet extends HttpServlet {

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String action = request.getParameter("action");

		if ("login".equals(action)) {
			loginUser(request, response);
		} else if ("register".equals(action)) {
			registerUser(request, response);
		}
	}

	// 🔐 LOGIN
	private void loginUser(HttpServletRequest request, HttpServletResponse response) throws IOException {

		String username = request.getParameter("username");
		String password = request.getParameter("password");

		try {
			Connection con = GetConnection.getConnection();

			PreparedStatement ps = con.prepareStatement("SELECT * FROM users WHERE username=? AND password=?");

			ps.setString(1, username);
			ps.setString(2, password);

			ResultSet rs = ps.executeQuery();

			if (rs.next()) {

				HttpSession session = request.getSession();

				session.setAttribute("user_id", rs.getInt("user_id"));
				session.setAttribute("username", rs.getString("username"));
				session.setAttribute("role", rs.getString("role"));

				System.out.println("LOGIN SUCCESS"); // 🔥 DEBUG

				response.sendRedirect("dashboard.jsp");

			} else {
				System.out.println("LOGIN FAILED");
				response.sendRedirect("login.jsp?error=1");
			}

		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	// 📝 REGISTER
	private void registerUser(HttpServletRequest request, HttpServletResponse response) throws IOException {

		String username = request.getParameter("username");
		String password = request.getParameter("password");
		String role = request.getParameter("role");

		try {
			Connection con = GetConnection.getConnection();

			// Check if user exists
			PreparedStatement check = con.prepareStatement("SELECT * FROM users WHERE username=?");
			check.setString(1, username);
			ResultSet rs = check.executeQuery();

			if (rs.next()) {
				response.sendRedirect("register.jsp?error=exists");
				return;
			}

			// Insert user
			PreparedStatement ps = con.prepareStatement("INSERT INTO users(username, password, role) VALUES (?, ?, ?)");

			ps.setString(1, username);
			ps.setString(2, password);
			ps.setString(3, role);

			ps.executeUpdate();

			response.sendRedirect("login.jsp?success=1");

		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {

		String action = request.getParameter("action");

		if ("logout".equals(action)) {
			HttpSession session = request.getSession(false);

			if (session != null) {
				session.invalidate();
			}

			response.sendRedirect("login.jsp");
		}
	}
}