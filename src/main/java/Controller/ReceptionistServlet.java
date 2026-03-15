package Controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import DAO.ReceptionistDAO;
import POJO.ReceptionistPOJO;

@WebServlet("/receptionist")
public class ReceptionistServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;

	private final ReceptionistDAO receptionistDAO = new ReceptionistDAO();

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String action = request.getParameter("action");
		if (action == null || action.isEmpty()) {
			action = "loginForm";
		}

		switch (action) {
		case "logout":
			handleLogout(request, response);
			break;
		case "registerForm":
			// Show registration form
			request.getRequestDispatcher("/WEB-INF/Receptionist_Registration.jsp").forward(request, response);
			break;
		case "loginForm":
		default:
			// Forward internally to the login JSP under WEB-INF
			request.getRequestDispatcher("/WEB-INF/Receptionist_Login.jsp").forward(request, response);
			break;
		}
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String action = request.getParameter("action");
		if (action == null) {
			action = "login";
		}

		switch (action) {
		case "login":
			handleLogin(request, response);
			break;
		case "register":
			handleRegister(request, response);
			break;
		default:
			response.setContentType("text/html");
			PrintWriter out = response.getWriter();
			out.println("Unsupported action: " + action);
		}
	}

	private void handleLogin(HttpServletRequest request, HttpServletResponse response) throws IOException {

		response.setContentType("text/html");
		PrintWriter out = response.getWriter();

		String receptionistIdParam = request.getParameter("receptionist_id");
		String password = request.getParameter("password");

		if (receptionistIdParam == null || password == null || receptionistIdParam.trim().isEmpty()
				|| password.trim().isEmpty()) {
			// Missing fields, go back to login with generic error
			response.sendRedirect("receptionist?action=loginForm&error=1");
			return;
		}

		int receptionistId;
		try {
			receptionistId = Integer.parseInt(receptionistIdParam);
		} catch (NumberFormatException e) {
			// Invalid ID format, treat as login error
			response.sendRedirect("receptionist?action=loginForm&error=1");
			return;
		}

		ReceptionistPOJO receptionist = receptionistDAO.validateReceptionist(receptionistId, password);
		if (receptionist != null) {
			HttpSession session = request.getSession(true);
			// Store the logged-in receptionist in the session
			session.setAttribute("user", receptionist);
			// Redirect to receptionist home/dashboard page
			response.sendRedirect("home.jsp");
		} else {
			// Redirect back to the login form via servlet with an error flag
			response.sendRedirect("receptionist?action=loginForm&error=1");
		}
	}

	private void handleRegister(HttpServletRequest request, HttpServletResponse response) throws IOException {

		response.setContentType("text/html");
		PrintWriter out = response.getWriter();

		String receptionistIdParam = request.getParameter("receptionist_id");
		String recepName = request.getParameter("recep_name");
		String password = request.getParameter("password");
		String confirmPassword = request.getParameter("confirmPassword");
		String recepContactNoParam = request.getParameter("recep_contact_no");
		String shiftTimingParam = request.getParameter("shift_timing");
		String email = request.getParameter("email");

		if (receptionistIdParam == null || recepName == null || password == null || confirmPassword == null
				|| recepContactNoParam == null || shiftTimingParam == null || email == null
				|| receptionistIdParam.trim().isEmpty() || recepName.trim().isEmpty() || password.trim().isEmpty()
				|| confirmPassword.trim().isEmpty() || recepContactNoParam.trim().isEmpty()
				|| shiftTimingParam.trim().isEmpty() || email.trim().isEmpty()) {

			// Back to registration with a generic error flag
			response.sendRedirect("receptionist?action=registerForm&error=1");
			return;
		}

		if (!password.equals(confirmPassword)) {
			// Use same generic error for now
			response.sendRedirect("receptionist?action=registerForm&error=1");
			return;
		}

		int receptionistId;
		int recepContactNo;
		int shiftTiming;
		try {
			receptionistId = Integer.parseInt(receptionistIdParam);
			recepContactNo = Integer.parseInt(recepContactNoParam);
			shiftTiming = Integer.parseInt(shiftTimingParam);
		} catch (NumberFormatException e) {
			response.sendRedirect("receptionist?action=registerForm&error=1");
			return;
		}

		// Optional: check if receptionist already exists
		if (receptionistDAO.isReceptionistIdTaken(receptionistId)) {
			// Indicate "taken" to the registration JSP
			response.sendRedirect("receptionist?action=registerForm&taken=1");
			return;
		}

		ReceptionistPOJO newReceptionist = new ReceptionistPOJO(receptionistId, recepName, password, recepContactNo,
				shiftTiming, email);

		boolean created = receptionistDAO.createReceptionist(newReceptionist);

		if (created) {
			// Redirect to login with "registered" flag
			response.sendRedirect("receptionist?action=loginForm&registered=1");
		} else {
			response.sendRedirect("receptionist?action=registerForm&error=1");
		}
	}

	private void handleLogout(HttpServletRequest request, HttpServletResponse response) throws IOException {

		HttpSession session1 = request.getSession(false);
		if (session1 != null) {
			session1.invalidate();
		}
		// Go back to login form via servlet
		response.sendRedirect("receptionist?action=loginForm");
	}
}