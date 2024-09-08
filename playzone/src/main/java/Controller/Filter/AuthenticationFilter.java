package Controller.Filter;

import java.io.IOException;

import java.io.PrintWriter;

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

import Model.User.User;

/**
 * Servlet Filter implementation class AuthenticationFilter
 */
@WebFilter("/AuthenticationFilter")
public class AuthenticationFilter implements Filter {

    /**
     * Default constructor. 
     */
    public AuthenticationFilter() {
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see Filter#destroy()
	 */
	public void destroy() {
		// TODO Auto-generated method stub
	}

	/**
     * @see Filter#doFilter(ServletRequest, ServletResponse, FilterChain)
     * Method to intercept requests and perform filtering tasks.
     * Checks if the user is authenticated as an admin.
     * If authenticated, allows access to the requested resource.
     * If not authenticated, redirects to the home page.
     */
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
		PrintWriter printOut=response.getWriter();
		HttpServletRequest req = (HttpServletRequest) request;
		HttpServletResponse res = (HttpServletResponse) response;
		HttpSession session = req.getSession();
		
		// Retrieve user from session
		User user=(User)session.getAttribute("User");
		String email = user.getEmailAddress();
		printOut.println("This is email"+email);
		
		if (user!=null && user.getEmailAddress().equals("admin@gmail.com")) {
			// If user is logged in and is an admin, allow access to the requested resource
			chain.doFilter(request, response);
		} else {
			// If user is not an admin or not logged in, redirect to home page
			res.sendRedirect("/pages/home.jsp");
		}
		
	}

	/**
	 * @see Filter#init(FilterConfig)
	 */
	public void init(FilterConfig fConfig) throws ServletException {
		// TODO Auto-generated method stub
	}

}
