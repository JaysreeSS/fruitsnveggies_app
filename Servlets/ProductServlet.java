package servlets;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import db.DBConnection;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class ProductServlet extends HttpServlet {
    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();
        
        try {
            Connection con = DBConnection.getConnection();
            PreparedStatement ps = con.prepareStatement("SELECT * FROM products");
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                out.println("<div>");
                out.println("<h3>" + rs.getString("name") + "</h3>");
                out.println("<p>Price: ₹" + rs.getDouble("price") + "</p>");
                out.println("<form action='CartServlet' method='post'>");
                out.println("<input type='hidden' name='product_id' value='" + rs.getInt("id") + "'>");
                out.println("<input type='submit' value='Add to Cart'>");
                out.println("</form>");
                out.println("</div>");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
