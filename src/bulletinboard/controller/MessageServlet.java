package bulletinboard.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang.StringUtils;

import bulletinboard.beans.Message;
import bulletinboard.beans.User;
import bulletinboard.service.MessageService;

@WebServlet(urlPatterns = { "/message" })
public class MessageServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	@Override
	protected void doGet(HttpServletRequest request,HttpServletResponse response)
			throws IOException,
	ServletException {
			request.getRequestDispatcher("message.jsp").forward(request, response);
		}

	@Override
	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws IOException, ServletException {

		HttpSession session = request.getSession();

		List<String> messages = new ArrayList<String>();

		User user = (User) session.getAttribute("loginUser");

		Message message = new Message();
		message.setTitle(request.getParameter("title"));
		if(StringUtils.isBlank(request.getParameter("category")) == false){
			message.setCategory(request.getParameter("category"));
		}
		message.setText(request.getParameter("text"));
		message.setBranchId(user.getBranchId());
		message.setPositionId(user.getPositionId());
		message.setUserId(user.getId());
		if (isValid(request, messages) == true) {
			if(StringUtils.isBlank(request.getParameter("selectCategory")) == false){
				message.setCategory(request.getParameter("selectCategory"));
			}
			new MessageService().register(message);
			response.sendRedirect("./");
		} else {

			if(StringUtils.isBlank(request.getParameter("selectCategory")) == false){
				request.setAttribute("selectCategory", request.getParameter("selectCategory"));
			}

			session.setAttribute("errorMessages", messages);
			request.setAttribute("message", message);

			request.getRequestDispatcher("message.jsp").forward(request, response);
		}
	}

	private boolean isValid(HttpServletRequest request, List<String> messages) {

		String title = request.getParameter("title");
		String category = request.getParameter("category");
		String selectCategory = request.getParameter("selectCategory");
		String text = request.getParameter("text");

		if (StringUtils.isBlank(title) == true) {
			messages.add("件名を入力してください");
		}
		if (30 < title.length()) {
			messages.add("件名は30文字以下で入力してください");
		}
		if(StringUtils.isBlank(category) == false && StringUtils.isBlank(selectCategory) == false){
				messages.add("カテゴリーは1つまで入力または選択出来ます");
		} else if(StringUtils.isBlank(category) == false && StringUtils.isBlank(selectCategory) == true) {
			if (10 < category.length()) {
				messages.add("カテゴリーは10文字以下で入力してください");
			}
		}
		if (StringUtils.isBlank(category) == true && StringUtils.isBlank(selectCategory) == true) {
			messages.add("カテゴリーを入力または選択してください");
		}


		if (StringUtils.isBlank(text) == true) {
			messages.add("本文を入力してください");
		}
		if (1000 < text.length()) {
			messages.add("本文は1000文字以下で入力してください");
		}
		if (messages.size() == 0) {
			return true;
		} else {
			return false;
		}
	}

}
