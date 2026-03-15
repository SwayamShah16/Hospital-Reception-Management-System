package Controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Date;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import DAO.MedicineInventoryDAO;
import POJO.MedicineInventoryPOJO;

@WebServlet("/medicine")
public class MedicineInventoryServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	private final MedicineInventoryDAO medicineDAO = new MedicineInventoryDAO();

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
		case "list":
		default:
			handleList(request, response);
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
			handleList(request, response);
			break;
		}
	}

	private void handleList(HttpServletRequest request, HttpServletResponse response)
			throws IOException, ServletException {
		List<MedicineInventoryPOJO> list = medicineDAO.getAllMedicines();
		request.setAttribute("medicines", list);
		request.getRequestDispatcher("/WEB-INF/Medicine.jsp").forward(request, response);
	}

	private void handleCreateOrUpdate(HttpServletRequest request, HttpServletResponse response, boolean isUpdate)
			throws IOException {
		response.setContentType("text/plain");
		PrintWriter out = response.getWriter();

		try {
			int medicineId = Integer.parseInt(request.getParameter("medicine_id"));
			String name = request.getParameter("name");
			String genericName = request.getParameter("generic_name");
			String category = request.getParameter("category");
			String manufacturer = request.getParameter("manufacturer");
			String batchNo = request.getParameter("batch_no");
			String expiryDateStr = request.getParameter("expiry_date"); // expected yyyy-mm-dd
			int quantity = Integer.parseInt(request.getParameter("quantity_in_stock"));
			int reorderLevel = Integer.parseInt(request.getParameter("reorder_level"));
			double unitPrice = Double.parseDouble(request.getParameter("unit_price"));

			if (name == null || name.trim().isEmpty()) {
				out.println("Name is required.");
				return;
			}

			Date expiryDate = null;
			if (expiryDateStr != null && !expiryDateStr.isEmpty()) {
				expiryDate = Date.valueOf(expiryDateStr);
			}

			MedicineInventoryPOJO med = new MedicineInventoryPOJO(medicineId, name, genericName, category,
					manufacturer, batchNo, expiryDate, quantity, reorderLevel, unitPrice);

			boolean success;
			if (isUpdate) {
				success = medicineDAO.updateMedicine(med);
				out.println(success ? "Medicine updated successfully." : "Failed to update medicine.");
			} else {
				success = medicineDAO.createMedicine(med);
				out.println(success ? "Medicine created successfully." : "Failed to create medicine.");
			}
		} catch (NumberFormatException e) {
			out.println("Invalid numeric value in request parameters.");
		} catch (IllegalArgumentException e) {
			out.println("Invalid expiry_date format. Expected yyyy-mm-dd.");
		}
	}

	private void handleDelete(HttpServletRequest request, HttpServletResponse response) throws IOException {
		String idParam = request.getParameter("medicine_id");
		if (idParam == null) {
			// no id, just go back to list
			response.sendRedirect("medicine?action=list");
			return;
		}
		try {
			int id = Integer.parseInt(idParam);
			boolean success = medicineDAO.deleteMedicine(id);
			// ignore success/failure message for now, just go back to list
			response.sendRedirect("medicine?action=list");
		} catch (NumberFormatException e) {
			response.sendRedirect("medicine?action=list");
		}
	}
}

