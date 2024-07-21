package servlet;

import controller.CartDAO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;

@WebServlet(name = "UpdateCartServlet", urlPatterns = {"/UpdateCartServlet"})
public class UpdateCartItemServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // You may not need to implement anything here for this servlet
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String cartIdParam = request.getParameter("cartId");
        String quantityParam = request.getParameter("quantity");

        if (cartIdParam == null || cartIdParam.isEmpty() ||
            quantityParam == null || quantityParam.isEmpty()) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Missing parameters");
            return;
        }

        int cartId = Integer.parseInt(cartIdParam);
        int quantity = Integer.parseInt(quantityParam);

        CartDAO cartDAO = new CartDAO();
        try {
            if (quantity > 0) {
                cartDAO.updateCartItem(cartId, quantity);
            } else {
                cartDAO.deleteCartItem(cartId);
            }
            response.sendRedirect("cart.jsp");
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "An error occurred while updating the cart item.");
        }
    }

    private void updateCartItem(HttpServletRequest request, HttpServletResponse response, CartDAO cartDAO) throws SQLException, IOException {
        String cartIdParam = request.getParameter("cartId");
        String quantityParam = request.getParameter("quantity");

        if (cartIdParam == null || cartIdParam.isEmpty() || quantityParam == null || quantityParam.isEmpty()) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Missing parameters");
            return;
        }

        int cartId = Integer.parseInt(cartIdParam);
        int quantity = Integer.parseInt(quantityParam);

        cartDAO.updateCartItem(cartId, quantity);
        response.sendRedirect("cart.jsp");
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Update Cart Servlet";
    }
}
