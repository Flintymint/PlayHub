<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@page import="Model.User.User" %>
<%@page import="Model.User.UserMessage" %>
<%@ page import="java.util.ArrayList" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Cart</title>
    <link rel="stylesheet" href="<%=request.getContextPath() %>/css/header.css"/>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;500;600;700&display=swap" rel="stylesheet">
    <style>
        body {
            font-family: 'Poppins', sans-serif;
            background-color: #000; /* Black background */
            color: #FFF; /* White text color */
            margin: 0;
            padding: 0;
        }

        .content {
            display: flex;
            justify-content: space-between;
            padding: 40px;
        }

        .cart-items {
            flex: 2;
            margin-right: 40px;
        }

        .cart-header {
            font-size: 36px;
            font-weight: 700;
            color: #FFF;
            margin-bottom: 40px;
        }

        .select-all {
            margin-bottom: 20px;
        }

        .select-all input[type="checkbox"] {
            margin-right: 10px;
        }

        .select-all label {
            font-size: 16px;
            font-weight: 500;
            color: #FFF;
        }

        .delete-btn {
            background-color: #ff2700d6;
            color: #FFF;
            border: none;
            border-radius: 4px;
            padding: 8px 16px;
            font-size: 14px;
            cursor: pointer;
            transition: background-color 0.3s ease;
            margin-left: 20px;
        }

        .delete-btn:hover {
            background-color: #FF4500;
        }

        .product {
            display: flex;
            align-items: center;
            margin-bottom: 20px;
            background-color: #FFF; /* White background for product cards */
            padding: 20px;
            border-radius: 4px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
            color: #000; /* Black text color for product cards */
        }

        .product input[type="checkbox"] {
            margin-right: 10px;
        }

        .product img {
            width: 100px;
            height: 100px;
            object-fit: cover;
            margin-right: 20px;
        }

        .product-details h4 {
            font-size: 18px;
            font-weight: 600;
            color: #000;
            margin-bottom: 10px;
        }

        .brand {
            font-size: 14px;
            color: #666; /* Grey for brand text */
            margin-bottom: 5px;
        }

        .price {
            font-size: 16px;
            font-weight: 600;
            color: #ff0000;
            margin-bottom: 10px;
        }

        .quantity {
            display: flex;
            align-items: center;
        }

        .quantity button {
            background-color: transparent;
            border: none;
            font-size: 18px;
            color: #000;
            cursor: pointer;
            padding: 0;
            margin: 0 5px;
        }

        .quantity input[type="text"] {
            width: 40px;
            padding: 4px;
            text-align: center;
            border: 1px solid #CCC;
            border-radius: 4px;
            font-size: 14px;
        }

        .delete-icon {
            color: #FF6347;
            font-size: 18px;
            cursor: pointer;
            margin-left: 20px;
        }

        .order-summary {
            padding: 20px;
            margin-top: 110px;
            border-radius: 4px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
            width: 300px;
            color: #FFF; /* White text color for order summary */
        }

        .order-summary h3 {
            font-size: 24px;
            font-weight: 600;
            color: #FFF;
            margin-bottom: 20px;
        }

        .order-summary p {
            font-size: 16px;
            color: #CCC;
            margin-bottom: 10px;
        }

        .total {
            font-size: 18px;
            font-weight: 600;
            color: #FFF;
            margin-bottom: 20px;
        }

        .total span {
            color: #FF8C00;
        }

        .checkout-btn {
            background-color: #0093ffc4;
            color: #FFF;
            border: none;
            border-radius: 4px;
            padding: 12px 24px;
            font-size: 18px;
            cursor: pointer;
            transition: background-color 0.3s ease;
            width: 100%;
        }

        .checkout-btn:hover {
            background-color: #34e845b8;
        }
    </style>
</head>

<body>
    <%@include file="header.jsp"%>

    <section class="content">
        <!-- Section for displaying cart items -->
        <div class="cart-items">
            <!-- Cart header -->
            <div class="cart-header">My Cart</div>
            
            <!-- Displaying any messages related to cart actions -->
            <%
            UserMessage msg = (UserMessage)session.getAttribute("Message");
            if (msg != null) {
            %>
            <div class="alert"><%=msg.getMessageContent() %></div>
            <%
                session.removeAttribute("Message");
            }
            %>
            
            <!-- Select all items checkbox and delete button -->
            <div class="select-all">
                <input type="checkbox" id="select-all">
                <label for="select-all">Select all items</label>
                <button class="delete-btn">Delete</button>
            </div>

            <!-- Iterating over each item in the cart -->
            <c:set var="totalPrice" value="0" />
            <c:forEach var="product" items="${cart}">
                <!-- Retrieving product information from the database -->
                <sql:setDataSource var="dbConnection" driver="com.mysql.jdbc.Driver" url="jdbc:mysql://localhost:3306/playzone" user="root" password=""/>
                <sql:query var="productInfo" dataSource="${dbConnection}">
                    SELECT productName, productCategory, productBrand, productPrice, stockLeft, productImage FROM product WHERE id = ${product};
                </sql:query>
                <!-- Displaying product details -->
                <c:forEach var="info" items="${productInfo.rows}">
                    <div class="product">
                        <input type="checkbox">
                        <!-- Displaying product image -->
                        <img src="<c:url value='/images/productfolder/${info.productImage}'/>" alt="${info.productName}">
                        <div class="product-details">
                            <!-- Product name, brand and price -->
                            <h4>${info.productName}</h4>
                            <p class="brand">${info.productBrand}</p>
                            <p class="price">NPR ${info.productPrice}</p>
                            <!-- Quantity control and delete button -->
                            <div class="quantity">
                                <button class="minus">-</button>
                                <input type="text" value="1">
                                <button class="plus">+</button>
                                <!-- Form for removing product from cart -->
                                <form action="<%=request.getContextPath()%>/RemoveCart" method="post">
                                    <input type="hidden" name="id" value="${product}">
                                    <button type="submit" class="delete-icon">Delete</button>
                                </form>
                            </div>
                        </div>
                    </div>
                    <!-- Updating total price -->
                    <c:set var="totalPrice" value="${totalPrice + info.productPrice}" />
                </c:forEach>
            </c:forEach>
        </div>

        <!-- Order summary section -->
        <div class="order-summary">
            <h3>Order Summary</h3>
            <!-- Displaying subtotal and total price -->
            <p>Subtotal (<c:out value="${fn:length(cart)}" /> items): Rs <c:out value="${totalPrice}" /></p>
            <!-- Total price -->
            <p class="total">Total: <span>Rs <c:out value="${totalPrice}" /></span></p>
            <!-- Form for proceeding to checkout -->
            <form action="<%=request.getContextPath()%>/Order" method="post">
                <input type="hidden" name="id" value="${product}" class="price">
                <input type="submit" name="Order" value="Proceed to Checkout" class="checkout-btn">
            </form>
        </div>
    </section>
</body>
</html>
