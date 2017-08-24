package bulletinboard.filter;


import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import bulletinboard.beans.User;
import bulletinboard.service.UserService;


@WebFilter(filterName="isWorkingFilter", urlPatterns="/*")
public class isWorkingFilter implements Filter {

	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
			throws IOException, ServletException {

		HttpSession session = ((HttpServletRequest) request).getSession();
		User loginUser = (User) session.getAttribute("loginUser");

		if(loginUser != null){
			if(!((HttpServletRequest) request).getServletPath().equals("/login")){

				UserService userService = new UserService();
				User newLoginUser =userService.getUser(loginUser.getId());

				if((newLoginUser.getIsWorking().equals(0))){
					((HttpServletResponse) response).sendRedirect("login");
					session.invalidate();
					return;
				}
			}
		}


		chain.doFilter(request, response);
	}

	public void init(FilterConfig fConfig) throws ServletException {}

	public void destroy() {}

}
