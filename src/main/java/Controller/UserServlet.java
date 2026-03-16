package Controller;

import DAO.UserDAO;
import POJO.UserPOJO;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/UserServlet")
public class UserServlet extends HttpServlet {

	private UserDAO userDAO;

	public void init() {
		userDAO = new UserDAO();
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String action = request.getParameter("action");

		if ("login".equals(action)) {

			loginUser(request, response);

		} else if ("register".equals(action)) {

			registerUser(request, response);
		}
	}

	// LOGIN METHOD
	private void loginUser(HttpServletRequest request, HttpServletResponse response) throws IOException {

		String username = request.getParameter("username");
		String password = request.getParameter("password");
		String role = request.getParameter("role");

		UserPOJO user = userDAO.login(username, password, role);

		if (user != null) {

			HttpSession session = request.getSession();
			session.setAttribute("user", user);

			String userRole = user.getRole(); // get role from DB

			if ("ADMIN".equalsIgnoreCase(userRole)) {

				response.sendRedirect(request.getContextPath() + "/adminDashboard.jsp");

			} else if ("DOCTOR".equalsIgnoreCase(userRole)) {

				response.sendRedirect(request.getContextPath() + "/doctorDashboard.jsp");

			} else if ("STAFF".equalsIgnoreCase(userRole)) {

				response.sendRedirect(request.getContextPath() + "/staffDashboard.jsp");

			} else {

				response.sendRedirect(request.getContextPath() + "/login.jsp?error=role");
			}

		} else {

			response.sendRedirect(request.getContextPath() + "/login.jsp?error=invalid");
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

			response.sendRedirect(request.getContextPath() + "/login.jsp?success=registered");

		} else {

			response.sendRedirect(request.getContextPath() + "/register.jsp?error=failed");
		}
	}
}