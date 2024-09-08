package Controller.ActionsforUser;

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
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

import Controller.DataBaseConnection.*;
import Controller.EncryptPassword.EncDyc;
import Model.User.*;
import Utils.UserQueryHandler;

/**
 * Servlet implementation class editProfile
 */
@MultipartConfig
@WebServlet("/editProfile")
public class editProfile extends HttpServlet {
    private static final long serialVersionUID = 1L;

    /**
     * @see HttpServlet#HttpServlet()
     */
    public editProfile() {
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
        PrintWriter printOut = response.getWriter();
        // Get the uploaded profile picture
        Part picture = request.getPart("ProfilePicture");
        String pictureName = picture.getSubmittedFileName();
        // Define the path to save the picture
        String pictureURL = "D:\\Ecliplse Workplace\\playzone\\src\\main\\webapp\\images\\userprofilefolder\\" + pictureName;

        try {
        	// Save the uploaded picture to the specified path
            FileOutputStream fos = new FileOutputStream(pictureURL);
            InputStream is = picture.getInputStream();
            byte[] data = new byte[is.available()];
            is.read(data);
            fos.write(data);
            fos.close();
        } catch (Exception e) {
            e.printStackTrace();
        }

        try {
        	// Create a new instance of UserQueryHandler to interact with the database
            UserQueryHandler user = new UserQueryHandler(DataBaseConnection.connection());
            HttpSession session = request.getSession();
            // Get user input for profile fields
            String firstName = request.getParameter("FirstName");
            String password = request.getParameter("Password");
            String contact = request.getParameter("Contact");
            User u = (User) session.getAttribute("User");

            String encryptedPassword = "";
            // Encrypt the password
            if (!password.isEmpty()) {
                encryptedPassword = EncDyc.encryption(password, "my-Secret-Key-hi");
            } else {
                encryptedPassword = u.getPassword();
            }
            
            // Set default values for fields not provided by the user
            if (contact.isEmpty()) {
                contact = u.getPhoneNumber();
            }

            if (firstName.isEmpty()) {
                firstName = u.getFirstName();
            }

            if (pictureName.isEmpty()) {
                pictureName = u.getProfileImage();
            }

            // Update user profile in the database
            user.updateUserProfile(pictureName, firstName, encryptedPassword, contact, u.getEmailAddress());

            // Update user object with new profile details
            u.setPhoneNumber(contact);
            u.setFirstName(firstName);
            u.setProfileImage(pictureName);
            u.setPassword(encryptedPassword);

            session.setAttribute("User", u);
            response.sendRedirect(request.getContextPath() + "/pages/home.jsp");
        } catch (ClassNotFoundException | SQLException e1) {
            e1.printStackTrace();
        } catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
    }
}