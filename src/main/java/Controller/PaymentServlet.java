package Controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.math.BigDecimal;
import java.sql.Date;

import Connection.GetConnection;
import DAO.PaymentDAO;
import POJO.PaymentPOJO;

@WebServlet("/payment")
public class PaymentServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

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
		req.getRequestDispatcher("addPaymentForm.jsp").forward(req, resp);
	}

	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			int appointmentId = Integer.parseInt(req.getParameter("appointmentId"));
			int patientId = Integer.parseInt(req.getParameter("patientId"));
			BigDecimal amount = new BigDecimal(req.getParameter("amount"));
			Date paymentDate = Date.valueOf(req.getParameter("paymentDate"));
			String paymentMode = req.getParameter("paymentMode");

			PaymentPOJO p = new PaymentPOJO();
			p.setAppointmentId(appointmentId);
			p.setPatientId(patientId);
			p.setAmount(amount);
			p.setPaymentDate(paymentDate);
			p.setPaymentMode(paymentMode);

			boolean success = dao.addPayment(p);

			if (success) {
				req.setAttribute("message", "Payment processed successfully!");
			} else {
				req.setAttribute("message", "Payment failed. Please try again.");
			}
		} catch (Exception e) {
			req.setAttribute("message", "Payment failed: " + e.getMessage());
		}

		req.getRequestDispatcher("addPaymentForm.jsp").forward(req, resp);
	}
}
