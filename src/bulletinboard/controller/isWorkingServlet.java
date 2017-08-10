package bulletinboard.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import bulletinboard.beans.User;
import bulletinboard.service.UserService;

@WebServlet(urlPatterns = {"/is_working" })
public class isWorkingServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	@Override
	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {

		UserService userService = new UserService();
		User editUser = userService.getUser(Integer.parseInt(request.getParameter("id")));

		editUser.setIsWorking(Integer.parseInt(request.getParameter("isWorking")));

		new UserService().isWorkingUpdate(editUser);

			response.sendRedirect("manage");
	}

}
