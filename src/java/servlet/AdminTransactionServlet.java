package servlet;

import controller.adminTransactionDAO;
import controller.adminTransactionDAO;
import model.transaksiBeans;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "AdminTransactionServlet", urlPatterns = {"/AdminTransactionServlet"})
public class AdminTransactionServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        adminTransactionDAO adminTransactionDAO = new adminTransactionDAO();
        List<transaksiBeans> transaksiList = adminTransactionDAO.getAllTransaksi();
        request.setAttribute("transaksiList", transaksiList);
        request.getRequestDispatcher("adminRiwayatTransaksi.jsp").forward(request, response);
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
        return "Servlet that handles admin requests to view all transactions";
    }
}
