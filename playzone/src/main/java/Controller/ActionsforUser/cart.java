package Controller.ActionsforUser;

import java.io.IOException;

import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import Model.User.User;



/**
 * Servlet implementation class cart
 */
@WebServlet("/cart")
public class cart extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public cart() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session=request.getSession();
		User u=new User();
		u=(User)session.getAttribute("User");
		if(u==null) {
			// If the user is not logged in, redirect to the login page
			response.sendRedirect(request.getContextPath()+"/pages/login.jsp");
		}
		else {
			// Get the item ID from the request parameter
			String id=request.getParameter("id");
			@SuppressWarnings("unchecked")
			// Get the user's cart from the session
			ArrayList<String> cart=(ArrayList<String>)session.getAttribute("cart");
	        if(cart == null) {
	        	// If the cart is empty, create a new one
	            cart = new ArrayList<>();
	            session.setAttribute("cart", cart);
	        }
	        // Add the item ID to the cart
	        cart.add(id);
	        // Redirect the user to the home page after adding the item to the cart
	        response.sendRedirect(request.getContextPath()+"/pages/home.jsp");
	        
	        
		}
	}

}
