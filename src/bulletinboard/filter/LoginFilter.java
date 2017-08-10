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

@WebFilter(filterName="loginFilter", urlPatterns="/*")
public class LoginFilter implements Filter {

	public void doFilter(ServletRequest request, ServletResponse response,
			FilterChain chain) throws IOException, ServletException {

		HttpSession session = ((HttpServletRequest) request).getSession();

		if(!((HttpServletRequest) request).getServletPath().equals("/login")){
			if (session.getAttribute("loginUser") == null) {
				((HttpServletResponse) response).sendRedirect("login");
				return;
			}
		}
		chain.doFilter(request, response); // サーブレットを実行
	}

	public void init(FilterConfig fconfig) throws ServletException {}

	public void destroy() {}

}