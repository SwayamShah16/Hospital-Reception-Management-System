package Controller;

import java.io.IOException;
import jakarta.servlet.*;
import jakarta.servlet.http.*;

import Service.ChatbotService;

public class ChatbotServlet extends HttpServlet {

	ChatbotService service = new ChatbotService();

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String msg = request.getParameter("message");

		HttpSession session = request.getSession();

		String lastQuery = (String) session.getAttribute("lastQuery");

		String reply;

		if (msg.equalsIgnoreCase("yes") && lastQuery != null) {
			reply = "Please clarify your previous question.";
		} else {
			reply = service.getResponse(msg);
			session.setAttribute("lastQuery", msg);
		}

		response.setContentType("text/plain");
		response.getWriter().write(reply);
	}
}