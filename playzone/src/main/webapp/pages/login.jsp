<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@page import="Model.User.UserMessage" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Login</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
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

        .form-container {
            position: relative;
            background-color: rgba(255, 255, 255, 0.461);
            border-radius: 1rem;
            font-family: var(--font-family);
            bottom: 40px;
        }

        .form {
            display: block;
            padding: 1rem;
            max-width: 350px;
            border-radius: 0.5rem;
            box-shadow: 0 10px 15px -3px rgba(0, 0, 0, 0.1), 0 4px 6px -2px rgba(255, 255, 255, 0.05);
            font-family: var(--font-family);
        }

        ::placeholder {
            color: rgb(0, 0, 0);
            font-family: var(--font-family);
        }

        .form-title {
            font-family: var(--font-family);
            font-size: 1.25rem;
            line-height: 1.75rem;
            font-weight: 600;
            text-align: center;
            color: #000;
        }

        .input-container {
            position: relative;
        }

        .input-container input,
        .form button {
            outline: none;
            border: 1px solid #e5e7eb;
            margin: 8px 0;
            font-family: var(--font-family);
        }

        .input-container input {
            background-color: #f7f7f7;
            padding: 1rem;
            padding-right: 2rem;
            font-size: 0.875rem;
            line-height: 1.25rem;
            width: 300px;
            border-radius: 0.5rem;
            box-shadow: 0 1px 2px 0 rgba(0, 0, 0, 0.05);
            font-family: var(--font-family);
        }

        .input-container span {
            display: grid;
            position: absolute;
            top: 0;
            bottom: 0;
            right: 0;
            padding-left: 1rem;
            padding-right: 1.5rem;
            place-content: center;
            font-family: var(--font-family);
        }
        
        .submit {
            grid-column: span 3;
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

        .submit:hover {
            background-color: #005ce6;
        }

        

        .signup-link {
            color: #000000;
            font-size: 1rem;
            line-height: 1.25rem;
            text-align: center;
        }

        .signup-link a {
            font-size: 1rem;
            font-weight: 500;
            font-family: var(--font-family);
            text-decoration: underline;
        }

        header {
            position: fixed;
            top: 0;
            left: 15px; /* Move header to the left */
            width: calc(100% - 151px); /* Adjust width to account for left padding */
        }

        main {
            display: flex;
            justify-content: center;
            align-items: center;
            flex: 1;
            width: 100%;
            padding-top: 100px; /* Adjust for fixed header */
        }
    </style>
    <script>
        function navigateToHomepage() {
            window.location.href = "<%=request.getContextPath()%>/pages/home.jsp";
        }
    </script>
</head>

<body>
    <%@include file="header.jsp"%>
    <main>
        <div class="form-container">
            <!-- Login form -->
            <div class="form">
                <form name="loginForm" action="<%=request.getContextPath()%>/LoginServ" method="Post">
                    <!-- Form title -->
                    <div class="form-title">Sign in</div>

                    <!-- Displaying any login messages -->
                    <%
                    UserMessage msg = (UserMessage)session.getAttribute("Message");
                    if (msg != null) {
                    %>
                    <div class="alert"><%=msg.getMessageContent()%></div>
                    <%
                        session.removeAttribute("Message");
                    }
                    %>

                    <!-- Input fields for email and password -->
                    <div class="input-container">
                        <label for="Email">Email Address</label>
                        <input type="email" name="Email" id="Email" placeholder="Email" required>
                    </div>

                    <div class="input-container">
                        <label for="password">Password</label>
                        <input type="password" name="Password" id="Password" placeholder="Password" required>
                    </div>

                    <!-- Submit button -->
                    <button type="submit" class="submit" value="send">Log in</button>

                    <!-- Signup link -->
                    <div class="signup-link">
                        Don't have an account? <a href="register.jsp">Create Account</a>
                    </div>
                </form>
            </div>
        </div>
    </main>
    <script>
    <!-- Script to navigate to homepage when logo is clicked -->
        const logo = document.querySelector('.logo');
        logo.addEventListener('click', navigateToHomepage);
    </script>
</body>
</html>
