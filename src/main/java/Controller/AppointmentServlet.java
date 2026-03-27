package Controller;

import DAO.AppointmentDAO;
import POJO.AppointmentPOJO;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.Date;
import java.sql.Time;
import java.time.LocalTime;

@WebServlet("/appointment")
public class AppointmentServlet extends HttpServlet {
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
		doPost(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String action = request.getParameter("action");
		AppointmentDAO dao = new AppointmentDAO();
		try {
			if ("add".equals(action)) {
				AppointmentPOJO a = new AppointmentPOJO();
				a.setPatientId(Integer.parseInt(request.getParameter("patient_id")));
				a.setDoctorId(Integer.parseInt(request.getParameter("doctor_id")));
				a.setReceptionistId(Integer.parseInt(request.getParameter("receptionist_id")));
				a.setAppointmentDate(Date.valueOf(request.getParameter("appointment_date")));
				String timeStr = request.getParameter("appointment_time"); // "HH:mm"
				if (timeStr != null && !timeStr.isEmpty()) {
					LocalTime lt = LocalTime.parse(timeStr); // parses "HH:mm" automatically
					a.setAppointmentTime(Time.valueOf(lt)); // converts to java.sql.Time safely
				} else {
					a.setAppointmentTime(null); // optional: handle empty time
				}
				a.setPriority(request.getParameter("priority"));
				a.setRemarks(request.getParameter("remarks"));
				dao.addAppointment(a);
				response.sendRedirect("ViewAppointment.jsp");
			} else if ("edit".equals(action)) {
				AppointmentPOJO a = new AppointmentPOJO();
				a.setAppointmentId(Integer.parseInt(request.getParameter("appointment_id")));
				a.setPatientId(Integer.parseInt(request.getParameter("patient_id")));
				a.setDoctorId(Integer.parseInt(request.getParameter("doctor_id")));
				a.setReceptionistId(Integer.parseInt(request.getParameter("receptionist_id")));
				a.setAppointmentDate(Date.valueOf(request.getParameter("appointment_date")));
				String timeStr = request.getParameter("appointment_time"); // "HH:mm"
				if (timeStr != null && !timeStr.isEmpty()) {
					LocalTime lt = LocalTime.parse(timeStr); // parses "HH:mm" automatically
					a.setAppointmentTime(Time.valueOf(lt)); // converts to java.sql.Time safely
				} else {
					a.setAppointmentTime(null); // optional: handle empty time
				}
				a.setPriority(request.getParameter("priority"));
				a.setRemarks(request.getParameter("remarks"));
				dao.updateAppointment(a);
				response.sendRedirect("ViewAppointment.jsp");
			} else if ("delete".equals(action)) {
				int id = Integer.parseInt(request.getParameter("id"));
				dao.deleteAppointment(id);
				response.sendRedirect("ViewAppointment.jsp");
			} else if ("search".equals(action)) {
				String keyword = request.getParameter("keyword");
				request.setAttribute("list", dao.getAllAppointments(keyword));
				RequestDispatcher rd = request.getRequestDispatcher("ViewAppointment.jsp");
				rd.forward(request, response);
			} else {
				response.sendRedirect("ViewAppointment.jsp");
			}
		} catch (Exception e) {
			e.printStackTrace();
			response.sendRedirect("error.jsp");
		}
	}
}