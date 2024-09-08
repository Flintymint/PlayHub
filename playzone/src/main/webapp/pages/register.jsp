<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@page import="Model.User.UserMessage" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Create Account</title>
    <link rel="stylesheet" href="<%=request.getContextPath() %>/css/header.css"/>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;500;600;700&display=swap" rel="stylesheet">
    <style>
        :root {
            --font-family: "Poppins", sans-serif;
        }

        body {
            height: 100vh;
            margin: 0;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            background-image: url(<%=request.getContextPath()%>/images/loginback.webp);
            background-color: lightgray;
            background-size: cover;
            background-repeat: no-repeat;
            background-position: center;
        }

        .container {
            max-width: 350px;
            background-color: rgba(255, 255, 255, 0.461);
            border-radius: 15px;
            overflow: hidden;
            margin-top: 100px; /* Adjust for header */
        }

        form {
            display: grid;
            grid-template-columns: 1fr 1fr 1fr;
            gap: 15px;
            padding: 32px 24px 24px;
            text-align: center;
        }

        ::placeholder {
            color: #000000;
            font-family: var(--font-family);
        }

        form .head {
            grid-column: span 3;
            display: flex;
            flex-direction: column;
            gap: 16px;
        }

        form .head span {
            font-size: 1.6rem;
            font-weight: bolder;
            color: black;
            font-family: var(--font-family);
        }

        form .head p {
            font-size: 1.1rem;
            color: #000000;
            font-family: var(--font-family);
        }

        form .inputs {
            overflow: hidden;
            background-color: #fff;
            width: 100%;
            margin: 0;
            border-radius: 8px;
            border-bottom: none;
            outline: 0;
            grid-column: span 3; /* Full width for input fields */
        }

        form .inputs input {
            border: none;
            outline: none;
            padding: 8px 15px;
            width: 100%;
            height: 40px;
            border-bottom: 1px solid rgba(128, 128, 128, 0.299);
            font-weight: 200;
        }

        input[type=text] {
            background-color: rgba(255, 255, 255, 0.461);
        }

        form button {
            grid-column: span 3;
            font-family: var(--font-family);
            background-color: #4287ef;
            color: white;
            width: 100%;
            height: 40px;
            padding-top: 8px;
            padding-bottom: 8px;
            border: 0;
            overflow: hidden;
            border-radius: 25px;
            font-size: 1rem;
            font-weight: 600;
            cursor: pointer;
            transition: all 1s ease-in-out;
        }

        form button:hover {
            background-color: #005ce6;
        }

        .form-footer {
            grid-column: span 3;
            font-family: var(--font-family);
            background-color: #ffffff00;
            padding: 16px;
            font-size: 1rem;
            text-align: center;
        }

        .form-footer a {
            font-family: var(--font-family);
            font-weight: bolder;
            color: #000000;
            transition: all 3s ease-in-out;
        }

        .form-footer a:hover {
            color: #005ce6;
        }

        header {
            position: fixed;
            top: 0;
            left: 15px; /* Move header to the left */
            width: calc(100% - 151px); /* Adjust width to account for left padding */
        }
    </style>
</head>

<body>
    <%@include file="header.jsp"%>

    <section class="content">
        <div class="container">
            <form name="registerForm" action="<%=request.getContextPath()%>/Register" method="post" enctype="multipart/form-data">
                <div class="head">
                    <!-- Title for the registration form -->
                    <span class="form_title">Create an Account</span>
                    
                    <!-- Displaying any messages if present -->
                    <%
                    UserMessage msg = (UserMessage)session.getAttribute("Message");
                    if (msg != null) {
                    %>
                    <div class="alert alert-info"><%=msg.getMessageCssClass() %></div>
                    <%
                        session.removeAttribute("Message");
                    }
                    %>
                </div>
                <!-- Input fields for user registration details -->
                <div class="inputs">
                    <input type="text" name="FirstName" id="FirstName" placeholder="First Name" required>
                </div>

                <div class="inputs">
                    <input type="text" name="LastName" id="LastName" placeholder="Last Name" required>
                </div>

                <div class="inputs">
                    <input type="tel" name="Contact" id="Contact" placeholder="Contact Number" required>
                </div>

                <div class="inputs">
                    <input type="email" name="Email" id="Email" placeholder="Email Address" required>
                </div>

                <div class="inputs">
                    <input type="password" name="Password" id="Password" placeholder="Create Password" required>
                </div>

                <div class="inputs">
                    <input type="file" name="ProfilePicture" id="ProfilePicture" accept="image/*">
                </div>

                <!-- Button to submit the registration form -->
                <button type="submit" value="send">Register Now</button>

                <!-- Link to login page for users with existing accounts -->
                <div class="form-footer">
                    Already have an account? <a href="login.jsp">Login</a>
                </div>
            </form>
        </div>
    </section>
</body>
</html>
