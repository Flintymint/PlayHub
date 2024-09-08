package Controller.ActionsforUser;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class RemoveCart
 */
@WebServlet("/RemoveCart")
public class RemoveCart extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public RemoveCart() {
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
		// Get the ID of the item to remove from the cart
		String id = request.getParameter("id");
		 HttpSession session = request.getSession();// Get the cart from the session
		    @SuppressWarnings("unchecked")
			ArrayList<String> cart = (ArrayList<String>) session.getAttribute("cart");
		    if (cart != null) {
		    	// If the cart is not null, remove the item with the specified ID
		        cart.remove(id);
		    }
		    // Redirect back to the cart page after removing the item
		    response.sendRedirect(request.getContextPath() + "/pages/cart.jsp");
	}

}
