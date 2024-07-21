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

        String idParam = request.getParameter("id");
        if (idParam == null || idParam.isEmpty()) {
            response.sendRedirect("detail.jsp?updateSuccess=false");
            return;
        }
        
        int userId;
        try {
            userId = Integer.parseInt(idParam);
        } catch (NumberFormatException e) {
            response.sendRedirect("detail.jsp?updateSuccess=false");
            return;
        }

        String newName = request.getParameter("name");
        String newEmail = request.getParameter("email");
        String newPassword = request.getParameter("password");
        String newAddress = request.getParameter("address");
        String newCity = request.getParameter("city");
        String newPostCode = request.getParameter("postCode");

        UserDAO userDAO = new UserDAO();
        userBeans user = userDAO.getUserByUsername(currentUsername);

        if (user != null) {
            user.setId(userId); // Set user ID
            boolean hasChanges = false;

            if (newEmail != null && !newEmail.equals(user.getEmail())) {
                if (userDAO.isEmailUsed(newEmail)) {
                    request.setAttribute("errorMessage", "Email sudah digunakan.");
                    request.getRequestDispatcher("detail.jsp").forward(request, response);
                    return;
                }
                user.setEmail(newEmail);
                hasChanges = true;
            }
            if (newName != null && !newName.equals(user.getName())) {
                user.setName(newName);
                hasChanges = true;
            }
            if (newPassword != null && !newPassword.isEmpty() && !newPassword.equals(user.getPassword())) {
                user.setPassword(newPassword);
                hasChanges = true;
            }
            if (newAddress != null && !newAddress.equals(user.getAddress())) {
                user.setAddress(newAddress);
                hasChanges = true;
            }
            if (newCity != null && !newCity.equals(user.getCity())) {
                user.setCity(newCity);
                hasChanges = true;
            }
            if (newPostCode != null && !newPostCode.equals(user.getPostCode())) {
                user.setPostCode(newPostCode);
                hasChanges = true;
            }

            if (hasChanges) {
                boolean success = userDAO.updateUser(user);

                if (success) {
                    session.setAttribute("uName", user.getUsername());
                    response.sendRedirect("detail.jsp?updateSuccess=true");
                } else {
                    response.sendRedirect("detail.jsp?updateSuccess=false");
                }
            } else {
                response.sendRedirect("detail.jsp?noChanges=true");
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
