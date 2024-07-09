package servlet;

import controller.CartDAO;
import model.cartBeans;
import controller.BookDAO;
import model.bookBeans;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.SQLException;

/**
 * Servlet implementation class RemoveFromCartServlet
 */
@WebServlet("/RemoveFromCartServlet")
public class RemoveFromCartServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String cartIdParam = request.getParameter("cartId");

        if (cartIdParam == null || cartIdParam.isEmpty()) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Missing cartId parameter");
            return;
        }

        int cartId = Integer.parseInt(cartIdParam);
        CartDAO cartDAO = new CartDAO();

        try {
            cartDAO.deleteCartItem(cartId);
            response.setStatus(HttpServletResponse.SC_OK);
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "An error occurred while removing item from cart.");
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doPost(request, response);
    }

    @Override
    public String getServletInfo() {
        return "RemoveFromCartServlet for handling removing books from the cart.";
    }
}
