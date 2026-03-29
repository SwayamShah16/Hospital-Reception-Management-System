package Controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

import DAO.DashboardDAO;

@WebServlet("/dashboard")
public class DashboardServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		HttpSession session = request.getSession(false);

		if (session == null || session.getAttribute("user_id") == null) {
			response.sendRedirect("login.jsp");
			return;
		}

		request.setAttribute("patients", DashboardDAO.getPatientCount());
		request.setAttribute("doctors", DashboardDAO.getDoctorCount());
		request.setAttribute("appointments", DashboardDAO.getAppointmentCount());
		request.setAttribute("revenue", DashboardDAO.getTotalRevenue());
		request.setAttribute("staff", DashboardDAO.getStaffCount());
		request.setAttribute("rooms", DashboardDAO.getRoomCount());
		request.setAttribute("activities", DashboardDAO.getActivities());

		request.getRequestDispatcher("dashboard.jsp").forward(request, response);
	}
}