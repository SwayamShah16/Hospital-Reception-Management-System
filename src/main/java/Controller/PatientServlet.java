package Controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import DAO.PatientDAO;
import POJO.PatientPOJO;

@WebServlet("/patient")
public class PatientServlet extends HttpServlet {

	private PatientDAO dao = new PatientDAO();

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String action = request.getParameter("action");

		if (action == null)
			action = "list";

		switch (action) {

		case "delete":
			int id = Integer.parseInt(request.getParameter("id"));
			dao.deletePatient(id);
			response.sendRedirect("patient?action=list");
			break;

		default:
			List<PatientPOJO> list = dao.getAllPatients();
			request.setAttribute("patients", list);
			request.getRequestDispatcher("patientList.jsp").forward(request, response);
			break;
		}
	}
}