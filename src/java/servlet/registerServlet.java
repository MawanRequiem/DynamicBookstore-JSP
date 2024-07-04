package servlet;

import controller.UserDAO;
import model.registerBeans;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * RegisterServlet for handling registration requests.
 */
@WebServlet(name = "registerServlet", urlPatterns = {"/registerServlet"})
public class registerServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        registerBeans user = new registerBeans();
        user.setName(request.getParameter("name"));
        user.setUsername(request.getParameter("username"));
        user.setEmail(request.getParameter("email"));
        user.setPassword(request.getParameter("password"));

        UserDAO userDAO = new UserDAO();
        String registrationStatus = userDAO.registerUser(user);

        if ("success".equals(registrationStatus)) {
            request.setAttribute("registrationStatus", "success");
        } else if ("emailUsed".equals(registrationStatus)) {
            request.setAttribute("registrationStatus", "emailUsed");
        } else {
            request.setAttribute("registrationStatus", "failure");
        }

        request.getRequestDispatcher("register.jsp").forward(request, response);
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
        return "RegisterServlet for handling registration requests.";
    }
}
