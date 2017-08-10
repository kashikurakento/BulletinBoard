package bulletinboard.controller;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang.StringUtils;

import bulletinboard.beans.Branch;
import bulletinboard.beans.Position;
import bulletinboard.beans.User;
import bulletinboard.beans.UserComment;
import bulletinboard.beans.UserMessage;
import bulletinboard.service.BranchService;
import bulletinboard.service.CommentService;
import bulletinboard.service.MessageService;
import bulletinboard.service.PositionService;

@WebServlet(urlPatterns = { "/index.jsp"})
public class HomeServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	@Override
	protected void doGet(HttpServletRequest request,HttpServletResponse response)
			throws IOException,
			ServletException {

		HttpSession session = request.getSession();

		String category = null;

		Date date = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		String endDate = (sdf.format(date)).toString();
		request.setAttribute("date", endDate);

		String startDate = "2017-07-31";

		List<UserMessage> categories = new MessageService().getMessageCategory();
		session.setAttribute("categories", categories);

		if(StringUtils.isBlank(request.getParameter("startDate")) == false){
			startDate = request.getParameter("startDate");
			request.setAttribute("selectStart", startDate);
		}
		if(StringUtils.isBlank(request.getParameter("endDate")) == false){
			endDate = request.getParameter("endDate");
			request.setAttribute("selectEnd", endDate);
		}
		if(StringUtils.isBlank(request.getParameter("category")) == false){
			category = request.getParameter("category");
			request.setAttribute("selectCategory", category);
			System.out.println(request.getParameter("category"));
		}


		List<UserMessage> messages = new MessageService().getMessage(startDate, endDate, category);
		request.setAttribute("messages", messages);

		List<UserComment> comments = new CommentService().getComment();
		request.setAttribute("comments", comments);

		User user = (User)session.getAttribute("loginUser");
		request.setAttribute("loginUser", user);

		List<Branch> branches = new BranchService().getBranch();
		request.setAttribute("branches", branches);

		List<Position> positions = new PositionService().getPosition();
		request.setAttribute("positions", positions);

		request.getRequestDispatcher("home.jsp").forward(request, response);

	}

}
