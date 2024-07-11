package servlet;

import controller.adminTransactionDAO;
import model.transaksiBeans;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.InputStream;
import java.util.List;

@WebServlet(name = "AdminTransactionServlet", urlPatterns = {"/AdminTransactionServlet"})
public class AdminTransactionServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        
        if (action != null && action.equals("updatePaymentStatus")) {
            updatePaymentStatus(request, response);
        } else if (action != null && action.equals("DisplayPaymentProof")) {
            displayPaymentProof(request, response);
        } else {
            viewAllTransactions(request, response);
        }
    }

    private void viewAllTransactions(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        adminTransactionDAO adminTransactionDAO = new adminTransactionDAO();
        List<transaksiBeans> transaksiList = adminTransactionDAO.getAllTransaksi();
        request.setAttribute("transaksiList", transaksiList);
        request.getRequestDispatcher("adminRiwayatTransaksi.jsp").forward(request, response);
    }

    private void updatePaymentStatus(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String orderId = request.getParameter("orderId");
        String paymentStatus = request.getParameter("paymentStatus");

        adminTransactionDAO dao = new adminTransactionDAO();
        boolean statusUpdated = dao.updateStatus(Integer.parseInt(orderId), paymentStatus);

        if (statusUpdated) {
            response.sendRedirect("AdminTransactionServlet");
        } else {
            response.getWriter().write("Failed to update payment status.");
        }
    }

    private void displayPaymentProof(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int orderId = Integer.parseInt(request.getParameter("orderId"));
        adminTransactionDAO dao = new adminTransactionDAO();
        InputStream paymentProof = dao.getPaymentProof(orderId);

        if (paymentProof != null) {
            response.setContentType("image/jpeg");
            byte[] buffer = new byte[1024];
            int bytesRead;
            while ((bytesRead = paymentProof.read(buffer)) != -1) {
                response.getOutputStream().write(buffer, 0, bytesRead);
            }
        } else {
            response.sendError(HttpServletResponse.SC_NOT_FOUND); // 404 if no image found
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
        return "Servlet that handles admin requests to view all transactions and update payment status";
    }
}
