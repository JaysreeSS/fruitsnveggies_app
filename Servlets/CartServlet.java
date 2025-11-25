package servlets;

import java.io.IOException;
import java.util.HashMap;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

public class CartServlet extends HttpServlet {
    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	        HttpSession session = request.getSession();
	        HashMap<Integer, Integer> cart = (HashMap<Integer, Integer>) session.getAttribute("cart");

	        if (cart == null) {
	            cart = new HashMap<>();
	        }

	        int productId = Integer.parseInt(request.getParameter("product_id"));
	        String action = request.getParameter("action");

	        if ("add".equals(action)) {
	            cart.put(productId, 1);
	        } else if ("increase".equals(action)) {
	            cart.put(productId, cart.get(productId) + 1);
	        } else if ("decrease".equals(action)) {
	            int quantity = cart.get(productId);
	            if (quantity > 1) {
	                cart.put(productId, quantity - 1);
	            } else {
	                cart.remove(productId);
	            }
	        } else if ("remove".equals(action)) {
	            cart.remove(productId);
	        }

	        session.setAttribute("cart", cart);
	        response.sendRedirect("cart.jsp");
	    }
	}
