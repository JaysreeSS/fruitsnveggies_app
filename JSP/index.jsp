<%@page import="db.DBConnection"%>
<%@ page import="java.sql.*, java.util.*, jakarta.servlet.http.*" %>
<%@ include file="header.jsp" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Fruits & Veggies Shop</title>
    <link rel="stylesheet" href="styles.css">
</head>
<body>
    <div class="container">
        <h2>Welcome to Fruits & Veggies Shop</h2>

        <br><h3>FRUITS</h3>
        <div class="product-container">
            <%
                Connection con = DBConnection.getConnection();
                PreparedStatement ps = con.prepareStatement("SELECT * FROM products WHERE category='Fruit'");
                ResultSet rs = ps.executeQuery();
                HttpSession sessionCart = request.getSession();
                HashMap<Integer, Integer> cart = (HashMap<Integer, Integer>) sessionCart.getAttribute("cart");
                if (cart == null) {
                    cart = new HashMap<>();
                }
                while (rs.next()) {
                    int productId = rs.getInt("id");
            %>
                <div class="product-card">
                    <h4><%= rs.getString("name") %></h4>
                    <p>Price: Rs. <%= rs.getDouble("price") %></p>

                    <% if (cart.containsKey(productId)) { %>
                        <form action="CartServlet" method="post">
                            <input type="hidden" name="product_id" value="<%= productId %>">
                            <div class="quantity-selector">
                            <button type="submit" name="action" value="decrease">-</button>
                            <span><%= cart.get(productId) %></span>
                            <button type="submit" name="action" value="increase">+</button>
                            </div>
                        </form>
                    <% } else { %>
                        <form action="CartServlet" method="post">
                            <input type="hidden" name="product_id" value="<%= productId %>">
                            <button type="submit" name="action" value="add">Add to Cart</button>
                        </form>
                    <% } %>
                </div>
            <% } %>
        </div>

        <br><h3>VEGETABLES</h3>
        <div class="product-container">
            <%
                ps = con.prepareStatement("SELECT * FROM products WHERE category='Vegetable'");
                rs = ps.executeQuery();
                while (rs.next()) {
                    int productId = rs.getInt("id");
            %>
                <div class="product-card">
                    <h4><%= rs.getString("name") %></h4>
                    <p>Price: Rs. <%= rs.getDouble("price") %></p>

                    <% if (cart.containsKey(productId)) { %>
                        <form action="CartServlet" method="post">
                            <input type="hidden" name="product_id" value="<%= productId %>">
                            <div class="quantity-selector">
                            <button type="submit" name="action" value="decrease">-</button>
                            <span><%= cart.get(productId) %></span>
                            <button type="submit" name="action" value="increase">+</button>
                            </div>
                        </form>
                    <% } else { %>
                        <form action="CartServlet" method="post">
                            <input type="hidden" name="product_id" value="<%= productId %>">
                            <button type="submit" name="action" value="add">Add to Cart</button>
                        </form>
                    <% } %>
                </div>
            <% } %>
        </div>
    </div>

    <%-- Floating View Cart Button --%>
    <% if (!cart.isEmpty()) { %>
        <br><a href="cart.jsp" class="floating-cart">View Cart (<%= cart.size() %>)</a><br>
    <% } %>

</body>
</html>

<%@ include file="footer.jsp" %>
