// searchServlet.java
package servlet;

import controller.BookDAO;
import model.bookBeans;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

@WebServlet(name = "searchServlet", urlPatterns = {"/searchServlet"})
public class searchServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String query = request.getParameter("query");
        String action = request.getParameter("action");

        BookDAO bookDAO = new BookDAO();
        List<bookBeans> searchResults = null;

        if ("suggest".equals(action)) {
            searchResults = bookDAO.searchBooksStartingWith(query);
        } else {
            searchResults = bookDAO.searchBooks(query); // Use the existing search method for full search
        }

        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            if ("suggest".equals(action)) {
                for (bookBeans book : searchResults) {
                    out.println("<div class='suggestion-item' onclick='selectSuggestion(\"" + book.getNama() + "\")'>" + book.getNama() + "</div>");
                }
            } else {
                request.setAttribute("searchResults", searchResults);
                request.getRequestDispatcher("searchResult.jsp").forward(request, response);
            }
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
        return "Search Servlet";
    }
}