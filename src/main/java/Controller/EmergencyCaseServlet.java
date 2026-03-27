package Controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.Timestamp;

import DAO.EmergencyCaseDAO;
import POJO.EmergencyCasePOJO;

@WebServlet("/emergency")
public class EmergencyCaseServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		HttpSession session = request.getSession(false);

		if (session == null || session.getAttribute("user_id") == null) {
			response.sendRedirect("login.jsp");
			return;
		}

		// Access session data
		int userId = (int) session.getAttribute("user_id");
		String username = (String) session.getAttribute("username");
		String role = (String) session.getAttribute("role");
		String action = request.getParameter("action");
		response.getWriter().append("Served at: ").append(request.getContextPath());
		request.getRequestDispatcher("ViewEmergencyCase.jsp").forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String action = request.getParameter("action");

		if ("insert".equals(action)) {

			EmergencyCasePOJO e = new EmergencyCasePOJO();

			e.setPatientId(Integer.parseInt(request.getParameter("patient_id")));
			e.setEmergencyType(request.getParameter("type"));
			e.setSeverityLevel(request.getParameter("severity"));

			// AUTO PRIORITY
			String severity = request.getParameter("severity");
			String priority = "Low";
			if (severity.equals("Critical"))
				priority = "High";
			else if (severity.equals("Serious"))
				priority = "Medium";

			e.setPriorityLevel(priority);

			e.setArrivalTime(new Timestamp(System.currentTimeMillis()));

			e.setDoctorId(Integer.parseInt(request.getParameter("doctor_id")));
			e.setStatus(request.getParameter("status"));

			EmergencyCaseDAO.insertEmergency(e);
		}

		if ("update".equals(action)) {

			EmergencyCasePOJO e = new EmergencyCasePOJO();

			e.setEmergencyId(Integer.parseInt(request.getParameter("id")));
			e.setPatientId(Integer.parseInt(request.getParameter("patient_id")));
			e.setEmergencyType(request.getParameter("type"));
			e.setSeverityLevel(request.getParameter("severity"));
			e.setPriorityLevel(request.getParameter("priority"));
			e.setDoctorId(Integer.parseInt(request.getParameter("doctor_id")));
			e.setStatus(request.getParameter("status"));

			EmergencyCaseDAO.updateEmergency(e);
		}

		if ("delete".equals(action)) {
			int id = Integer.parseInt(request.getParameter("id"));
			EmergencyCaseDAO.deleteEmergency(id);
		}

		response.sendRedirect("ViewEmergencyCase.jsp");
	}
}
