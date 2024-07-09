package servlet;

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

        String newAddress = request.getParameter("address");
        String newCity = request.getParameter("city");
        String newPostCode = request.getParameter("postCode");

        UserDAO userDAO = new UserDAO();
        userBeans user = userDAO.getUserByUsername(currentUsername);

        if (user != null) {
            // Update only the non-null parameters
            if (newAddress != null && !newAddress.trim().isEmpty()) {
                user.setAddress(newAddress);
            }
            if (newCity != null && !newCity.trim().isEmpty()) {
                user.setCity(newCity);
            }
            if (newPostCode != null && !newPostCode.trim().isEmpty()) {
                user.setPostCode(newPostCode);
            }

            boolean success = userDAO.updateUser(user);

            if (success) {
                session.setAttribute("uName", user.getUsername());
                response.sendRedirect("detail.jsp");
            } else {
                response.sendRedirect("AccountDetails.jsp?error=true");
            }
        } else {
            response.sendRedirect("login.jsp");
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
