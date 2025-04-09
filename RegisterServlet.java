package servlets;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import db.DBConnection;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class RegisterServlet extends HttpServlet {
    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            Connection con = DBConnection.getConnection();
            PreparedStatement ps = con.prepareStatement("INSERT INTO users(name, email, password) VALUES(?, ?, ?)");
            ps.setString(1, request.getParameter("name"));
            ps.setString(2, request.getParameter("email"));
            ps.setString(3, request.getParameter("password"));
            ps.executeUpdate();
            response.sendRedirect("login.jsp?msg=registered");
        } catch (Exception e) { e.printStackTrace(); }
    }
}
