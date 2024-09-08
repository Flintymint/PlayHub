<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="Model.User.User" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>User Profile - Purchase History</title>
    <link rel="stylesheet" href="<%=request.getContextPath() %>/css/header.css"/>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <style>
        /* CSS styles */
        body {
            font-family: 'Poppins', sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f5f5f5;
        }

        .content {
            padding: 40px;
        }

        .main_content {
            max-width: 1200px;
            margin: 0 auto;
            background-color: #fff;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            overflow: hidden;
        }

        .order_history_box {
            padding: 40px;
        }

        .order_list {
            width: 100%;
            border-collapse: collapse;
            border-radius: 8px;
            overflow: hidden;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        }

        .order_list th,
        .order_list td {
            padding: 15px;
            text-align: left;
        }

        .order_list th {
            background-color: #333;
            color: #fff;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 1px;
        }

        .order_list tr:nth-child(even) {
            background-color: #f9f9f9;
        }

        .order_list tr:hover {
            background-color: #f5f5f5;
        }

        .order_list td img {
            max-width: 100px;
            height: auto;
            border-radius: 4px;
        }
    </style>
</head>
<body>
    <%@include file="header.jsp" %>
    <%
    User user1 = (User)session.getAttribute("User");
    String email = null;
    if (user1 != null) {
        email = user1.getEmailAddress();
    }
    %>
    <sql:setDataSource var="dbConnection" driver="com.mysql.jdbc.Driver" url="jdbc:mysql://localhost:3306/playzone" user="root" password=""/>
    <sql:query var="allProduct" dataSource="${dbConnection}">
        SELECT `order`.`OrderId`, `order`.`id`, `order`.`UserName`, `order`.`UserEmail`, `order`.`Date`, `product`.`productName`, `product`.`productCategory`, `product`.`productImage`
        FROM `pixellab`.`order`
        INNER JOIN `pixellab`.`product` ON `order`.`id` = `product`.`id`
        WHERE `order`.`UserEmail` = ?
        <sql:param value="<%= email != null ? email : \"\" %>"/>
    </sql:query>

    <section class="content">
        <div class="main_content">
            <div class="order_history_box">
            	<!-- Order List -->
                <table class="order_list">
                    <thead>
                    <!-- Table headers -->
                        <tr>
                            <th>Order ID</th>
                            <th>Product ID</th>
                            <th>User Name</th>
                            <th>User Email</th>
                            <th>Order Date</th>
                            <th>Product Name</th>
                            <th>Product Category</th>
                            <th>Product Image</th>
                        </tr>
                    </thead>
                    <tbody>
                    	<!-- Iterate over each order and display details in table rows -->
                        <c:forEach var="product" items="${allProduct.rows}">
                            <tr>
                                <td>${product.OrderId}</td>
                                <td>${product.id}</td>
                                <td>${product.UserName}</td>
                                <td>${product.UserEmail}</td>
                                <td>${product.Date}</td>
                                <td>${product.productName}</td>
                                <td>${product.productCategory}</td>
                                <!-- Display product image -->
                                <td><img src="<%=request.getContextPath()%>/images/productfolder/${product.productImage}" alt="Product Image"></td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
    </section>
</body>
</html>