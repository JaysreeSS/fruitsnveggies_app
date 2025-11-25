<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>REGISTER</title>
<link rel="stylesheet" href="styles.css">
</head>
<body>
<h3>REGISTER</h3>
<form action="RegisterServlet" method="post">
    Name: <input type="text" name="name" required><br>
    Email: <input type="email" name="email" required><br>
    Password: <input type="password" name="password" required><br>
    <input type="submit" value="Register"><br>
    <a href=index.jsp>Home</a>
</form>
</body>
</html>
