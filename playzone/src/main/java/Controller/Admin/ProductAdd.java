package Controller.Admin;

import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import Controller.DataBaseConnection.DataBaseConnection;
import Model.Product.product;
import Utils.productQueryHandler;

/** 
 * Servlet implementation class productC
 */
@MultipartConfig
@WebServlet("/ProductAdd")
public class ProductAdd extends HttpServlet {
    private static final long serialVersionUID = 1L;

    /**
     * @see HttpServlet#HttpServlet()
     */
    public ProductAdd() {
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
        // Get product details from the request parameters
        String productName=request.getParameter("product_name");
        String productCategory = request.getParameter("product_category");
        String productBrand=request.getParameter("brand_name");
        String productPrice = request.getParameter("product_price");
        int stockLeft = Integer.parseInt (request.getParameter ("stockLeft"));
        Part picture=request.getPart("product_image");
        String pictureName=picture.getSubmittedFileName();
        String pictureURL = "D:\\Ecliplse Workplace\\playzone\\src\\main\\webapp\\images\\productfolder\\" + pictureName;
        
        try {
        	// Save the uploaded product image to the specified directory
            FileOutputStream fos=new FileOutputStream(pictureURL);// Create a FileOutputStream to write the image data to a file
            InputStream is=picture.getInputStream();// Get the InputStream from the Part containing the uploaded image
            byte[] data=new byte[is.available()];// Create a byte array to store the image data
            is.read(data);// Read the image data from the InputStream into the byte array
            fos.write(data);// Write the image data from the byte array to the FileOutputStream, which saves it to the specified file path
            fos.close();// Close the FileOutputStream to release system resources
        } catch(Exception e) {
            e.printStackTrace();
        }
        
        // Create a new product object with the retrieved details
        product p = new product(productName, productCategory, productBrand, productPrice, pictureName, stockLeft);
        productQueryHandler pq;
        
        try {
        	// Create a productQueryHandler instance to interact with the database
            pq = new productQueryHandler(DataBaseConnection.connection());
            // Add the product to the database
            pq.addProduct(p);
            // Redirect back to the admin page after adding the product
            response.sendRedirect(request.getContextPath()+"/pages/admin.jsp");
        } catch (ClassNotFoundException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();// Handle exceptions related to database connection
        } catch (SQLException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();// Handle exceptions related to SQL queries
        }
    }
}