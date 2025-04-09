package servlets;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.HashMap;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

public class CheckoutServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        HashMap<Integer, Integer> cart = (HashMap<Integer, Integer>) session.getAttribute("cart");
        Integer userId = (Integer) session.getAttribute("user_id"); // Retrieve user ID from session

        if (userId == null) {
            response.sendRedirect("login.jsp");
            return;
        }
        
        if (cart == null || cart.isEmpty()) {
        	response.sendRedirect("index.jsp");
            return;
        }

        double totalAmount = Double.parseDouble(request.getParameter("total_price"));
        String orderStatus = "Pending"; // Default status

        Connection con = db.DBConnection.getConnection();
        PreparedStatement psOrder = null;

        try {
            con.setAutoCommit(false); // Start transaction

            // Insert order details into orders table
            String orderQuery = "INSERT INTO orders (user_id, total_amount, status) VALUES (?, ?, ?)";
            psOrder = con.prepareStatement(orderQuery, Statement.RETURN_GENERATED_KEYS);
            psOrder.setInt(1, userId);
            psOrder.setDouble(2, totalAmount);
            psOrder.setString(3, orderStatus);
            psOrder.executeUpdate();

            con.commit(); // Commit transaction
            session.removeAttribute("cart"); // Clear cart after checkout

            response.sendRedirect("orderSuccess.jsp");
        } catch (SQLException e) {
            try {
                con.rollback(); // Rollback in case of failure
            } catch (SQLException rollbackEx) {
                rollbackEx.printStackTrace();
            }
            e.printStackTrace();
            response.sendRedirect("checkout.jsp?error=OrderFailed");
        } finally {
            try {
                if (psOrder != null) psOrder.close();
                con.setAutoCommit(true);
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}
