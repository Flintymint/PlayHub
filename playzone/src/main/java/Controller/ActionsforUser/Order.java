package Controller.ActionsforUser;

import java.io.IOException;

import java.io.PrintWriter;
import java.sql.SQLException;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import Controller.DataBaseConnection.DataBaseConnection;
import Model.User.User;
import Model.User.UserMessage;
import Utils.productQueryHandler;



/**
 * Servlet implementation class Order
 */
@WebServlet("/Order")
public class Order extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Order() {
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
		PrintWriter printOut=response.getWriter();
		HttpSession session = request.getSession();
		User u = (User) session.getAttribute("User");
		@SuppressWarnings("unchecked")
		ArrayList<String> cart=(ArrayList<String>)session.getAttribute("cart");
		
		if(cart==null || cart.isEmpty()) {
			// If cart is empty, redirect to cart page with a message
			UserMessage msg=new UserMessage(" is Empty Please Add products!","Cart is Empty","invalid-login");
			session.setAttribute("Message", msg);
			response.sendRedirect(request.getContextPath()+"/pages/cart.jsp");
			
		}
		else {
			for (String product : cart) {
				try {
					// Get current date
					LocalDate currentDate1 = LocalDate.now();
					DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
					String currentDateAsString = currentDate1.format(formatter);
					// Parse product ID 
					int id = Integer.parseInt(product);
					// Create product query handler instance
					productQueryHandler pq =new productQueryHandler(DataBaseConnection.connection());
					// Add order to the database
					printOut.println(currentDate1); // Print current date
					printOut.println(u.getEmailAddress()); // Print user's email address
					String Email=u.getEmailAddress();
					String Name=u.getFirstName();
					pq.addOrder(id,Name,Email,currentDateAsString); // Add order to the database
					
				} catch (ClassNotFoundException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
			// Clear cart after placing order and redirect to cart page
			cart.clear();
			response.sendRedirect(request.getContextPath()+"/pages/cart.jsp");
			
		}

	}

}

