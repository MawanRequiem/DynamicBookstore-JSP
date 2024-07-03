package Servlet;

import controller.UserDAO;
import model.userBeans;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * UpdateServlet for handling update requests.
 */
@WebServlet(name = "UpdateServlet", urlPatterns = {"/UpdateServlet"})
public class updateServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        String currentUsername = (String) session.getAttribute("uName");

        if (currentUsername == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        userBeans user = new userBeans();
        user.setName(request.getParameter("name"));
        user.setUsername(currentUsername);
        user.setEmail(request.getParameter("email"));
        user.setPassword(request.getParameter("password"));

        UserDAO userDAO = new UserDAO();
        boolean success = userDAO.updateUser(user);

        if (success) {
            session.setAttribute("uName", user.getUsername());
            response.sendRedirect("detail.jsp");
        } else {
            response.sendRedirect("detail.jsp?error=true");
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
        return "UpdateServlet for handling update requests.";
    }
}
