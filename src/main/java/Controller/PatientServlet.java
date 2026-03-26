package Controller;

import DAO.PatientDAO;
import POJO.PatientPOJO;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.IOException;
import java.sql.Date;
import java.util.List;

@WebServlet("/patient")
public class PatientServlet extends HttpServlet {

	PatientDAO dao = new PatientDAO();

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String action = request.getParameter("action");

		if (action == null)
			action = "list";

		switch (action) {

		case "list":
			List<PatientPOJO> list = dao.getAllPatients();
			request.setAttribute("patientList", list);
			request.getRequestDispatcher("Patient.jsp").forward(request, response);
			break;

		case "delete":
			int id = Integer.parseInt(request.getParameter("id"));
			dao.deletePatient(id);
			response.sendRedirect("patient?action=list");
			break;

		case "edit":
			int editId = Integer.parseInt(request.getParameter("id"));
			PatientPOJO p = dao.getPatientById(editId);
			request.setAttribute("patient", p);
			request.getRequestDispatcher("editPatient.jsp").forward(request, response);
			break;

		case "search":

			String keyword = request.getParameter("keyword");

			if (keyword == null || keyword.trim().isEmpty()) {
				response.sendRedirect("patient?action=list");
				return;
			}
			List<PatientPOJO> searchList = dao.searchPatients(keyword);
			request.setAttribute("patientList", searchList);
			request.getRequestDispatcher("Patient.jsp").forward(request, response);
			break;
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String action = request.getParameter("action");

		String dobStr = request.getParameter("dob");
		Date dob = null;

		if (dobStr != null && !dobStr.isEmpty()) {
			dob = Date.valueOf(dobStr);
		}

		PatientPOJO p = new PatientPOJO();

		p.setFirstName(request.getParameter("firstName"));
		p.setLastName(request.getParameter("lastName"));
		p.setGender(request.getParameter("gender"));
		p.setDob(dob);
		p.setContactNumber(request.getParameter("contact"));
		p.setAddress(request.getParameter("address"));
		p.setEmail(request.getParameter("email"));
		p.setBloodGroup(request.getParameter("bloodGroup"));

		if ("update".equals(action)) {

			p.setPatientId(Integer.parseInt(request.getParameter("id")));
			dao.updatePatient(p);

		} else {

			p.setRegistrationDate(new Date(System.currentTimeMillis()));
			dao.addPatient(p);
		}

		response.sendRedirect("patient?action=list");
	}
}