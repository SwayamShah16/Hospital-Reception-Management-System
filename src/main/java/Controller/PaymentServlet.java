package Controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import DAO.PaymentDAO;
import POJO.PaymentPOJO;

@WebServlet("/payment")
public class PaymentServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	private final PaymentDAO paymentDAO = new PaymentDAO();

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		HttpSession session = request.getSession(false);
		if (session == null || session.getAttribute("user") == null) {
			response.sendRedirect("receptionist?action=loginForm");
			return;
		}

		String action = request.getParameter("action");
		if (action == null || action.isEmpty()) {
			action = "list";
		}

		switch (action) {
		case "form":
			showForm(request, response);
			break;
		case "list":
		default:
			showList(request, response);
			break;
		}
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		HttpSession session = request.getSession(false);
		if (session == null || session.getAttribute("user") == null) {
			response.sendRedirect("receptionist?action=loginForm");
			return;
		}

		String action = request.getParameter("action");
		if (action == null) {
			action = "create";
		}

		switch (action) {
		case "create":
			handleCreateOrUpdate(request, response, false);
			break;
		case "update":
			handleCreateOrUpdate(request, response, true);
			break;
		case "delete":
			handleDelete(request, response);
			break;
		default:
			response.sendRedirect("payment?action=list");
			break;
		}
	}

	private void showList(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		List<PaymentPOJO> payments = paymentDAO.getAllPayments();
		request.setAttribute("payments", payments);
		request.getRequestDispatcher("/WEB-INF/Payment.jsp").forward(request, response);
	}

	private void showForm(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String mode = request.getParameter("mode");
		if (mode == null || mode.isEmpty()) {
			mode = "create";
		}

		if ("update".equalsIgnoreCase(mode)) {
			String idParam = request.getParameter("payment_ID");
			if (idParam != null && !idParam.isEmpty()) {
				try {
					int id = Integer.parseInt(idParam);
					PaymentPOJO payment = paymentDAO.getPaymentById(id);
					if (payment != null) {
						request.setAttribute("payment", payment);
					}
				} catch (NumberFormatException ignored) {
				}
			}
		}

		request.setAttribute("mode", mode);
		request.getRequestDispatcher("/WEB-INF/Payment_Form.jsp").forward(request, response);
	}

	private void handleCreateOrUpdate(HttpServletRequest request, HttpServletResponse response, boolean isUpdate)
			throws IOException {
		try {
			int paymentId = Integer.parseInt(request.getParameter("payment_ID"));
			int appointmentId = Integer.parseInt(request.getParameter("appointment_ID"));
			int patientId = Integer.parseInt(request.getParameter("patient_ID"));
			int amount = Integer.parseInt(request.getParameter("amount"));
			int date = Integer.parseInt(request.getParameter("date"));
			String mode = request.getParameter("mode");
			String status = request.getParameter("status");

			PaymentPOJO payment = new PaymentPOJO(paymentId, appointmentId, patientId, amount, date, mode, status);

			boolean success;
			if (isUpdate) {
				success = paymentDAO.updatePayment(payment);
			} else {
				success = paymentDAO.createPayment(payment);
			}

			if (success) {
				response.sendRedirect("payment?action=list");
			} else {
				response.sendRedirect("payment?action=form&mode=" + (isUpdate ? "update" : "create") + "&payment_ID="
						+ paymentId);
			}
		} catch (NumberFormatException e) {
			response.sendRedirect("payment?action=form&mode=" + (isUpdate ? "update" : "create"));
		}
	}

	private void handleDelete(HttpServletRequest request, HttpServletResponse response) throws IOException {
		String idParam = request.getParameter("payment_ID");
		if (idParam != null && !idParam.isEmpty()) {
			try {
				int id = Integer.parseInt(idParam);
				paymentDAO.deletePayment(id);
			} catch (NumberFormatException ignored) {
			}
		}
		response.sendRedirect("payment?action=list");
	}
}

