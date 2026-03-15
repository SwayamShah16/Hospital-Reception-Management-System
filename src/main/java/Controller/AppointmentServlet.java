package Controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import DAO.AppointmentDAO;
import POJO.AppointmentPOJO;

@WebServlet("/appointment")
public class AppointmentServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	private final AppointmentDAO appointmentDAO = new AppointmentDAO();

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
			response.sendRedirect("appointment?action=list");
			break;
		}
	}

	private void showList(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		List<AppointmentPOJO> appts = appointmentDAO.getAllAppointments();
		request.setAttribute("appointments", appts);
		request.getRequestDispatcher("/WEB-INF/Appointment.jsp").forward(request, response);
	}

	private void showForm(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String mode = request.getParameter("mode");
		if (mode == null || mode.isEmpty()) {
			mode = "create";
		}

		if ("update".equalsIgnoreCase(mode)) {
			String idParam = request.getParameter("appointment_ID");
			if (idParam != null && !idParam.isEmpty()) {
				try {
					int id = Integer.parseInt(idParam);
					AppointmentPOJO appt = appointmentDAO.getAppointmentById(id);
					if (appt != null) {
						request.setAttribute("appointment", appt);
					}
				} catch (NumberFormatException ignored) {
				}
			}
		}

		request.setAttribute("mode", mode);
		request.getRequestDispatcher("/WEB-INF/Appointment_Form.jsp").forward(request, response);
	}

	private void handleCreateOrUpdate(HttpServletRequest request, HttpServletResponse response, boolean isUpdate)
			throws IOException {
		try {
			int appointmentId = Integer.parseInt(request.getParameter("appointment_ID"));
			int patientId = Integer.parseInt(request.getParameter("patient_ID"));
			int doctorId = Integer.parseInt(request.getParameter("doctor_ID"));
			int receptionistId = Integer.parseInt(request.getParameter("receptionist_ID"));
			int date = Integer.parseInt(request.getParameter("appointment_date"));
			int time = Integer.parseInt(request.getParameter("appointment_time"));
			String status = request.getParameter("status");
			String remarks = request.getParameter("Remarks");

			AppointmentPOJO appt = new AppointmentPOJO(appointmentId, patientId, doctorId, receptionistId, date, time,
					status, remarks);

			boolean success;
			if (isUpdate) {
				success = appointmentDAO.updateAppointment(appt);
			} else {
				success = appointmentDAO.createAppointment(appt);
			}

			if (success) {
				response.sendRedirect("appointment?action=list");
			} else {
				response.sendRedirect("appointment?action=form&mode=" + (isUpdate ? "update" : "create")
						+ "&appointment_ID=" + appointmentId);
			}
		} catch (NumberFormatException e) {
			response.sendRedirect("appointment?action=form&mode=" + (isUpdate ? "update" : "create"));
		}
	}

	private void handleDelete(HttpServletRequest request, HttpServletResponse response) throws IOException {
		String idParam = request.getParameter("appointment_ID");
		if (idParam != null && !idParam.isEmpty()) {
			try {
				int id = Integer.parseInt(idParam);
				appointmentDAO.deleteAppointment(id);
			} catch (NumberFormatException ignored) {
			}
		}
		response.sendRedirect("appointment?action=list");
	}
}

