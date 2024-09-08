<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%><!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>About Us</title>
    <link href="https://cdn.jsdelivr.net/npm/remixicon@4.0.0/fonts/remixicon.css" rel="stylesheet"/>
    <style>
        body, html {
            height: 100%;
            margin: 0;
        }

        .cards {
            display: flex;
            justify-content: center;
            align-items: center;
            height: 80vh;
            background-color: #f0f0f0; /* Optional: Add a background color */
        }

        .card {
            background-color: #fff;
            border-radius: 15px;
            box-shadow: 0 8px 14px 0 rgba(0, 0, 0, 0.2);
            display: flex;
            flex-direction: column;
            align-items: center;
            padding: 20px;
            width: 350px;
            text-align: center;
        }

        .card img {
            border-radius: 50%;
            width: 60%;
            margin-bottom: 20px;
        }

        .title {
            font-size: 1.5em;
            font-weight: 900;
            margin: 10px 0;
        }

        .role {
            font-size: 1em;
            font-weight: 700;
            color: #666;
            margin-bottom: 20px;
        }

        .contact-info {
            font-size: 1em;
            color: #333;
            margin-bottom: 20px;
        }

        .cardbuttons {
            display: flex;
            gap: 20px;
        }

        .cardbuttons a {
            font-size: 25px;
            color: black;
            text-decoration: none;
            transition: color 0.3s;
        }

        .cardbuttons a:hover {
            color: #007bff;
        }
    </style>
</head>
<body>
    <!-- navbar starts here -->
    <%@include file="header.jsp"%>
    <!-- navbar ends here -->
    <section class="cards">    
        <div class="card">
            <img src="<%= request.getContextPath() %>/images/safal.jpg" alt="Safal Shrestha">
            <p class="title">Sanish</p>
            <p class="role">Leader</p>
            <p class="contact-info">Contact: 987654321<br>Email: piyame04@gmail.com</p>
            <div class="cardbuttons">
                <a href=""><i class="ri-instagram-line"></i></a>
                <a href=""><i class="ri-facebook-fill"></i></a>
                <a href=""><i class="ri-linkedin-fill"></i></a>
            </div>
        </div>
    </section>
</body>
</html>
