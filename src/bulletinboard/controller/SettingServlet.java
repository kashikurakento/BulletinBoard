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
import bulletinboard.exception.NoRowsUpdatedRuntimeException;
import bulletinboard.service.UserService;

@WebServlet(urlPatterns = { "/setting" })
public class SettingServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	@Override
	protected void doGet(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {

		HttpSession session = request.getSession();
		UserService userService = new UserService();
		List<String> messages = new ArrayList<String>();

		if(request.getParameter("id") == null){
			messages.add("URLが不正です");
			session.setAttribute("errorMessages", messages);
			response.sendRedirect("manage");
			return;
		}
		if(!request.getParameter("id").matches("^[0-9]+$")){
			messages.add("そのIDのユーザーは存在していません");
			session.setAttribute("errorMessages", messages);
			response.sendRedirect("manage");
			return;
		}
		if(0 <= request.getParameter("id").length() && request.getParameter("id").length() <= 9){
			if(userService.getUser(Integer.parseInt(request.getParameter("id"))) == null){
				messages.add("そのIDのユーザーは存在していません");
				session.setAttribute("errorMessages", messages);
				response.sendRedirect("manage");
				return;
			}
		} else {
			messages.add("そのIDのユーザーは存在していません");
			session.setAttribute("errorMessages", messages);
			response.sendRedirect("manage");
			return;
		}


		if(request.getParameter("id") != null){
			User editUser = userService.getUser(Integer.parseInt(request.getParameter("id")));
			request.setAttribute("editUser", editUser);
			int branchId = editUser.getBranchId();
			session.setAttribute("branchId", branchId);
			int positionId = editUser.getPositionId();
			session.setAttribute("positionId", positionId);
		}


		request.getRequestDispatcher("setting.jsp").forward(request, response);

	}

	@Override
	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {

		List<String> messages = new ArrayList<String>();

		HttpSession session = request.getSession();

		User editUser = getEditUser(request);
		request.setAttribute("editUser", editUser);

		if (isValid(request, messages,editUser.getId()) == true) {
			try {
				new UserService().update(editUser);
			} catch (NoRowsUpdatedRuntimeException e) {
				messages.add("他の人によって更新されています。最新のデータを表示しました。データを確認してください。");
				session.setAttribute("errorMessages", messages);
				response.sendRedirect("setting");
			}
//			session.removeAttribute("editUser");
			response.sendRedirect("manage");
		} else {
			session.setAttribute("errorMessages", messages);
			request.getRequestDispatcher("setting.jsp").forward(request, response);
		}
	}

	private User getEditUser(HttpServletRequest request)
			throws IOException, ServletException {


		UserService userService = new UserService();

		User editUser = userService.getUser(Integer.parseInt(request.getParameter("id")));

		if (StringUtils.isBlank(request.getParameter("loginId")) == false) {
			editUser.setLoginId(request.getParameter("loginId"));
		}

		if(StringUtils.isBlank(request.getParameter("password")) == false){
			String password =request.getParameter("password");
			if (password.matches("^[ -~｡-ﾟ]+$") && 6 <= password.length() && password.length() <= 20) {
				editUser.setPassword(password);
			}
		}
		if (StringUtils.isBlank(request.getParameter("name")) == false) {
			editUser.setName(request.getParameter("name"));
		}

		editUser.setBranchId(Integer.parseInt(request.getParameter("branch")));
		editUser.setPositionId(Integer.parseInt(request.getParameter("position")));
		return editUser;
	}

	private boolean isValid(HttpServletRequest request, List<String> messages,int id) {

		UserService userService = new UserService();
		String loginId = request.getParameter("loginId");
		String password = request.getParameter("password");
		String checkPassword = request.getParameter("checkPassword");
		String name = request.getParameter("name");
		String branch = request.getParameter("branch");
		String position = request.getParameter("position");
		String[] main = {"1", "2"};
		List<String> mainOffice = Arrays.asList(main);
		String[] sub = {"3", "4"};
		List<String> subOffice = Arrays.asList(sub);



		if (StringUtils.isBlank(loginId) == true) {
			messages.add("ログインIDを入力してください");
		}
		if(StringUtils.isBlank(loginId) == false){
			if(!loginId.matches("^[0-9a-zA-Z]+$") || 6 > loginId.length()  || loginId.length() > 20){
				messages.add("ログインIDは半角英数字6文字以上20文字以下で入力してください");
			}
		}
		if (userService.getUser(loginId) != null ) {
			if(!loginId.equals((userService.getUser(id)).getLoginId())){
				messages.add("入力したログインIDは既に使用されています");
			}
		}
		if(StringUtils.isBlank(password) == false){
			if(!password.matches("^[ -~｡-ﾟ]+$") || 6 > password.length()  || password.length() > 20){
				messages.add("パスワードは記号または半角文字6文字以上20文字以下で入力してください");
			}
		}
		if(password.matches("^[ -~｡-ﾟ]+$") && 6 <= password.length() && password.length() <= 20){
			if(!password.equals(checkPassword)){
				messages.add("パスワードが一致していません");
			}
		}
		if (StringUtils.isBlank(name) == true) {
			messages.add("名前を入力してください");
		}
		if(StringUtils.isBlank(name) == false){
			if (name.length() > 10) {
				messages.add("名前は10文字以内で入力してください");
			}
		}
		if(Integer.parseInt(branch) == 1 && !mainOffice.contains(position)){
			messages.add("支店と部署/役職の組み合わせに誤りがあります");
		} else if(Integer.parseInt(branch) != 1 && !subOffice.contains(position)){
			messages.add("支店と部署/役職の組み合わせに誤りがあります");
		}


		if (messages.size() == 0) {
			return true;
		} else {
			return false;
		}
	}

}
