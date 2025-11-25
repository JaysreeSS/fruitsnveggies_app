<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="jakarta.servlet.http.HttpSession" %>
<%
    HttpSession userSession = request.getSession(false);
    String userEmail = (userSession != null) ? (String) userSession.getAttribute("user") : null;
    String userName = (String) userSession.getAttribute("name");
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Fruits & Veggies Shop</title>
    <link rel="stylesheet" href="styles.css">
</head>
<body>
    <header>
        <nav>
            <ul>
                <li><a href="index.jsp">Home</a></li>
                <li><a href="cart.jsp">Cart</a></li>
                <%
                    if (userEmail == null) {
                %>
                    <li><a href="login.jsp">Login</a></li>
                    <li><a href="register.jsp">Register</a></li>
                <%
                    } else {
                %>
                    <li>Welcome, <%= userName %>!</li>
                    <li><a href="LogoutServlet">Logout</a></li>
                <%
                    }
                %>
            </ul>
        </nav>
    </header>
