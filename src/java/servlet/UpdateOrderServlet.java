package servlet;

import controller.TransactionDAO;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(name = "UpdateOrderServlet", urlPatterns = {"/UpdateOrderServlet"})
public class UpdateOrderServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String orderIdStr = request.getParameter("orderId");
        String status = request.getParameter("status");

        if (orderIdStr == null || status == null) {
            response.getWriter().write("error:Missing order ID or status.");
            return;
        }

        int orderId = Integer.parseInt(orderIdStr);

        TransactionDAO transaksiDAO = new TransactionDAO();
        boolean updateStatus = transaksiDAO.updateStatus(orderId, status);

        if (updateStatus) {
            response.getWriter().write("success:Order status updated successfully.");
        } else {
            response.getWriter().write("error:Failed to update order status.");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "UpdateOrderServlet for handling order status updates.";
    }
}
