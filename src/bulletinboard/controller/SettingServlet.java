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

import bulletinboard.beans.Branch;
import bulletinboard.beans.Position;
import bulletinboard.beans.User;
import bulletinboard.exception.NoRowsUpdatedRuntimeException;
import bulletinboard.service.BranchService;
import bulletinboard.service.PositionService;
import bulletinboard.service.UserService;

@WebServlet(urlPatterns = { "/setting" })
public class SettingServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	@Override
	protected void doGet(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {

		HttpSession session = request.getSession();
		UserService userService = new UserService();

		if(session.getAttribute("editUser") == null){
			User editUser = userService.getUser(Integer.parseInt(request.getParameter("id")));
			session.setAttribute("editUser", editUser);
			session.setAttribute("id", editUser.getId());
			int branchId = editUser.getBranchId();
			session.setAttribute("branchId", branchId);
			int positionId = editUser.getPositionId();
			session.setAttribute("positionId", positionId);
		}

		List<Branch> branches = new BranchService().getBranch();
		request.setAttribute("branches", branches);

		List<Position> positions = new PositionService().getPosition();
		request.setAttribute("positions", positions);

		request.getRequestDispatcher("setting.jsp").forward(request, response);

	}

	@Override
	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {

		List<String> messages = new ArrayList<String>();

		HttpSession session = request.getSession();
		User editUser = getEditUser(request);
		session.setAttribute("editUser", editUser);

		if (isValid(request, messages) == true) {
			try {
				new UserService().update(editUser);
			} catch (NoRowsUpdatedRuntimeException e) {
				session.removeAttribute("editUser");
				messages.add("他の人によって更新されています。最新のデータを表示しました。データを確認してください。");
				session.setAttribute("errorMessages", messages);
				response.sendRedirect("setting");
			}

			session.removeAttribute("editUser");

			response.sendRedirect("manage");
		} else {
			session.setAttribute("errorMessages", messages);
			List<Branch> branches = new BranchService().getBranch();
			request.setAttribute("branches", branches);

			List<Position> positions = new PositionService().getPosition();
			request.setAttribute("positions", positions);

			response.sendRedirect("setting");
		}
	}

	private User getEditUser(HttpServletRequest request)
			throws IOException, ServletException {

		HttpSession session = request.getSession();

		User editUser = (User) session.getAttribute("editUser");

		editUser.setLoginId(request.getParameter("loginId"));

		String password =request.getParameter("password");
		if (password.matches("^[0-9a-zA-Z]+$") && 6 <= password.length() && password.length() <= 20) {
			editUser.setPassword(password);
		}

		editUser.setName(request.getParameter("name"));
		editUser.setBranchId(Integer.parseInt(request.getParameter("branch")));
		editUser.setPositionId(Integer.parseInt(request.getParameter("position")));
		return editUser;
	}

	private boolean isValid(HttpServletRequest request, List<String> messages) {

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
		if(StringUtils.isBlank(password) == false){
			if(!password.matches("^[0-9a-zA-Z]+$") || 6 > password.length()  || password.length() > 20){
				messages.add("パスワードは半角英数字6文字以上20文字以下で入力してください");
			}
		}
//		if (StringUtils.isBlank(checkPassword) == true) {
//			messages.add("パスワード（再入力）を入力してください");
//		}
		if(password.matches("^[0-9a-zA-Z]+$") && 6 <= password.length() && password.length() <= 20){
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
