package Controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import DAO.DoctorDAO;
import POJO.DoctorPOJO;

@WebServlet("/Doctor")
public class DoctorServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;
	DoctorDAO daodoc = new DoctorDAO();

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		List<DoctorPOJO> list = daodoc.getAllDoctors();
		request.setAttribute("doctorList", list);
		request.getRequestDispatcher("Doctor.jsp").forward(request, response);

	}

}