<%@page import="db.DBConnection"%>
<%@ page import="java.sql.*, java.util.*, jakarta.servlet.http.*" %>
<%@ include file="header.jsp" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Checkout</title>
    <link rel="stylesheet" href="styles.css">
</head>
<body>

    <div class="container">
        <h2>Checkout</h2>

        <%
            HttpSession sessionCart = request.getSession();
            HashMap<Integer, Integer> cart = (HashMap<Integer, Integer>) sessionCart.getAttribute("cart");

            if (cart == null || cart.isEmpty()) {
        %>
            <p>Your cart is empty. <a href="index.jsp">Continue Shopping</a></p>
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
                        <td><%= quantity %></td>
                        <td>Rs. <%= productTotal %></td>
                    </tr>
                <%
                        }
                    }
                %>
            </tbody>
        </table>

        <h4>Total Amount: Rs. <%= totalPrice %></h4><br>

        <h3>Billing Details</h3>
        <form action="CheckoutServlet" method="post">
            <label>Name:</label>
            <input type="text" name="name" required>

            <label>Address:</label>
            <textarea name="address" required></textarea>

            <label>Phone:</label>
            <input type="text" name="phone" required pattern="[0-9]{10}" title="Enter a valid 10-digit phone number">

            <input type="hidden" name="total_price" value="<%= totalPrice %>">

            <br><br><button type="submit">Place Order</button>
        </form>

        <a href="cart.jsp" class="link-button">Back to Cart</a><br>

        <%
            }
        %>
    </div>

</body>
</html>

<%@ include file="footer.jsp" %>
