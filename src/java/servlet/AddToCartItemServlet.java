package servlet;

import controller.CartDAO;
import controller.UserDAO;
import model.cartBeans;
import controller.BookDAO;
import model.bookBeans;
import model.userBeans;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.InputStream;
import java.sql.SQLException;

/**
 * AddToCartServlet for handling adding books to the cart.
 */
@WebServlet(name = "AddToCartServlet", urlPatterns = {"/AddToCartServlet"})
public class AddToCartItemServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        String username = (String) session.getAttribute("uName");
        if (username == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String bookIdParam = request.getParameter("bookId");
        String bookName = request.getParameter("bookName");
        String bookPriceParam = request.getParameter("bookPrice");

        if (bookIdParam == null || bookIdParam.isEmpty() ||
            bookName == null || bookName.isEmpty() ||
            bookPriceParam == null || bookPriceParam.isEmpty()) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Missing parameters");
            return;
        }

        int bookId = Integer.parseInt(bookIdParam);
        double bookPrice = Double.parseDouble(bookPriceParam);

        BookDAO bookDAO = new BookDAO();
        InputStream bookImage = null;
        try {
            bookBeans book = bookDAO.getBookById(bookId);
            if (book != null) {
                bookImage = book.getGambar();
            }
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "An error occurred while fetching the book image.");
            return;
        }

        if (bookImage == null) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Book image not found");
            return;
        }

        UserDAO userDAO = new UserDAO();
        userBeans user = userDAO.getUserByUsername(username);
        if (user == null) {
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "User not found");
            return;
        }
        int userId = user.getId();

        cartBeans cartItem = new cartBeans();
        cartItem.setBookId(bookId);
        cartItem.setBookName(bookName);
        cartItem.setBookPrice(bookPrice);
        cartItem.setBookImage(bookImage);
        cartItem.setQuantity(1); // Default quantity to 1
        cartItem.setUserId(userId);

        CartDAO cartDAO = new CartDAO();

        try {
            cartDAO.addToCart(cartItem);
            response.sendRedirect("cart.jsp");
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "An error occurred while adding the book to the cart.");
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
        return "AddToCartServlet for handling adding books to the cart.";
    }
}
