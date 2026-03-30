package Controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

import DAO.DashboardDAO;
import DAO.StaffDAO;
import POJO.StaffPOJO;

@WebServlet("/staff")
public class StaffServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	StaffDAO dao = new StaffDAO();

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

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
		if (action == null)
			action = "list";

		switch (action) {

		case "list":
			request.setAttribute("staffList", dao.getAllStaff());
			request.getRequestDispatcher("Staff.jsp").forward(request, response);
			break;

		case "delete":
			dao.deleteStaff(Integer.parseInt(request.getParameter("id")));
			response.sendRedirect("staff?action=list");
			break;

		case "edit":
			request.setAttribute("staff", dao.getStaffById(Integer.parseInt(request.getParameter("id"))));
			request.getRequestDispatcher("editStaff.jsp").forward(request, response);
			break;

		case "search":
			request.setAttribute("staffList", dao.searchStaff(request.getParameter("keyword")));
			request.getRequestDispatcher("Staff.jsp").forward(request, response);
			break;
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		StaffPOJO s = new StaffPOJO();

		s.setName(request.getParameter("name"));
		s.setRole(request.getParameter("role"));
		s.setDepartmentId(Integer.parseInt(request.getParameter("dept")));
		s.setContactNumber(request.getParameter("contact"));
		s.setEmail(request.getParameter("email"));
		s.setShiftTiming(request.getParameter("shift"));
		s.setSalary(Double.parseDouble(request.getParameter("salary")));
		s.setStatus(request.getParameter("status"));

		String action = request.getParameter("action");

		if ("update".equals(action)) {
			s.setStaffId(Integer.parseInt(request.getParameter("id")));
			dao.updateStaff(s);
			DashboardDAO.addActivity("Staff Details Updated");
		} else {
			dao.addStaff(s);
			DashboardDAO.addActivity("Staff Added");
		}

		response.sendRedirect("staff?action=list");
	}
}
