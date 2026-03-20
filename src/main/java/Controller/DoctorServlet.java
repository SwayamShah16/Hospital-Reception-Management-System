package Controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import DAO.DoctorDAO;
import POJO.DoctorPOJO;

@WebServlet("/doctor")
public class DoctorServlet extends HttpServlet {

	private DoctorDAO dao = new DoctorDAO();

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String action = request.getParameter("action");

		if (action == null)
			action = "list";

		switch (action) {

		case "delete":
			int id = Integer.parseInt(request.getParameter("id"));
			dao.deleteDoctor(id);
			response.sendRedirect("doctor?action=list");
			break;

		default:
			List<DoctorPOJO> list = dao.getAllDoctors();
			request.setAttribute("doctors", list);
			request.getRequestDispatcher("Doctor.jsp").forward(request, response);
			break;
		}
	}
}