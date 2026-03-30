package Controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

import DAO.DashboardDAO;

@WebServlet("/viewActivity")
public class ViewActivityServlet extends HttpServlet {
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		request.setAttribute("activities", DashboardDAO.getAllActivities());
		request.getRequestDispatcher("viewActivity.jsp").forward(request, response);
	}
}
