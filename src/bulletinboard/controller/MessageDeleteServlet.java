package bulletinboard.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import bulletinboard.service.MessageService;


@WebServlet("/messageDelete")
public class MessageDeleteServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	@Override
	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {

		new MessageService().messageDelete(Integer.parseInt(request.getParameter("messageId")));

			response.sendRedirect("./");
	}

}
