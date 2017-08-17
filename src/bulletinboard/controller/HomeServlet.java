package bulletinboard.controller;

import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
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
import bulletinboard.service.UserService;

@WebServlet(urlPatterns = { "/index.jsp"})
public class HomeServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	@Override
	protected void doGet(HttpServletRequest request,HttpServletResponse response)
			throws IOException,
			ServletException {

		HttpSession session = request.getSession();

		List<String> errorMessages = new ArrayList<String>();

		String category = null;
		String startDate = "2017-08-01";

		Date date = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		String endDate = (sdf.format(date)).toString();
		request.setAttribute("date", endDate);

		List<UserMessage> allMessages = new MessageService().getMessage(startDate, endDate, category);
		request.setAttribute("allMessages", allMessages);

		List<UserMessage> categories = new MessageService().getMessageCategory();
		session.setAttribute("categories", categories);
		List<String> categoriesName = new ArrayList<String>();
		for(int i = 0; i < categories.size();i++){
			categoriesName.add(categories.get(i).getCategory());
		}


		if(StringUtils.isBlank(request.getParameter("category")) == false){
			if(categoriesName.contains(request.getParameter("category")) == true){
				category = request.getParameter("category");
				request.setAttribute("selectCategory", category);
			} else {
				errorMessages.add("そのカテゴリーは存在しません");
				startDate = null;
				endDate = null;
				session.setAttribute("errorMessages", errorMessages);
			}
		}


		if(StringUtils.isBlank(request.getParameter("startDate")) == false && StringUtils.isBlank(request.getParameter("endDate")) == false){
			try {
				if(request.getParameter("startDate").matches("\\d{4}-\\d{1,2}-\\d{1,2}") && request.getParameter("endDate").matches("\\d{4}-\\d{1,2}-\\d{1,2}")){
					int diff = sdf.parse(request.getParameter("startDate")).compareTo(sdf.parse(request.getParameter("endDate")));
					if(diff == 1){
						errorMessages.add("開始日は終了日より前の日付を選択してください");
						session.setAttribute("errorMessages", errorMessages);
						request.setAttribute("startDate", startDate);
						request.setAttribute("endDate", endDate);
					}
				}
			} catch (ParseException e) {
			}
		}

		if(StringUtils.isBlank(request.getParameter("startDate")) == false){
			try {
				if(request.getParameter("startDate").matches("\\d{4}-\\d{1,2}-\\d{1,2}")){
					int diff = sdf.parse(request.getParameter("startDate")).compareTo(sdf.parse("2017-08-01"));
					if(diff >= 0){
						startDate = request.getParameter("startDate");
						Date formatDate = sdf.parse(startDate);
						SimpleDateFormat sdf2 = new SimpleDateFormat("yyyy年MM月dd日");
						request.setAttribute("selectStart", (sdf2.format(formatDate)).toString());
						request.setAttribute("startDate", startDate);
					} else {
						errorMessages.add("開始日が不正です");
						session.setAttribute("errorMessages", errorMessages);


					}
				} else {
					errorMessages.add("開始日が不正です");
					session.setAttribute("errorMessages", errorMessages);
				}
			} catch (ParseException e) {
			}
		}


		if(StringUtils.isBlank(request.getParameter("endDate")) == false){
			try {
				if(request.getParameter("endDate").matches("\\d{4}-\\d{1,2}-\\d{1,2}")){
					int diff = sdf.parse(request.getParameter("endDate")).compareTo(sdf.parse(sdf.format(date)));
					if(diff <= 0){
						endDate = request.getParameter("endDate");
						Date formatDate = sdf.parse(endDate);
						SimpleDateFormat sdf2 = new SimpleDateFormat("yyyy年MM月dd日");
						request.setAttribute("selectEnd", (sdf2.format(formatDate)).toString());
						request.setAttribute("endDate", endDate);
					} else {
						errorMessages.add("終了日が不正です");
						session.setAttribute("errorMessages", errorMessages);

					}
				} else {
					errorMessages.add("終了日が不正です");
					session.setAttribute("errorMessages", errorMessages);
				}
			} catch (ParseException e) {
			}
		}

		if(request.getParameter("category") != null && request.getParameter("startDate") != null && request.getParameter("endDate") != null){
			if(request.getParameter("category").equals("") && request.getParameter("startDate").equals("") && request.getParameter("endDate").equals("")){
				errorMessages.add("絞込み条件を選択してください");
				startDate = null;
				endDate = null;
				session.setAttribute("errorMessages", errorMessages);
			}
		}


		List<UserMessage> messages = new MessageService().getMessage(startDate, endDate, category);
		request.setAttribute("messages", messages);

		List<UserComment> comments = new CommentService().getComment();
		request.setAttribute("comments", comments);

		List<User> users = new UserService().getUsers();
		request.setAttribute("users", users);

		User user = (User)session.getAttribute("loginUser");
		request.setAttribute("loginUser", user);

		List<Branch> branches = new BranchService().getBranch();
		session.setAttribute("branches", branches);

		List<Position> positions = new PositionService().getPosition();
		session.setAttribute("positions", positions);

		request.getRequestDispatcher("home.jsp").forward(request, response);

	}

}
