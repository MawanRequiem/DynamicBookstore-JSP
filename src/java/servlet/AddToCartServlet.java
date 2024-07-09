package servlet;

import db.db;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet(name = "AddToCartServlet", urlPatterns = {"/AddToCartServlet"})
public class AddToCartServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet AddToCartServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet AddToCartServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
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
        response.setContentType("application/json");
        PrintWriter out = response.getWriter();
        
        // Retrieve book details from request parameters
        String bookId = request.getParameter("bookId");
        String bookTitle = request.getParameter("bookTitle");

        // Retrieve user session and user ID
        HttpSession session = request.getSession();
        String userId = (String) session.getAttribute("userId");

        if (userId == null) {
            // User is not logged in
            out.write("{\"status\":\"error\", \"message\":\"User is not logged in.\"}");
            return;
        }

        // Database connection
        Connection conn = null;
        PreparedStatement pstmt = null;

        try {
            conn = new db().setConnection();
            String sql = "INSERT INTO cart (userId, bookId, bookTitle) VALUES (?, ?, ?)";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, userId);
            pstmt.setString(2, bookId);
            pstmt.setString(3, bookTitle);

            int rowsAffected = pstmt.executeUpdate();

            if (rowsAffected > 0) {
                out.write("{\"status\":\"success\", \"message\":\"Book added to cart.\"}");
            } else {
                out.write("{\"status\":\"error\", \"message\":\"Failed to add book to cart.\"}");
            }

        } catch (SQLException e) {
            e.printStackTrace();
            out.write("{\"status\":\"error\", \"message\":\"Database error: " + e.getMessage() + "\"}");
        } finally {
            if (pstmt != null) {
                try {
                    pstmt.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
            if (conn != null) {
                try {
                    conn.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }
    }

    @Override
    public String getServletInfo() {
        return "AddToCartServlet";
    }
}
