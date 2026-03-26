package Controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

import DAO.StaffDAO;
import POJO.StaffPOJO;

@WebServlet("/staff")
public class StaffServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	StaffDAO dao = new StaffDAO();

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
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
		} else {
			dao.addStaff(s);
		}

		response.sendRedirect("staff?action=list");
	}
}
