package servlet;

import controller.CheckoutDAO;
import controller.CartDAO;
import model.cartBeans;
import java.io.IOException;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.logging.Level;
import java.util.logging.Logger;

@WebServlet(name = "CheckoutServlet", urlPatterns = {"/CheckoutServlet"})
public class CheckoutServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private static final Logger LOGGER = Logger.getLogger(CheckoutServlet.class.getName());

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        String username = (String) session.getAttribute("uName");
        if (username == null) {
            session.setAttribute("message", "Please log in to proceed with the checkout.");
            response.sendRedirect("login.jsp");
            return;
        }

        String[] selectedItemsParam = request.getParameterValues("selectedItems");
        if (selectedItemsParam == null || selectedItemsParam.length == 0) {
            session.setAttribute("message", "No items selected for checkout.");
            response.sendRedirect("cart.jsp");
            return;
        }

        Map<Integer, Integer> selectedItemQuantities = new HashMap<>();
        double totalPrice = 0.0;
        List<Integer> selectedItemIds = new ArrayList<>();
        CartDAO cartDAO = new CartDAO();
        for (String itemId : selectedItemsParam) {
            String[] idStrings = itemId.split(",");
            for (String idString : idStrings) {
                try {
                    int id = Integer.parseInt(idString.trim());
                    cartBeans item = cartDAO.getCartItemById(id);
                    if (item != null) {
                        selectedItemQuantities.put(item.getBookId(), item.getQuantity());
                        totalPrice += item.getBookPrice() * item.getQuantity();
                        selectedItemIds.add(item.getId()); // Store the item ID for deletion
                        LOGGER.log(Level.INFO, "Adding item to order: Book ID {0}, Quantity {1}", new Object[]{item.getBookId(), item.getQuantity()});
                    }
                } catch (SQLException e) {
                    e.printStackTrace();
                    session.setAttribute("message", "An error occurred while fetching cart items. Please try again.");
                    response.sendRedirect("error.jsp");
                    return;
                }
            }
        }

        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String address = request.getParameter("address");
        String city = request.getParameter("city");
        String postalCode = request.getParameter("postalCode");
        String paymentMethod = request.getParameter("paymentMethod");

        CheckoutDAO checkoutDAO = new CheckoutDAO();

        // Set expiry time to 2 minutes from now
        Calendar calendar = Calendar.getInstance();
        calendar.add(Calendar.MINUTE, 2);
        Timestamp expiryTime = new Timestamp(calendar.getTimeInMillis());
        boolean orderPlaced;
        try {
            int userId = cartDAO.getUserIdByUsername(username);
            orderPlaced = checkoutDAO.placeOrder(userId, name, email, address, city, postalCode, totalPrice, paymentMethod, selectedItemQuantities, expiryTime);
        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("message", "An error occurred while processing your order. Please try again.");
            response.sendRedirect("error.jsp");
            return;
        }

        if (orderPlaced) {
            try {
                cartDAO.clearSelectedItems(selectedItemIds);
            } catch (SQLException e) {
                e.printStackTrace();
                session.setAttribute("message", "Order placed, but failed to clear the selected items from the cart.");
                response.sendRedirect("checkout.jsp");
                return;
            }
            session.setAttribute("message", "Your order has been successfully placed!");
        } else {
            session.setAttribute("message", "There was an issue with your order. Please try again.");
        }
        response.sendRedirect("TranshistoryServlet");
    }
}
