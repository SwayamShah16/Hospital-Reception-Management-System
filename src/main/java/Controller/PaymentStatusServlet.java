package Controller;

import java.io.IOException;

import Connection.GetConnection;
import DAO.PaymentDAO;
import POJO.PaymentPOJO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/paymentStatus")
public class PaymentStatusServlet extends HttpServlet {

	private PaymentDAO dao;

	@Override
	public void init() {
		dao = new PaymentDAO(GetConnection.getConnection());
	}

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		HttpSession session = req.getSession(false);

		if (session == null || session.getAttribute("user_id") == null) {
		    resp.sendRedirect("login.jsp");
		    return;
		}

		// Access session data
		int userId = (int) session.getAttribute("user_id");
		String username = (String) session.getAttribute("username");
		String role = (String) session.getAttribute("role");
		try {
			int appointmentId = Integer.parseInt(req.getParameter("appointmentId"));

			PaymentPOJO payment = dao.getPaymentByAppointmentId(appointmentId);

			if (payment != null) {
				req.setAttribute("payment", payment);
			} else {
				req.setAttribute("message", "No payment found for this appointment.");
			}
		} catch (Exception e) {
			req.setAttribute("message", "Error: " + e.getMessage());
		}

		req.getRequestDispatcher("viewPaymentStatus.jsp").forward(req, resp);
	}
}