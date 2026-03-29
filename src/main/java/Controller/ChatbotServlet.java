package Controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

import DAO.ChatbotDAO;

@WebServlet("/chatbot")
public class ChatbotServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	// Load page
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		HttpSession session = request.getSession(false);

		if (session == null || session.getAttribute("user_id") == null) {
			response.sendRedirect("login.jsp");
			return;
		}

		request.getRequestDispatcher("Chatbot.jsp").forward(request, response);
	}

	// Handle chat request (AJAX)
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String message = request.getParameter("message");

		if (message == null || message.trim().isEmpty()) {
			response.getWriter().write("Please enter a valid question.");
			return;
		}

		String reply = ChatbotDAO.getResponse(message);

		response.setContentType("text/plain");
		response.getWriter().write(reply);
	}
}