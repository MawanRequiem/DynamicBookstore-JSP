package Servlet;

import controller.TransactionDAO;
import model.transaksiBeans;

import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * TranshistoryServlet for handling transaction history requests.
 */
@WebServlet(name = "TranshistoryServlet", urlPatterns = {"/TranshistoryServlet"})
public class TranshistoryServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        String username = (String) session.getAttribute("uName");
        if (username == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        TransactionDAO transaksiDAO = new TransactionDAO();
        List<transaksiBeans> transaksiList = transaksiDAO.getTransaksiByUsername(username);

        request.setAttribute("transaksiList", transaksiList);
        request.getRequestDispatcher("transhistory.jsp").forward(request, response);
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
        return "TranshistoryServlet for handling transaction history requests.";
    }
}