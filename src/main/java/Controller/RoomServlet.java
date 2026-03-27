package Controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

import DAO.RoomDAO;
import POJO.RoomPOJO;

@WebServlet("/room")
public class RoomServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	RoomDAO dao = new RoomDAO();

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
		String action = request.getParameter("action");
		if (action == null)
			action = "list";

		switch (action) {

		case "list":
			request.setAttribute("roomList", dao.getAllRooms());
			request.getRequestDispatcher("Room.jsp").forward(request, response);
			break;

		case "delete":
			int id = Integer.parseInt(request.getParameter("id"));
			dao.deleteRoom(id);
			response.sendRedirect("room?action=list");
			break;

		case "edit":
			int editId = Integer.parseInt(request.getParameter("id"));
			request.setAttribute("room", dao.getRoomById(editId));
			request.getRequestDispatcher("editRoom.jsp").forward(request, response);
			break;

		case "search":
			String keyword = request.getParameter("keyword");
			request.setAttribute("roomList", dao.searchRooms(keyword));
			request.getRequestDispatcher("Room.jsp").forward(request, response);
			break;
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		RoomPOJO r = new RoomPOJO();

		r.setRoomNumber(request.getParameter("roomNumber"));
		r.setRoomType(request.getParameter("roomType"));
		r.setStatus(request.getParameter("status"));
		r.setChargesPerDay(Double.parseDouble(request.getParameter("charges")));

		String action = request.getParameter("action");

		if ("update".equals(action)) {
			r.setRoomId(Integer.parseInt(request.getParameter("id")));
			dao.updateRoom(r);
		} else {
			dao.addRoom(r);
		}

		response.sendRedirect("room?action=list");
	}
}
