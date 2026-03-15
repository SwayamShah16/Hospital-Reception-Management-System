package Controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import DAO.StaffDAO;
import POJO.StaffPOJO;

@WebServlet("/staff")
public class StaffServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	private final StaffDAO staffDAO = new StaffDAO();

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
			response.sendRedirect("staff?action=list");
			break;
		}
	}

	private void showList(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		List<StaffPOJO> staffList = staffDAO.getAllStaff();
		request.setAttribute("staffList", staffList);
		request.getRequestDispatcher("/WEB-INF/Staff.jsp").forward(request, response);
	}

	private void showForm(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String mode = request.getParameter("mode");
		if (mode == null || mode.isEmpty()) {
			mode = "create";
		}

		if ("update".equalsIgnoreCase(mode)) {
			String idParam = request.getParameter("staff_Id");
			if (idParam != null && !idParam.isEmpty()) {
				try {
					int id = Integer.parseInt(idParam);
					StaffPOJO staff = staffDAO.getStaffById(id);
					if (staff != null) {
						request.setAttribute("staff", staff);
					}
				} catch (NumberFormatException ignored) {
				}
			}
		}

		request.setAttribute("mode", mode);
		request.getRequestDispatcher("/WEB-INF/Staff_Form.jsp").forward(request, response);
	}

	private void handleCreateOrUpdate(HttpServletRequest request, HttpServletResponse response, boolean isUpdate)
			throws IOException {
		try {
			int staffId = Integer.parseInt(request.getParameter("staff_Id"));
			String name = request.getParameter("name");
			String role = request.getParameter("role");
			int departmentId = Integer.parseInt(request.getParameter("department_ID"));
			int contactNo = Integer.parseInt(request.getParameter("contact_no"));
			String email = request.getParameter("email");
			int shiftTiming = Integer.parseInt(request.getParameter("shift_timing"));
			int salary = Integer.parseInt(request.getParameter("salary"));
			String status = request.getParameter("status");

			StaffPOJO staff = new StaffPOJO(staffId, name, role, departmentId, contactNo, email, shiftTiming, salary,
					status);

			boolean success;
			if (isUpdate) {
				success = staffDAO.updateStaff(staff);
			} else {
				success = staffDAO.createStaff(staff);
			}

			if (success) {
				response.sendRedirect("staff?action=list");
			} else {
				response.sendRedirect("staff?action=form&mode=" + (isUpdate ? "update" : "create") + "&staff_Id="
						+ staffId);
			}
		} catch (NumberFormatException e) {
			response.sendRedirect("staff?action=form&mode=" + (isUpdate ? "update" : "create"));
		}
	}

	private void handleDelete(HttpServletRequest request, HttpServletResponse response) throws IOException {
		String idParam = request.getParameter("staff_Id");
		if (idParam != null && !idParam.isEmpty()) {
			try {
				int id = Integer.parseInt(idParam);
				staffDAO.deleteStaff(id);
			} catch (NumberFormatException ignored) {
			}
		}
		response.sendRedirect("staff?action=list");
	}
}

