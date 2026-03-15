package Controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import DAO.AdmissionDAO;
import DAO.RoomDAO;
import POJO.AdmissionPOJO;
import POJO.RoomPOJO;

@WebServlet("/admission")
public class AdmissionServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	private final AdmissionDAO admissionDAO = new AdmissionDAO();
	private final RoomDAO roomDAO = new RoomDAO();

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
			response.sendRedirect("admission?action=list");
			break;
		}
	}

	private void showList(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		List<AdmissionPOJO> admissions = admissionDAO.getAllAdmissions();
		List<RoomPOJO> rooms = roomDAO.getAllRooms();
		request.setAttribute("admissions", admissions);
		request.setAttribute("rooms", rooms);
		request.getRequestDispatcher("/WEB-INF/Admission.jsp").forward(request, response);
	}

	private void showForm(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String mode = request.getParameter("mode");
		if (mode == null || mode.isEmpty()) {
			mode = "create";
		}

		if ("update".equalsIgnoreCase(mode)) {
			String idParam = request.getParameter("admit_ID");
			if (idParam != null && !idParam.isEmpty()) {
				try {
					int id = Integer.parseInt(idParam);
					AdmissionPOJO admission = admissionDAO.getAdmissionById(id);
					if (admission != null) {
						request.setAttribute("admission", admission);
					}
				} catch (NumberFormatException ignored) {
				}
			}
		}

		// rooms to choose from
		List<RoomPOJO> rooms = roomDAO.getAllRooms();
		request.setAttribute("rooms", rooms);
		request.setAttribute("mode", mode);
		request.getRequestDispatcher("/WEB-INF/Admission_Form.jsp").forward(request, response);
	}

	private void handleCreateOrUpdate(HttpServletRequest request, HttpServletResponse response, boolean isUpdate)
			throws IOException {
		try {
			int admitId = Integer.parseInt(request.getParameter("admit_ID"));
			int patientId = Integer.parseInt(request.getParameter("patient_ID"));
			int roomId = Integer.parseInt(request.getParameter("room_ID"));
			int admitDate = Integer.parseInt(request.getParameter("admit_date"));
			int dischargeDate = Integer.parseInt(request.getParameter("discharge_date"));
			int doctorId = Integer.parseInt(request.getParameter("doctor_ID"));
			int totalBill = Integer.parseInt(request.getParameter("total_bill"));

			AdmissionPOJO admission = new AdmissionPOJO(admitId, patientId, roomId, admitDate, dischargeDate,
					doctorId, totalBill);

			boolean success;
			if (isUpdate) {
				success = admissionDAO.updateAdmission(admission);
			} else {
				success = admissionDAO.createAdmission(admission);
			}

			if (success) {
				response.sendRedirect("admission?action=list");
			} else {
				response.sendRedirect("admission?action=form&mode=" + (isUpdate ? "update" : "create") + "&admit_ID="
						+ admitId);
			}
		} catch (NumberFormatException e) {
			response.sendRedirect("admission?action=form&mode=" + (isUpdate ? "update" : "create"));
		}
	}

	private void handleDelete(HttpServletRequest request, HttpServletResponse response) throws IOException {
		String idParam = request.getParameter("admit_ID");
		if (idParam != null && !idParam.isEmpty()) {
			try {
				int id = Integer.parseInt(idParam);
				admissionDAO.deleteAdmission(id);
			} catch (NumberFormatException ignored) {
			}
		}
		response.sendRedirect("admission?action=list");
	}
}

