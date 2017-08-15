package bulletinboard.filter;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

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

@WebFilter(filterName="loginFilter", urlPatterns="/*")
public class LoginFilter implements Filter {

	public void doFilter(ServletRequest request, ServletResponse response,
			FilterChain chain) throws IOException, ServletException {

		HttpSession session = ((HttpServletRequest) request).getSession();

		if(!((HttpServletRequest) request).getServletPath().equals("/login")){
			if (session.getAttribute("loginUser") == null) {
				List<String> messages = new ArrayList<String>();
				messages.add("ログインしてください");
				session.setAttribute("errorMessages", messages);
				((HttpServletResponse) response).sendRedirect("login");
				return;
			}
		}
		chain.doFilter(request, response);
	}

	public void init(FilterConfig fconfig) throws ServletException {}

	public void destroy() {}

}