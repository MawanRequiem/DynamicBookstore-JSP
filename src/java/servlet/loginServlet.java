package servlet;

import db.db;
import model.loginBeans;
import java.sql.*;
import java.io.IOException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * LoginServlet for handling login requests.
 */
@WebServlet(name = "LoginServlet", urlPatterns = {"/loginServlet"})
public class loginServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
         // Create a new loginBeans object and set its properties from the request parameters
        loginBeans login = new loginBeans();
        login.setUsername(request.getParameter("username"));
        login.setPassword(request.getParameter("password"));

        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            conn = new db().setConnection();

            // Check if user is an admin
            String adminSql = "SELECT * FROM admin_db WHERE username=? AND password=?";
            ps = conn.prepareStatement(adminSql);
            ps.setString(1, login.getUsername());
            ps.setString(2, login.getPassword());

            rs = ps.executeQuery();
            if (rs.next()) {
                HttpSession session = request.getSession();
                session.setAttribute("user", login.getUsername());
                session.setAttribute("login", true);
                session.setAttribute("uName", login.getUsername());
       

                // Set loginSuccess attribute to true
                request.setAttribute("loginSuccess", true);

                // Forward to the admin page
                RequestDispatcher rd = request.getRequestDispatcher("admin.jsp");
                rd.forward(request, response);
            } 
            else {
                // Check if user is a regular user
                String userSql = "SELECT * FROM user_db WHERE username=? AND password=?";
                ps = conn.prepareStatement(userSql);
                ps.setString(1, login.getUsername());
                ps.setString(2, login.getPassword());

                rs = ps.executeQuery();
                if (rs.next()) {
                    HttpSession session = request.getSession();
                    session.setAttribute("user", login.getUsername());
                    session.setAttribute("login", true);
                    session.setAttribute("uName", login.getUsername());
                    

                    // Set loginSuccess attribute to true
                    request.setAttribute("loginSuccess", true);

                    // Forward to the user page
                    RequestDispatcher rd = request.getRequestDispatcher("login.jsp");
                    rd.forward(request, response);
                } else {
                    // Set loginSuccess attribute to false
                    request.setAttribute("loginSuccess", false);

                    // Forward to the login page to show the error modal
                    RequestDispatcher rd = request.getRequestDispatcher("login.jsp");
                    rd.forward(request, response);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("eror.jsp");
        } finally {
            try {
                if (rs != null) rs.close();
                if (ps != null) ps.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
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
        return "LoginServlet for handling login requests.";
    }
    
}