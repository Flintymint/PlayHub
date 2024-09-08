package Controller.Admin;

import java.io.IOException;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import Controller.DataBaseConnection.DataBaseConnection;
import Utils.productQueryHandler;

/**
 * Servlet implementation class RemoveProduct
 */
@WebServlet("/DeleteProds")
public class DeleteProds extends HttpServlet {
    private static final long serialVersionUID = 1L;

    /**
     * @see HttpServlet#HttpServlet()
     */
    public DeleteProds() {
        super();
    }

    /**
     * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
     */
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.getWriter().append("Served at: ").append(request.getContextPath());
    }

    /**
     * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
     */
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
        	// Get the ID parameter
            String idParam = request.getParameter("id");
            if (idParam != null && !idParam.isEmpty()) {
                int id = Integer.parseInt(idParam);// Convert the ID parameter to an integer
                // Create a productQueryHandler instance to interact with the database
                productQueryHandler productQueryHandler = new productQueryHandler(DataBaseConnection.connection());
                // Delete the product with the specified ID
                productQueryHandler.deleteProduct(id);
                // Set a success message in the session
                HttpSession session = request.getSession();
                session.setAttribute("successMsg", "Product removed successfully");
                // Redirect back to the admin page
                response.sendRedirect(request.getContextPath() + "/pages/admin.jsp");
            } else {
            	// If the ID parameter is empty or null, set an error message in the session
                HttpSession session = request.getSession();
                session.setAttribute("errorMsg", "Invalid product ID");
                // Redirect back to the admin page
                response.sendRedirect(request.getContextPath() + "/pages/admin.jsp");
            }
        } catch (ClassNotFoundException | SQLException e) {// Handle exceptions related to database connection or SQL queries
            e.printStackTrace();
            // Set an error message in the session
            HttpSession session = request.getSession();
            session.setAttribute("errorMsg", "An error occurred while removing the product");// Set an error message in the session
            // Redirect back to the admin page
            response.sendRedirect(request.getContextPath() + "/pages/admin.jsp");
        }
    }
}