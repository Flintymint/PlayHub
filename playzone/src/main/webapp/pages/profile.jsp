<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE html>
<%@ page import="Model.User.User" %>
<%
User user1 = (User)session.getAttribute("User");
if (user1 == null) {
    response.sendRedirect("login.jsp");
}
%>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>User Profile - Profile Details</title>
    <link rel="stylesheet" href="<%=request.getContextPath() %>/css/header.css"/>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;500;600;700&display=swap" rel="stylesheet">
    <style>
        body {
            font-family: 'Montserrat', sans-serif;
            background-color: #f8f9fa;
            margin: 0;
            padding: 0;
        }

        .content {
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            padding: 40px;
        }

        .profile-card {
            background-color: #fff;
            border-radius: 10px;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
            padding: 40px;
            max-width: 800px;
            width: 100%;
        }

        .profile-header {
            display: flex;
            align-items: center;
            margin-bottom: 30px;
        }

        .profile-image {
            width: 120px;
            height: 120px;
            border-radius: 50%;
            overflow: hidden;
            margin-right: 30px;
        }

        .profile-image img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }

        .profile-info h2 {
            font-size: 24px;
            font-weight: 700;
            color: #333;
            margin-bottom: 10px;
        }

        .profile-info p {
            font-size: 16px;
            color: #666;
            margin-bottom: 5px;
        }

        .form-group {
            margin-bottom: 20px;
        }

        .form-group label {
            font-size: 16px;
            font-weight: 500;
            color: #333;
            display: block;
            margin-bottom: 8px;
        }

        .form-group input[type="text"],
        .form-group input[type="password"],
        .form-group input[type="file"] {
            width: 100%;
            padding: 12px 16px;
            font-size: 16px;
            border-radius: 5px;
            border: 1px solid #ccc;
            background-color: #f8f9fa;
            transition: border-color 0.3s ease;
        }

        .form-group input[type="text"]:focus,
        .form-group input[type="password"]:focus,
        .form-group input[type="file"]:focus {
            outline: none;
            border-color: #6c63ff;
        }

        .btn {
            background-color: #6c63ff;
            color: #fff;
            font-size: 16px;
            font-weight: 500;
            padding: 12px 24px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        .btn:hover {
            background-color: #5a4fec;
        }
    </style>
</head>
<body>
    <%@include file="header.jsp" %>

    <section class="content">
    	<!-- Display user profile information -->
        <div class="profile-card">
            <div class="profile-header">
                <div class="profile-image">
                 	<!-- Display user's profile picture -->
                    <img src="<%=request.getContextPath()%>/images/userprofilefolder/<%=user1.getProfileImage()%>" alt="Profile Picture">
                </div>
                <div class="profile-info">
                	<!-- Display user's first name and contact information -->
                    <h2><%=user1.getFirstName() %></h2>
                    <p>Contact: <%=user1.getPhoneNumber() %></p>
                </div>
            </div>
            <!-- Form for updating profile information -->
            <form name="profile_form" action="<%=request.getContextPath() %>/editProfile" method="post" enctype="multipart/form-data">
                <div class="form-group">
                    <label for="FirstName">Update Name</label>
                    <input type="text" id="FirstName" name="FirstName" placeholder="Enter new name" class="box">
                </div>
                <div class="form-group">
                    <label for="Contact">Update Contact</label>
                    <input type="text" id="Contact" name="Contact" placeholder="Enter new contact" class="box">
                </div>
                <div class="form-group">
                    <label for="Password">Update Password</label>
                    <input type="password" id="Password" name="Password" placeholder="Create new password" class="box">
                </div>
                <div class="form-group">
                    <label for="ProfilePicture">Update Profile Picture</label>
                    <input type="file" id="ProfilePicture" name="ProfilePicture" accept="image/png, image/jpeg, image/jpg" class="box">
                </div>
                <!-- Button to save changes -->
                <button type="submit" class="btn" name="save_changes">Save Changes</button>
            </form>
        </div>
    </section>
</body>
</html>