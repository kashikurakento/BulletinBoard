
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


@WebFilter(filterName="authorityFilter", urlPatterns={"/manage", "/signup", "/setting"})
public class AuthorityFilter implements Filter {

	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
			throws IOException, ServletException {

		HttpSession session = ((HttpServletRequest) request).getSession();
		UserService userService = new UserService();
		User newLoginUser =userService.getUser(((User) session.getAttribute("loginUser")).getId());

		if(!(newLoginUser.getPositionId().equals(1))){
			((HttpServletResponse) response).sendRedirect("./");
				return;
		}
		chain.doFilter(request, response);
	}

	public void init(FilterConfig fConfig) throws ServletException {}

	public void destroy() {}

}
