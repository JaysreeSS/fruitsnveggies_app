<%@page import="db.DBConnection"%>
<%@ page import="java.sql.*, java.util.*, jakarta.servlet.http.*" %>
<%@ include file="header.jsp" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Shopping Cart</title>
    <link rel="stylesheet" href="styles.css">
</head>
<body>

    <div class="container">
        <h2>Your Shopping Cart</h2>

        <%
            HttpSession sessionCart = request.getSession();
            HashMap<Integer, Integer> cart = (HashMap<Integer, Integer>) sessionCart.getAttribute("cart");

            if (cart == null || cart.isEmpty()) {
        %>
            <p>Your cart is empty.</p>
            <a href="index.jsp" class="link-button">Continue Shopping</a>
        <%
            } else {
                Connection con = DBConnection.getConnection();
                double totalPrice = 0.0;
        %>

        <table class="cart-table">
            <thead>
                <tr>
                    <th>Product</th>
                    <th>Price</th>
                    <th>Quantity</th>
                    <th>Total</th>
                    <th>Action</th>
                </tr>
            </thead>
            <tbody>
                <%
                    for (Map.Entry<Integer, Integer> entry : cart.entrySet()) {
                        int productId = entry.getKey();
                        int quantity = entry.getValue();

                        PreparedStatement ps = con.prepareStatement("SELECT * FROM products WHERE id=?");
                        ps.setInt(1, productId);
                        ResultSet rs = ps.executeQuery();

                        if (rs.next()) {
                            String productName = rs.getString("name");
                            double price = rs.getDouble("price");
                            double productTotal = price * quantity;
                            totalPrice += productTotal;
                %>
                    <tr>
                        <td><%= productName %></td>
                        <td>Rs. <%= price %></td>
                        <td>
                            <form action="CartServlet" method="post">
                                <input type="hidden" name="product_id" value="<%= productId %>">
                                <div class="quantity-selector">
                                <button type="submit" name="action" value="decrease">-</button>
                                <span><%= quantity %></span>
                                <button type="submit" name="action" value="increase">+</button>
                                </div>
                            </form>
                        </td>
                        <td>Rs. <%= productTotal %></td>
                        <td>
                            <form action="CartServlet" method="post">
                                <input type="hidden" name="product_id" value="<%= productId %>">
                                <button type="submit" name="action" value="remove">Remove</button>
                            </form>
                        </td>
                    </tr>
                <% 
                        }
                    }
                %>
            </tbody>
        </table>

        <br><h3>Total: Rs. <%= totalPrice %></h3><br>

        <a href="index.jsp" class="link-button">Continue Shopping</a>&emsp;
        <a href="checkout.jsp" class="link-button checkout-btn">Proceed to Checkout</a><br>

        <%
            }
        %>
    </div>

</body>
</html>

<%@ include file="footer.jsp" %>
