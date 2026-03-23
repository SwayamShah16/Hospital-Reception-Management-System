package Controller;

import java.io.IOException;
import java.util.List;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import DAO.DoctorDAO;
import POJO.DoctorPOJO;

@WebServlet("/Doctor")
public class DoctorServlet extends HttpServlet {

	DoctorDAO dao = new DoctorDAO();

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String action = request.getParameter("action");

		if (action == null)
			action = "list";

		switch (action) {

		case "delete":
			String idParam = request.getParameter("id");

			if (idParam != null && !idParam.isEmpty()) {
				int id = Integer.parseInt(idParam);
				dao.deleteDoctor(id);
			}
			response.sendRedirect("Doctor");
			break;

		case "filter":
			String spec = request.getParameter("specialization");
			String avail = request.getParameter("availability");

			List<DoctorPOJO> filtered = dao.filterDoctors(spec, avail);
			request.setAttribute("doctorList", filtered);
			request.getRequestDispatcher("Doctor").forward(request, response);
			break;

		default:
			List<DoctorPOJO> list = dao.getAllDoctors();

			System.out.println("Doctor Count: " + list.size()); // DEBUG

			request.setAttribute("doctorList", list);
			request.getRequestDispatcher("Doctor").forward(request, response);
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String action = request.getParameter("action");

		if (action.equals("add")) {

			DoctorPOJO d = new DoctorPOJO();
			d.setName(request.getParameter("name"));
			d.setSpecialization(request.getParameter("specialization"));
			d.setContact_Number(Double.parseDouble(request.getParameter("contact")));
			d.setEmail(request.getParameter("email"));
			d.setConsultation_Fee(Double.parseDouble(request.getParameter("fee")));
			d.setAvailability_Status(request.getParameter("status"));

			dao.addDoctor(d);

		} else if (action.equals("update")) {

			DoctorPOJO d = new DoctorPOJO();
			d.setDoctor_ID(Integer.parseInt(request.getParameter("id")));
			d.setName(request.getParameter("name"));
			d.setSpecialization(request.getParameter("specialization"));
			d.setContact_Number(Double.parseDouble(request.getParameter("contact")));
			d.setEmail(request.getParameter("email"));
			d.setConsultation_Fee(Double.parseDouble(request.getParameter("fee")));
			d.setAvailability_Status(request.getParameter("status"));

			dao.updateDoctor(d);
		}

		response.sendRedirect("Doctor");
	}
}