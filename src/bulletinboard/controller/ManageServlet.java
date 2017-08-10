package bulletinboard.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import bulletinboard.beans.Branch;
import bulletinboard.beans.Position;
import bulletinboard.beans.User;
import bulletinboard.service.BranchService;
import bulletinboard.service.PositionService;
import bulletinboard.service.UserService;

@WebServlet(urlPatterns = { "/manage" })
public class ManageServlet extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest request,
			HttpServletResponse response) throws IOException, ServletException {
		HttpSession session = request.getSession();
		session.removeAttribute("editUser");

		List<User> users = new UserService().getUsers();
		request.setAttribute("users", users);

		List<Branch> branches = new BranchService().getBranch();
		request.setAttribute("branches", branches);

		List<Position> positions = new PositionService().getPosition();
		request.setAttribute("positions", positions);

		request.getRequestDispatcher("manage.jsp").forward(request, response);
	}

}
