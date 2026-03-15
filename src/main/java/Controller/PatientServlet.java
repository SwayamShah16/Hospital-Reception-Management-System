package Controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import DAO.PatientDAO;
import POJO.PatientPOJO;

@WebServlet("/patient")
public class PatientServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	private final PatientDAO patientDAO = new PatientDAO();

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
			response.sendRedirect("patient?action=list");
			break;
		}
	}

	private void showList(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		List<PatientPOJO> patients = patientDAO.getAllPatients();
		request.setAttribute("patients", patients);
		request.getRequestDispatcher("/WEB-INF/Patient.jsp").forward(request, response);
	}

	private void showForm(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String mode = request.getParameter("mode");
		if (mode == null || mode.isEmpty()) {
			mode = "create";
		}

		if ("update".equalsIgnoreCase(mode)) {
			String idParam = request.getParameter("patient_ID");
			if (idParam != null && !idParam.isEmpty()) {
				try {
					int id = Integer.parseInt(idParam);
					PatientPOJO patient = patientDAO.getPatientById(id);
					if (patient != null) {
						request.setAttribute("patient", patient);
					}
				} catch (NumberFormatException ignored) {
					// fall back to empty form
				}
			}
		}

		request.setAttribute("mode", mode);
		request.getRequestDispatcher("/WEB-INF/Patient_Form.jsp").forward(request, response);
	}

	private void handleCreateOrUpdate(HttpServletRequest request, HttpServletResponse response, boolean isUpdate)
			throws IOException {
		try {
			int patientId = Integer.parseInt(request.getParameter("patient_ID"));
			String firstName = request.getParameter("patient_first_name");
			String lastName = request.getParameter("patient_last_name");
			String gender = request.getParameter("patient_gender");
			int dob = Integer.parseInt(request.getParameter("patient_DOB"));
			int contactNo = Integer.parseInt(request.getParameter("patient_contact_no"));
			String address = request.getParameter("patient_address");
			String email = request.getParameter("patient_email");
			String bloodGroup = request.getParameter("BloodGroup");
			int registrationDate = Integer.parseInt(request.getParameter("Registration_Date"));

			PatientPOJO patient = new PatientPOJO(patientId, firstName, lastName, gender, dob, contactNo, address,
					email, bloodGroup, registrationDate);

			boolean success;
			if (isUpdate) {
				success = patientDAO.updatePatient(patient);
			} else {
				success = patientDAO.createPatient(patient);
			}

			if (success) {
				response.sendRedirect("patient?action=list");
			} else {
				// On failure, go back to form
				response.sendRedirect("patient?action=form&mode=" + (isUpdate ? "update" : "create") + "&patient_ID="
						+ patientId);
			}
		} catch (NumberFormatException e) {
			response.sendRedirect("patient?action=form&mode=" + (isUpdate ? "update" : "create"));
		}
	}

	private void handleDelete(HttpServletRequest request, HttpServletResponse response) throws IOException {
		String idParam = request.getParameter("patient_ID");
		if (idParam != null && !idParam.isEmpty()) {
			try {
				int id = Integer.parseInt(idParam);
				patientDAO.deletePatient(id);
			} catch (NumberFormatException ignored) {
				// ignore parse error, just return to list
			}
		}
		response.sendRedirect("patient?action=list");
	}
}
