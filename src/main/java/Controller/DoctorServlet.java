package Controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import DAO.DoctorDAO;
import POJO.DoctorPOJO;

@WebServlet("/doctor")
public class DoctorServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	private final DoctorDAO doctorDAO = new DoctorDAO();

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
			response.sendRedirect("doctor?action=list");
			break;
		}
	}

	private void showList(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		List<DoctorPOJO> doctors = doctorDAO.getAllDoctors();
		request.setAttribute("doctors", doctors);
		request.getRequestDispatcher("/WEB-INF/Doctor.jsp").forward(request, response);
	}

	private void showForm(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String mode = request.getParameter("mode");
		if (mode == null || mode.isEmpty()) {
			mode = "create";
		}

		if ("update".equalsIgnoreCase(mode)) {
			String idParam = request.getParameter("doctor_ID");
			if (idParam != null && !idParam.isEmpty()) {
				try {
					int id = Integer.parseInt(idParam);
					DoctorPOJO doctor = doctorDAO.getDoctorById(id);
					if (doctor != null) {
						request.setAttribute("doctor", doctor);
					}
				} catch (NumberFormatException ignored) {
					// fall back to empty form
				}
			}
		}

		request.setAttribute("mode", mode);
		request.getRequestDispatcher("/WEB-INF/Doctor_Form.jsp").forward(request, response);
	}

	private void handleCreateOrUpdate(HttpServletRequest request, HttpServletResponse response, boolean isUpdate)
			throws IOException {
		try {
			int doctorId = Integer.parseInt(request.getParameter("doctor_ID"));
			String name = request.getParameter("doctor_name");
			String specialization = request.getParameter("Specialization");
			int contactNo = Integer.parseInt(request.getParameter("doctor_contact_no"));
			String email = request.getParameter("doctor_email");
			int consultancyFee = Integer.parseInt(request.getParameter("consulatancy_fee"));
			String availabilityStatus = request.getParameter("availability_status");

			DoctorPOJO doctor = new DoctorPOJO(doctorId, name, specialization, contactNo, email, consultancyFee,
					availabilityStatus);

			boolean success;
			if (isUpdate) {
				success = doctorDAO.updateDoctor(doctor);
			} else {
				success = doctorDAO.createDoctor(doctor);
			}

			if (success) {
				response.sendRedirect("doctor?action=list");
			} else {
				response.sendRedirect("doctor?action=form&mode=" + (isUpdate ? "update" : "create") + "&doctor_ID="
						+ doctorId);
			}
		} catch (NumberFormatException e) {
			response.sendRedirect("doctor?action=form&mode=" + (isUpdate ? "update" : "create"));
		}
	}

	private void handleDelete(HttpServletRequest request, HttpServletResponse response) throws IOException {
		String idParam = request.getParameter("doctor_ID");
		if (idParam != null && !idParam.isEmpty()) {
			try {
				int id = Integer.parseInt(idParam);
				doctorDAO.deleteDoctor(id);
			} catch (NumberFormatException ignored) {
				// ignore parse error, just return to list
			}
		}
		response.sendRedirect("doctor?action=list");
	}
}

