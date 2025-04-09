<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>LOGIN</title>
<link rel="stylesheet" href="styles.css">
</head>
<body>
<h3>LOGIN</h3>
<form action="LoginServlet" method="post">
    Email: <input type="email" name="email" required><br>
    Password: <input type="password" name="password" required><br>
    <input type="submit" value="Login"><br><br>
    <a href=register.jsp>New User?</a><br><br>
    <a href=index.jsp>Home</a>
</form>
<% if (request.getParameter("msg") != null) { %>
<h4> <%= request.getParameter("msg") %> </h4>
<% } %>
</body>
</html>