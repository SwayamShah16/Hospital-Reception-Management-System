package Controller;

import DAO.UserDAO;
import POJO.UserPOJO;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/UserServlet")
public class UserServlet extends HttpServlet {

	private UserDAO userDAO;

	public void init() {
		userDAO = new UserDAO();
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String action = request.getParameter("action");

		if (action.equals("login")) {
			loginUser(request, response);
		} else if (action.equals("register")) {
			registerUser(request, response);
		}
	}

	// LOGIN METHOD
	private void loginUser(HttpServletRequest request, HttpServletResponse response) throws IOException {

		String username = request.getParameter("username");
		String password = request.getParameter("password");
		String role = request.getParameter("role");

		UserPOJO user = null;
		try {
			user = UserDAO.login(username, password, role);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		if (user != null) {

			HttpSession session = request.getSession();
			session.setAttribute("user", user);

			// Role based redirect
			if (role.equals("ADMIN")) {
				response.sendRedirect("adminDashboard.jsp");
			} else if (role.equals("DOCTOR")) {
				response.sendRedirect("doctorDashboard.jsp");
			} else if (role.equals("STAFF")) {
				response.sendRedirect("staffDashboard.jsp");
			}

		} else {
			response.sendRedirect("login.jsp?error=invalid");
		}
	}

	// REGISTER METHOD
	private void registerUser(HttpServletRequest request, HttpServletResponse response) throws IOException {

		String username = request.getParameter("username");
		String password = request.getParameter("password");
		String role = request.getParameter("role");

		UserPOJO user = new UserPOJO();

		user.setUsername(username);
		user.setPassword(password);
		user.setRole(role);

		boolean status = userDAO.registerUser(user);

		if (status) {
			response.sendRedirect("login.jsp?success=registered");
		} else {
			response.sendRedirect("register.jsp?error=failed");
		}
	}
}
