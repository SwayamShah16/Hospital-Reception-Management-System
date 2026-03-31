package Controller;

import java.io.IOException;

import DAO.ContactDAO;
import POJO.ContactPOJO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/contact")
public class ContactServlet extends HttpServlet {

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String name = request.getParameter("name");
		String email = request.getParameter("email");
		String phone = request.getParameter("phone");
		String message = request.getParameter("message");

		ContactPOJO contact = new ContactPOJO();
		contact.setName(name);
		contact.setEmail(email);
		contact.setPhone(phone);
		contact.setMessage(message);

		ContactDAO dao = new ContactDAO();
		boolean status = dao.saveMessage(contact);

		if (status) {
			response.sendRedirect("contact.jsp?msg=success");
		} else {
			response.sendRedirect("contact.jsp?msg=error");
		}
	}
}