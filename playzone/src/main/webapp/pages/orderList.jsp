<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE html>
<!--Including the core tag library-->
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!--Including the formatting tag library-->
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!--Including the SQL tag library-->
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ page import="Model.User.User"%>
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
<title>Order Summary</title>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;500;600;700&display=swap" rel="stylesheet">
<style>
    /* General Styles */
    body {
        font-family: 'Poppins', sans-serif;
        margin: 0;
        padding: 0;
        background-color: #fff;
    }

    .content {
        display: flex;
        padding: 40px;
        background-color: #fff;
    }

    /* Button Styles */
    .btn {
        background-color: #6c63ff;
        color: #fff;
        border: none;
    }
    .btn,
    .btn2 {
        display: inline-block;
        padding: 8px 16px;
        font-size: 16px;
        font-weight: bold;
        text-align: center;
        text-decoration: none;
        border-radius: 4px;
        transition: background-color 0.3s ease;
        margin-right: 5px;
    }

    .btn:hover {
        background-color: #5a4fec;
    }
    
   /* Sidebar styles */
    .sidebar {
        position: absolute;
        top: 160px; 
        left: 20px;
        height: 190px;
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

    /* Table Styles */
    .order_list {
        width: 100%;
        border-collapse: collapse;
        border-radius: 8px;
        overflow: hidden;
        box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        background-color: #fff;
    }

    .order_list th,
    .order_list td {
        padding: 12px 15px;
        text-align: left;
    }

    .order_list th {
        background-color: #6c63ff;
        color: #fff;
        font-weight: bold;
    }

    .order_list tr:nth-child(even) {
        background-color: #f8f8f8;
    }

    .order_list tr:hover {
        background-color: #f0f0f0;
    }

    .order_list td img {
        max-width: 80px;
        height: auto;
        border-radius: 4px;
    }

    /* Container Styles */
    .main_content2 {
        max-width: 900px;
        margin: 0 auto;
        background-color: #fff;
        padding: 20px;
        border-radius: 8px;
        box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
    }
</style>
</head>
<body>
<%@include file="header.jsp"%>
<!-- Establish database connection -->
<sql:setDataSource var="dbConnection" driver="com.mysql.jdbc.Driver" url="jdbc:mysql://localhost:3306/playzone" user="root" password="" />
<!-- Retrieve all orders from the database -->
<sql:query var="allProduct" dataSource="${dbConnection}">
    SELECT u.FirstName, o.UserEmail, p.ProductName, p.productImage, COUNT(*) AS ProductsOrdered
    FROM `Order` o
    INNER JOIN users u ON u.Email COLLATE utf8mb4_general_ci = o.UserEmail
    INNER JOIN product p ON p.id = o.id
    GROUP BY o.UserEmail, u.FirstName, p.ProductName, p.productImage;
</sql:query>

<!--This is the section of the webpage that contains all of the main content-->
<section class="content">
    <div class="sidebar">
        <a href="admin.jsp" class="btn">Manage Products</a>
        <a href="orderList.jsp" class="btn active">View Orders</a>
        <a href="productAction.jsp" class="btn">Update/Delete</a>
    </div>
    
    <div class="main_content2">
        <!-- Order List -->
        <div class="order_list_box">
            <table class="order_list">
                <thead>
                <!-- Table headers -->
                    <tr>
                        <th>Customer Name</th>
                        <th>Customer Email</th>
                        <th>Product Name</th>
                        <th>Product Image</th>
                        <th>Products Ordered</th>
                    </tr>
                </thead>
                <!-- Iterating over each row in the query result -->
                <c:forEach var="product" items="${allProduct.rows}">
                    <tr>
                        <td>${product.FirstName}</td>
                        <td>${product.UserEmail}</td>
                        <td>${product.ProductName}</td>
                        <!-- Displaying product image -->
                        <td><img src="<%=request.getContextPath()%>/images/productfolder/${product.productImage}" alt="Product Image"></td>
                        <td>${product.ProductsOrdered}</td>
                    </tr>
                </c:forEach>
            </table>
        </div>
    </div>
</section>
</body>
</html>
