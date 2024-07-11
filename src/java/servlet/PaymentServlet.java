package servlet;

import controller.TransactionDAO;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import java.io.IOException;
import java.io.InputStream;

@WebServlet(name = "PaymentServlet", urlPatterns = {"/PaymentServlet"})
@MultipartConfig
public class PaymentServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("application/json");
        String orderIdStr = request.getParameter("orderId");
        Part paymentProofPart = request.getPart("paymentProof");

        if (orderIdStr == null || paymentProofPart == null) {
            response.getWriter().write("{\"status\":\"error\",\"message\":\"Missing order ID or payment proof.\"}");
            return;
        }

        int orderId = Integer.parseInt(orderIdStr);

        // Read the payment proof image as an input stream
        InputStream paymentProofInputStream = paymentProofPart.getInputStream();

        TransactionDAO transaksiDAO = new TransactionDAO();
        boolean updateStatus = transaksiDAO.updatePaymentStatus(orderId, paymentProofInputStream);

        if (updateStatus) {
            response.getWriter().write("{\"status\":\"success\",\"message\":\"Payment updated successfully.\", \"orderId\":\"" + orderId + "\"}");
        } else {
            response.getWriter().write("{\"status\":\"error\",\"message\":\"Failed to update payment.\"}");
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
        return "PaymentServlet for handling payment submissions.";
    }
}
