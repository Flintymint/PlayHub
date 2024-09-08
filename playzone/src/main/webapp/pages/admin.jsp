<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!-- Including the core tag library -->
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!-- Including the formatting tag library -->
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!-- Including the SQL tag library -->
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ page import="Model.User.User" %>
<!DOCTYPE html>
<%
User admin = (User)session.getAttribute("User");
if (admin == null || !admin.getEmailAddress().equals("admin@gmail.com")) {
    response.sendRedirect("../login.jsp");
}
%>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Admin Dashboard</title>
    <link rel="stylesheet" href="<%=request.getContextPath() %>/css/header.css"/>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;500;600;700&display=swap" rel="stylesheet">
    <style>
        /* General styles */
        body {
            font-family: 'Poppins', sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f5f5f5;
        }

        .content {
            display: flex;
            padding: 40px;
            background-color: #fff;
        }

        .main_content {
            flex: 1;
            background-color: #fff;
            padding: 40px;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            margin-left: 240px;
        }

        /* Button styles */
        .btn {
            display: inline-block;
            background-color: #000000;
            color: #fff;
            font-size: 16px;
            font-weight: 500;
            text-decoration: none;
            padding: 12px 24px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        .btn:hover {
            background-color: #376df8;
        }

        /* Form styles */
        .product_form_box form {
            max-width: 500px;
            margin: 0 auto;
        }

        .product_form_box form h3 {
            color: #333;
            font-weight: 700;
            margin-bottom: 30px;
            text-align: center;
            font-size: 24px;
        }

        .product_form_box form .box {
            width: 100%;
            padding: 12px 16px;
            font-size: 16px;
            border-radius: 5px;
            border: 1px solid #ccc;
            background-color: #f8f9fa;
            transition: border-color 0.3s ease;
            margin-bottom: 20px;
        }

        .product_form_box form .box:focus {
            outline: none;
            border-color: #6c63ff;
        }

        /* Table styles */
        .product_list_box {
            overflow-x: auto;
        }

        .product_list {
            width: 100%;
            border-collapse: collapse;
            border-radius: 8px;
            overflow: hidden;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        }

        .product_list th,
        .product_list td {
            padding: 15px;
            text-align: left;
        }

        .product_list th {
            background-color: #000000;
            color: #fff;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 1px;
        }

        .product_list tr:nth-child(even) {
            background-color: #f9f9f9;
        }

        .product_list tr:hover {
            background-color: #f5f5f5;
        }

        .product_list td img {
            max-width: 100px;
            height: auto;
            border-radius: 4px;
        }

        /* Sidebar styles */
        .sidebar {
            position: absolute;
            top: 160px; /* Adjust this value based on your navbar height */
            left: 20px;
            height: calc(100% - 60px); 
            width: 240px;
            background-color: #fff;
            padding-top: 20px;
            padding-right: 20px;
            border-radius: 4px;
            box-sizing: border-box;
            overflow-y: auto;
        }

        .sidebar .btn {
            display: block;
            margin-bottom: 10px;
            width: 80%;
            text-align: left;
            padding: 10px;
            color: #333;
            background-color: #fff;
            border: 1px solid #ddd;
            border-radius: 5px;
            transition: background-color 0.3s ease, color 0.3s ease;
        }

        .sidebar .btn:hover {
            background-color: #2f2f2f;
            color: #fff;
        }

        .sidebar .btn.active {
            background-color: #000000;
            color: #fff;
        }
    </style>
</head>

<body>
    <%@include file="header.jsp" %>

    <!-- Main content section -->
    <section class="content">
        <!-- Sidebar navigation links -->
        <div class="sidebar">
            <a href="admin.jsp" class="btn active">Manage Products</a>
            <a href="orderList.jsp" class="btn">View Orders</a>
            <a href="productAction.jsp" class="btn">Update/Delete</a>
        </div>
        
        <div class="main_content">
            <!-- Displaying the list of products -->
            <div class="product_list_box">
                <!-- Setting up data source for SQL -->
                <sql:setDataSource var="dbConnection" driver="com.mysql.jdbc.Driver" url="jdbc:mysql://localhost:3306/playzone" user="root" password=""/>
                <sql:query var="allProduct" dataSource="${dbConnection}">
                    SELECT id, productName, productCategory, productBrand, productPrice, productImage, stockLeft FROM product;
                </sql:query>

                <!-- Displaying product list in a table -->
                <table class="product_list">
                    <thead>
                        <tr>
                            <th>Product ID</th>
                            <th>Name</th>
                            <th>Category</th>
                            <th>Brand</th>
                            <th>Price</th>
                            <th>Image</th>
                            <th>Stock</th>
                        </tr>
                    </thead>
                    <tbody>
                        <!-- Iterating over each product and displaying its details -->
                        <c:forEach var="product" items="${allProduct.rows}">
                            <tr>
                                <td>${product.id}</td>
                                <td>${product.productName}</td>
                                <td>${product.productCategory}</td>
                                <td>${product.productBrand}</td>
                                <td>${product.productPrice}</td>
                                <td><img src="<%=request.getContextPath()%>/images/productfolder/${product.productImage}" alt="Product Image"></td>
                                <td>${product.stockLeft}</td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>

            <!-- Form for adding a new product -->
            <div class="product_form_box">
                <form name="product_form" action="<%=request.getContextPath() %>/ProductAdd" method="Post" enctype="multipart/form-data">
                    <!-- Form inputs for product details -->
                    <h3>Add Product</h3>
                    <input type="text" placeholder="Enter product name" name="product_name" class="box" required>
                    <input type="text" placeholder="Enter product category" name="product_category" class="box" required>
                    <input type="text" placeholder="Enter brand name" name="brand_name" class="box" required>
                    <input type="number" placeholder="Enter product price" name="product_price" class="box" required>
                    <input type="number" placeholder="Enter stock amount" name="stockLeft" class="box" required>
                    <input type="file" accept="image/png, image/jpeg, image/jpg" name="product_image" class="box" required>
                    <input type="submit" class="btn" name="add_product" value="Add Product">
                </form>
            </div>
        </div>
    </section>
</body>
</html>
