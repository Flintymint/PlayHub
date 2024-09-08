<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>

<style>

	.main_content {
		background-color:#ffffff;
            max-width: 800px;
            margin: 0 auto;
            background-color: #fff;
            padding: 40px;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
     }
    .product_list_box {
         max-width: 1200px;
            margin: 0 auto;
            margin-left: 300px;
            margin-top: 40px;
            background-color: #fff;
            padding: 40px;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
    }

    .product_list {
        width: 100%;
        border-collapse: collapse;
        border-radius: 8px;
        overflow: hidden;
        box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        background-color: #fff;
    }

    .product_list th,
    .product_list td {
        padding: 12px 15px;
        text-align: left;
    }

    .product_list th {
        background-color: #6c63ff;
        color: #fff;
        font-weight: bold;
    }

    .product_list tr:nth-child(even) {
        background-color: #f8f8f8;
    }

    .product_list tr:hover {
        background-color: #f0f0f0;
    }

    .btn,
    .btn2 {
        display: inline-block;
        padding: 8px 16px;
        font-size: 14px;
        font-weight: bold;
        text-align: center;
        text-decoration: none;
        border-radius: 4px;
        transition: background-color 0.3s ease;
        margin-right: 5px;
    }

    .btn {
        background-color: #6c63ff;
        color: #fff;
        border: none;
    }

    .btn:hover {
        background-color: #5a4fec;
    }

    .btn2 {
        background-color: #dc3545;
        color: #fff;
        border: none;
    }

    .btn2:hover {
        background-color: #c82333;
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
        
</style>
    <%@include file="header.jsp"%>
    
    

<section class="content">
<div class="sidebar">
 <div class="sidebar-content">
        <a href="admin.jsp" class="btn">Manage Products</a>
        <a href="orderList.jsp" class="btn">View Orders</a>
        <a href="productAction.jsp" class="btn active">Update/Delete</a>
    </div>
</div>    
<div class="product_list_box">
    <!-- Establish database connection -->
    <sql:setDataSource var="dbConnection" driver="com.mysql.jdbc.Driver" url="jdbc:mysql://localhost:3306/playzone" user="root" password=""/>
    <!-- Retrieve all products from the database -->
    <sql:query var="allProduct" dataSource="${dbConnection}">
        SELECT id, productName, productCategory, productBrand, productPrice, productImage, stockLeft FROM product;
    </sql:query>
	<!-- Product Table -->
    <table class="product_list">
        <thead>
        <!-- Table headers -->
            <tr>
                <th>Product Name</th>
                <th>Product Category</th>
                <th>Product Brand</th>
                <th>Product Price</th>
                <th>Stock Left</th>
                <th>Action</th>
            </tr>
        </thead>
        <!-- Iterate over each product and display in table rows -->
        <c:forEach var="product" items="${allProduct.rows}">
            <tr>
            	<!-- Display product details in table cells -->
                <td>${product.productName}</td>
                <td>${product.productCategory}</td>
                <td>${product.productBrand}</td>
                <td>${product.productPrice}</td>
                <td>${product.stockLeft}</td>
                <td>
                	<!-- Form to edit product -->
                    <form action="<%=request.getContextPath()%>/pages/UpdateProduct.jsp" method="Get" style="display: inline-block;">
                        <input type="hidden" name="id" value="${product.id}" />
                        <button type="submit" class="btn">Edit</button>
                    </form>
                    <!-- Form to delete product -->
                    <form action="<%=request.getContextPath()%>/DeleteProds" method="post" style="display: inline-block;">
                        <input type="hidden" name="id" value="${product.id}" />
                        <button type="submit" class="btn2">Delete</button>
                    </form>
                </td>
            </tr>
        </c:forEach>
    </table>
</div>
</section>