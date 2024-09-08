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

import Controller.DataBaseConnection.DataBaseConnection;
import Controller.EncryptPassword.EncDyc;
import Model.User.User;
import Model.User.UserMessage;
import Utils.UserQueryHandler;

@MultipartConfig
@WebServlet("/Register")
public class Register extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public Register() {
        super();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.getWriter().append("Served at: ").append(request.getContextPath());
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        PrintWriter printOut = response.getWriter();
        // Get user input parameters from the request
        String firstName = request.getParameter("FirstName");
        String lastName = request.getParameter("LastName");
        String phoneNumber = request.getParameter("Contact");
        String emailAddress = request.getParameter("Email");
        String password = request.getParameter("Password");
        Part profileImagePart = request.getPart("ProfilePicture");
        String profileImageName = profileImagePart.getSubmittedFileName();
        String encryptedPassword = "";

        try {
        	// Encrypt the password
            encryptedPassword = EncDyc.encryption(password, "my-Secret-Key-hi");
        } catch (Exception e1) {
            e1.printStackTrace();
        }

        // Create a new User object with the user's details
        User user = new User(firstName, lastName, phoneNumber, emailAddress, encryptedPassword, profileImageName, "customer");
        UserQueryHandler queryHandler;

        try {
        	// Create a new UserQueryHandler instance to interact with the database
            queryHandler = new UserQueryHandler(DataBaseConnection.connection());

            if (queryHandler.checkIfUserExists(user)) {
            	// If user exists, redirect to registration page with an error message
                HttpSession session = request.getSession();
                UserMessage message = new UserMessage("Email already in use. Please use another email", "Registration Error", "invalid-registration");
                session.setAttribute("Message", message);
                response.sendRedirect(request.getContextPath() + "/pages/register.jsp");
            } else {
            	// If user doesn't exist, proceed with registration
                if (queryHandler.registerUser(user)) {
                    // Save the profile image if registration is successful
                    saveProfileImage(profileImagePart, profileImageName);
                    // Redirect to login page after successful registration
                    response.sendRedirect(request.getContextPath() + "/pages/login.jsp");
                } else {
                	// If registration fails, print a message
                    printOut.println("Registration Failed");
                }
            }
        } catch (ClassNotFoundException | SQLException e2) {
            e2.printStackTrace();
        }
    }

    private void saveProfileImage(Part profileImagePart, String profileImageName) {
    	// Define the path to save the profile image
    	String profileImagePath = "D:\\Ecliplse Workplace\\playzone\\src\\main\\webapp\\images\\userprofilefolder\\" + profileImageName;

        try {
        	// Save the profile image to the specified path
            FileOutputStream fileOutputStream = new FileOutputStream(profileImagePath);
            InputStream inputStream = profileImagePart.getInputStream();// Get the InputStream
            byte[] data = new byte[inputStream.available()];// Create a byte array to store the image data
            inputStream.read(data);// Read the image data from the InputStream into the byte array
            fileOutputStream.write(data);// Write the image data from the byte array to the FileOutputStream, which saves it to the specified file path
            fileOutputStream.close();// Close the FileOutputStream to release system resources
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}