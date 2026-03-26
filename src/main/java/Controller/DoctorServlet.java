package Controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

import DAO.DoctorDAO;
import POJO.DoctorPOJO;

/**
 * Servlet implementation class DoctorServlet
 */
@WebServlet("/doctor")
public class DoctorServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	DoctorDAO dao = new DoctorDAO();

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String action = request.getParameter("action");
		if (action == null)
			action = "list";

		switch (action) {

		case "list":
			request.setAttribute("doctorList", dao.getAllDoctors());
			request.getRequestDispatcher("Doctor.jsp").forward(request, response);
			break;

		case "delete":
			int id = Integer.parseInt(request.getParameter("id"));
			dao.deleteDoctor(id);
			response.sendRedirect("doctor?action=list");
			break;

		case "edit":
			int editId = Integer.parseInt(request.getParameter("id"));
			request.setAttribute("doctor", dao.getDoctorById(editId));
			request.getRequestDispatcher("editDoctor.jsp").forward(request, response);
			break;

		case "search":
			String keyword = request.getParameter("keyword");
			request.setAttribute("doctorList", dao.searchDoctors(keyword));
			request.getRequestDispatcher("Doctor.jsp").forward(request, response);
			break;
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		DoctorPOJO d = new DoctorPOJO();

		d.setName(request.getParameter("name"));
		d.setSpecialization(request.getParameter("specialization"));
		d.setContactNumber(request.getParameter("contact"));
		d.setEmail(request.getParameter("email"));
		d.setConsultationFee(Double.parseDouble(request.getParameter("fee")));
		d.setAvailabilityStatus(request.getParameter("status"));

		String action = request.getParameter("action");

		if ("update".equals(action)) {
			d.setDoctorId(Integer.parseInt(request.getParameter("id")));
			dao.updateDoctor(d);
		} else {
			dao.addDoctor(d);
		}

		response.sendRedirect("doctor?action=list");
	}
}
