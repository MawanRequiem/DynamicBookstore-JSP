package servlet;

import controller.TransactionDAO;
import java.io.IOException;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "UpdateOrderStatusServlet", urlPatterns = {"/UpdateOrderStatusServlet"})
public class UpdateOrderStatusServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {
        int orderId = Integer.parseInt(request.getParameter("orderId"));
        String newStatus = request.getParameter("status");

        TransactionDAO transaksiDAO = new TransactionDAO();
        boolean updateStatus = transaksiDAO.updateStatus(orderId, newStatus);

        if (updateStatus) {
            if ("gagal".equals(newStatus)) {
                transaksiDAO.returnStock(orderId); // Method to return stock to inventory
            }
            response.getWriter().write("success:Order status updated successfully.");
        } else {
            response.getWriter().write("error:Failed to update order status.");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            processRequest(request, response);
        } catch (SQLException ex) {
            Logger.getLogger(UpdateOrderStatusServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            processRequest(request, response);
        } catch (SQLException ex) {
            Logger.getLogger(UpdateOrderStatusServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    @Override
    public String getServletInfo() {
        return "UpdateOrderStatusServlet for handling order status updates.";
    }
}
