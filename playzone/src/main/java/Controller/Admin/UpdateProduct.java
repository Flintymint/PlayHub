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
import Utils.productQueryHandler;


/**
 * Servlet implementation class editProduct
 */
@MultipartConfig
@WebServlet("/UpdateProduct")
public class UpdateProduct extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public UpdateProduct() {
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
	try {
		int id = Integer.parseInt(request.getParameter("id"));
		String productName=request.getParameter("product_name"); 
		String productCategory=request.getParameter("product_category"); 
		String productBrand=request.getParameter("brand_name");
		String productPrice=request.getParameter("product_price");
		int stockLeft=Integer.parseInt(request.getParameter("stockLeft")); 
		Part picture=request.getPart("product_image");
		String pictureName=picture.getSubmittedFileName();
		String pictureURL="D:\\Ecliplse Workplace\\playzone\\src\\main\\webapp\\images\\userprofilefolder\\"+pictureName;
		try {
			FileOutputStream fos=new FileOutputStream(pictureURL);
			InputStream is=picture.getInputStream();
			byte[] data=new byte[is.available()];
			is.read(data);
			fos.write(data);
			fos.close();
			}
			catch(Exception e) {
				e.printStackTrace();
			}
		try {
			productQueryHandler pq=new productQueryHandler(DataBaseConnection.connection());
			pq.editProduct(productName,productCategory,productBrand, productPrice, pictureName, stockLeft, id);
			response.sendRedirect(request.getContextPath()+"/pages/admin.jsp");
		}
		catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
		catch (SQLException e) {
			e.printStackTrace();
		}
		
	}catch (NumberFormatException e) {
		// TODO: handle exception
		response.sendRedirect(request.getContextPath()+"/pages/admin.jsp");
	}	

	
}
}


