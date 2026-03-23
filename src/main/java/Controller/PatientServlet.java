package Controller;

import java.io.IOException;
import java.util.List;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import DAO.PatientDAO;
import POJO.PatientPOJO;

@WebServlet("/Patient")
public class PatientServlet extends HttpServlet {

	private PatientDAO daopatient = new PatientDAO();


	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {

			List<PatientPOJO> patients;
			patients = daopatient.getAllPatients();
			System.out.println("Patients fetched: " + patients.size());
			req.setAttribute("patients", patients);
			req.getRequestDispatcher("Patient.jsp").forward(req, resp);

		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
