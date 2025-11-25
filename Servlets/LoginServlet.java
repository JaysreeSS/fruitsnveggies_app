package servlets;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import db.DBConnection;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

public class LoginServlet extends HttpServlet {
    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String email = request.getParameter("email");
        String password = request.getParameter("password");

        try {
            Connection con = DBConnection.getConnection();
            PreparedStatement ps = con.prepareStatement("SELECT * FROM users WHERE email=? AND password=?");
            ps.setString(1, email);
            ps.setString(2, password);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
            	int userId = rs.getInt("id");
            	String name = rs.getString("name");
                HttpSession session = request.getSession();
                session.setAttribute("user_id", userId);
                session.setAttribute("name", name);
                session.setAttribute("user", email);
                response.sendRedirect("index.jsp");
            } else {
                response.sendRedirect("login.jsp?msg=Invalid username or password");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
