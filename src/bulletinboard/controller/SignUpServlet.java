package bulletinboard.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang.StringUtils;

import bulletinboard.beans.User;
import bulletinboard.service.UserService;

@WebServlet(urlPatterns = { "/signup" })
public class SignUpServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	@Override
	protected void doGet(HttpServletRequest request,
			HttpServletResponse response) throws IOException, ServletException {

		request.getRequestDispatcher("signup.jsp").forward(request, response);

	}

	@Override
	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws IOException, ServletException {

		List<String> messages = new ArrayList<String>();

		HttpSession session = request.getSession();

		User user = new User();

		UserService userService = new UserService();
		User existingUser = userService.getUser( (String)request.getParameter("loginId"));
		if (existingUser == null ) {
			user.setLoginId(request.getParameter("loginId"));
		} else {
			messages.add("入力したログインIDは既に使用されています");
			session.setAttribute("errorMessages", messages);
		}


		user.setPassword(request.getParameter("password"));
		user.setName(request.getParameter("name"));
		if(StringUtils.isBlank(request.getParameter("branch")) == false){
				user.setBranchId(Integer.parseInt(request.getParameter("branch")));
		}
		if(StringUtils.isBlank(request.getParameter("position")) == false){
				user.setPositionId(Integer.parseInt(request.getParameter("position")));
		}

		if (isValid(request, messages) == true) {

			new UserService().register(user);

			response.sendRedirect("manage");
		} else {
			user.setLoginId(request.getParameter("loginId"));
			session.setAttribute("errorMessages", messages);
			request.setAttribute("user", user);

			request.getRequestDispatcher("signup.jsp").forward(request, response);
		}
	}

	private boolean isValid(HttpServletRequest request, List<String> messages) {
		String loginId = request.getParameter("loginId");
		String password = request.getParameter("password");
		String checkPassword = request.getParameter("checkPassword");
		String branch = request.getParameter("branch");
		String position = request.getParameter("position");
		String name = request.getParameter("name");
		String[] main = {"1", "2"};
		List<String> mainOffice = Arrays.asList(main);
		String[] sub = {"3", "4"};
		List<String> subOffice = Arrays.asList(sub);


		if (StringUtils.isEmpty(name) == true) {
			messages.add("名前を入力してください");
		}
		if(StringUtils.isEmpty(name) == false){
			if (name.length() > 10) {
				messages.add("名前は10文字以下で入力してください");
			}
		}
		if (StringUtils.isEmpty(loginId) == true) {
			messages.add("ログインIDを入力してください");
		}
		if(StringUtils.isEmpty(loginId) == false){
			if(!loginId.matches("^[0-9a-zA-Z]+$") || 6 > loginId.length()  || loginId.length() > 20){
				messages.add("ログインIDは半角英数字6文字以上20文字以下で入力してください");
			}
		}
		if (StringUtils.isBlank(password) == true) {
			messages.add("パスワードを入力してください");
		}
		if(StringUtils.isBlank(password) == false){
			if(!password.matches("^[ -~｡-ﾟ]+$") || 6 > password.length()  || password.length() > 20){
				messages.add("パスワードは記号または半角文字6文字以上20文字以下で入力してください");
			}
		}
		if (StringUtils.isBlank(checkPassword) == true) {
			messages.add("パスワード（再入力）を入力してください");
		}
		if(StringUtils.isBlank(password) == false && StringUtils.isBlank(checkPassword) == false){
			if(password.matches("^[ -~｡-ﾟ]+$") && 6 <= password.length()  && password.length() <= 20){
				if(!password.equals(checkPassword)){
					messages.add("パスワードが一致していません");
				}
			}
		}

		if (StringUtils.isBlank(request.getParameter("branch")) == true) {
				messages.add("支店を選択してください");
		}
		if (StringUtils.isBlank(request.getParameter("position")) == true) {
				messages.add("部署/役職を選択してください");
		}

		if (branch != null && position != null) {
			if(StringUtils.isBlank(request.getParameter("branch")) == false && StringUtils.isBlank(request.getParameter("position")) == false){
				if(Integer.parseInt(request.getParameter("branch")) == 1 && !mainOffice.contains(request.getParameter("position"))){
					messages.add("支店と部署/役職の組み合わせに誤りがあります");
				} else if(Integer.parseInt(request.getParameter("branch")) != 1 && !subOffice.contains(request.getParameter("position"))){
					messages.add("支店と部署/役職の組み合わせに誤りがあります");
				}
			}
		}


		if (messages.size() == 0) {
			return true;
		} else {
			return false;
		}
	}

}
