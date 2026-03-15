package Controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import DAO.EmergencyCaseDAO;
import POJO.EmergencyCasePOJO;

@WebServlet("/emergency")
public class EmergencyCaseServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	private final EmergencyCaseDAO emergencyDAO = new EmergencyCaseDAO();

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		HttpSession session = request.getSession(false);
		if (session == null || session.getAttribute("user") == null) {
			response.sendRedirect("receptionist?action=loginForm");
			return;
		}

		String action = request.getParameter("action");
		if (action == null || action.isEmpty()) {
			action = "list";
		}

		switch (action) {
		case "form":
			showForm(request, response);
			break;
		case "list":
		default:
			showList(request, response);
			break;
		}
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		HttpSession session = request.getSession(false);
		if (session == null || session.getAttribute("user") == null) {
			response.sendRedirect("receptionist?action=loginForm");
			return;
		}

		String action = request.getParameter("action");
		if (action == null) {
			action = "create";
		}

		switch (action) {
		case "create":
			handleCreateOrUpdate(request, response, false);
			break;
		case "update":
			handleCreateOrUpdate(request, response, true);
			break;
		case "delete":
			handleDelete(request, response);
			break;
		default:
			response.sendRedirect("emergency?action=list");
			break;
		}
	}

	private void showList(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		List<EmergencyCasePOJO> list = emergencyDAO.getAllEmergencyCases();
		request.setAttribute("emergencies", list);
		request.getRequestDispatcher("/WEB-INF/Emergency.jsp").forward(request, response);
	}

	private void showForm(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String mode = request.getParameter("mode");
		if (mode == null || mode.isEmpty()) {
			mode = "create";
		}

		if ("update".equalsIgnoreCase(mode)) {
			String idParam = request.getParameter("emergency_Id");
			if (idParam != null && !idParam.isEmpty()) {
				try {
					int id = Integer.parseInt(idParam);
					EmergencyCasePOJO ec = emergencyDAO.getEmergencyCaseById(id);
					if (ec != null) {
						request.setAttribute("emergency", ec);
					}
				} catch (NumberFormatException ignored) {
				}
			}
		}

		request.setAttribute("mode", mode);
		request.getRequestDispatcher("/WEB-INF/Emergency_Form.jsp").forward(request, response);
	}

	private void handleCreateOrUpdate(HttpServletRequest request, HttpServletResponse response, boolean isUpdate)
			throws IOException {
		try {
			int emergencyId = Integer.parseInt(request.getParameter("emergency_Id"));
			int patientId = Integer.parseInt(request.getParameter("patient_Id"));
			String emergencyType = request.getParameter("emergency_type");
			String severity = request.getParameter("severity_level");
			String priority = request.getParameter("priority_level");
			int arrivalTime = Integer.parseInt(request.getParameter("arrival_time"));
			int doctorId = Integer.parseInt(request.getParameter("assigned_doctor_ID"));
			String status = request.getParameter("status");

			EmergencyCasePOJO ec = new EmergencyCasePOJO(emergencyId, patientId, emergencyType, severity, priority,
					arrivalTime, doctorId, status);

			boolean success;
			if (isUpdate) {
				success = emergencyDAO.updateEmergencyCase(ec);
			} else {
				success = emergencyDAO.createEmergencyCase(ec);
			}

			if (success) {
				response.sendRedirect("emergency?action=list");
			} else {
				response.sendRedirect("emergency?action=form&mode=" + (isUpdate ? "update" : "create") + "&emergency_Id="
						+ emergencyId);
			}
		} catch (NumberFormatException e) {
			response.sendRedirect("emergency?action=form&mode=" + (isUpdate ? "update" : "create"));
		}
	}

	private void handleDelete(HttpServletRequest request, HttpServletResponse response) throws IOException {
		String idParam = request.getParameter("emergency_Id");
		if (idParam != null && !idParam.isEmpty()) {
			try {
				int id = Integer.parseInt(idParam);
				emergencyDAO.deleteEmergencyCase(id);
			} catch (NumberFormatException ignored) {
			}
		}
		response.sendRedirect("emergency?action=list");
	}
}

