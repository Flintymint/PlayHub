<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="Model.User.User" %>
<%
User admin = (User) session.getAttribute("User");
if (admin == null || !admin.getEmailAddress().equals("admin@gmail.com")) {
    response.sendRedirect("../login.jsp");
}

int id = Integer.parseInt(request.getParameter("id"));
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Edit Product</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Open+Sans:wght@300;400;600;700&display=swap" rel="stylesheet">
    <style>
        body {
            font-family: 'Open Sans', sans-serif;
            background-color: #f5f5f5;
            color: #333;
        }

        .content {
            padding: 40px;
        }

        .main_content {
            background-color: #fff;
            max-width: 600px;
            margin: 0 auto;
            padding: 40px;
            border-radius: 8px;
            box-shadow: 0 2px 6px rgba(0, 0, 0, 0.1);
        }

        .product_form_box h3 {
            font-size: 24px;
            font-weight: 700;
            margin-bottom: 20px;
            text-align: center;
        }

        .product_form_box form .box {
            width: 100%;
            padding: 12px;
            margin: 8px 0;
            border: 1px solid #ddd;
            border-radius: 4px;
            box-sizing: border-box;
            font-size: 16px;
        }

        .btn {
            background-color: #6c63ff;
            color: #fff;
            padding: 12px 24px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 16px;
            transition: background-color 0.3s ease;
        }

        .btn:hover {
            background-color: #5a4fec;
        }

        .btn3 {
            background-color: #e0e0e0;
            color: #333;
            padding: 12px 24px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 16px;
            text-decoration: none;
            transition: background-color 0.3s ease;
        }

        .btn3:hover {
            background-color: #d0d0d0;
        }
    </style>
</head>
<body>
    <%@include file="header.jsp" %>

    <!-- This is the section of the webpage that contains all of the main content -->
    <section class="content">
        <div class="main_content">
        	<!-- Form for editing product details -->
            <div class="product_form_box">
                <h3>Edit Product Details</h3>
                <form name="product_form" action="<%=request.getContextPath()%>/UpdateProduct" method="post" enctype="multipart/form-data">
                    <!-- Input fields for new product details -->
                    <input type="text" placeholder="Enter new product name" name="product_name" class="box" required>
                    <input type="text" placeholder="Enter new product category" name="product_category" class="box" required>
                    <input type="text" placeholder="Enter new brand name" name="brand_name" class="box" required>
                    <input type="number" placeholder="Enter new price" name="product_price" class="box" required>
                    <input type="text" placeholder="Enter stock left" name="stockLeft" class="box" required>
                    <input type="file" accept="image/png, image/jpeg, image/jpg" name="product_image" class="box">
                    <!-- Hidden field for product ID -->
                    <input type="hidden" name="id" value="<%=id%>" />
                    <!-- Button to submit form for editing product -->
                    <input type="submit" class="btn" name="edit_product" value="Edit Product">
                    <!-- Button to return to admin page -->
                    <a href="productAction.jsp" class="btn3">Return</a>
                </form>
            </div>
        </div>
    </section>
</body>
</html>