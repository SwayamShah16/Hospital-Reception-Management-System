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
		case "loginForm":
		default:
			// Normally forward to receptionist login JSP
			response.sendRedirect("receptionist-login.jsp");
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
			out.println("Receptionist ID and password are required.");
			return;
		}

		int receptionistId;
		try {
			receptionistId = Integer.parseInt(receptionistIdParam);
		} catch (NumberFormatException e) {
			out.println("Invalid receptionist ID.");
			return;
		}

		ReceptionistPOJO receptionist = receptionistDAO.validateReceptionist(receptionistId, password);
		if (receptionist != null) {
			HttpSession session = request.getSession(true);
			// Store the logged-in receptionist in the session
			session.setAttribute("user", receptionist);
			// Redirect to receptionist home/dashboard page
			response.sendRedirect("receptionist-home.jsp");
		} else {
			out.println("Invalid receptionist ID or password.");
			// Optionally: response.sendRedirect("receptionist-login.jsp?error=1");
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

			out.println("All fields are required.");
			return;
		}

		if (!password.equals(confirmPassword)) {
			out.println("Passwords do not match.");
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
			out.println("Invalid numeric value in receptionist ID, contact number, or shift timing.");
			return;
		}

		// Optional: check if receptionist already exists
		if (receptionistDAO.isReceptionistIdTaken(receptionistId)) {
			out.println("Receptionist ID is already registered.");
			return;
		}

		ReceptionistPOJO newReceptionist = new ReceptionistPOJO(receptionistId, recepName, password, recepContactNo,
                shiftTiming,
                email
        );

        boolean created = receptionistDAO.createReceptionist(newReceptionist);

        if (created) {
            out.println("Receptionist registration successful. You can now login.");
            // Optionally: response.sendRedirect("receptionist-login.jsp?registered=1");
        } else {
            out.println("Registration failed. Please try again.");
        }
    }

    private void handleLogout(HttpServletRequest request, HttpServletResponse response)
            throws IOException {

        HttpSession session = request.getSession(false);
        if (session != null) {
            session.invalidate();
        }
        response.sendRedirect("receptionist-login.jsp");
    }
}