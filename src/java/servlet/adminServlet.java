// adminServlet.java
package servlet;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import controller.adminDao;
import model.bookBeans;
import java.io.IOException;
import java.io.InputStream;
import java.util.List;

@WebServlet(name = "adminServlet", urlPatterns = {"/adminServlet"})
@MultipartConfig
public class adminServlet extends HttpServlet {

    private adminDao adminDao;

    @Override
    public void init() throws ServletException {
        adminDao = new adminDao();
    }

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        if (action == null) {
            action = "list";
        }

        try {
            switch (action) {
                case "add":
                    addBook(request, response);
                    break;
                case "edit":
                    updateBook(request, response);
                    break;
                case "delete":
                    deleteBook(request, response);
                    break;
                case "list":
                    listBooks(request, response);
                    break;
                default:
                    listBooks(request, response);
                    break;
            }
        } catch (Exception ex) {
            throw new ServletException(ex);
        }
    }

    private void addBook(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        Part gambarBuku = request.getPart("gambarBuku");
        String namaBuku = request.getParameter("namaBuku");
        double hargaBuku = Double.parseDouble(request.getParameter("hargaBuku"));
        String genreBuku = request.getParameter("genreBuku");
        String deskripsiBuku = request.getParameter("deskripsiBuku");
        int stockBuku = Integer.parseInt(request.getParameter("stockBuku"));

        InputStream gambarStream = gambarBuku.getInputStream();

        bookBeans book = new bookBeans();
        book.setGambar(gambarStream);
        book.setNama(namaBuku);
        book.setHarga(hargaBuku);
        book.setGenre(genreBuku);
        book.setDeskripsi(deskripsiBuku);
        book.setStock(stockBuku);

        boolean success = adminDao.addBook(book);
        if (success) {
            response.sendRedirect("admin.jsp");
        } else {
            request.setAttribute("errorMessage", "Failed to add book.");
            request.getRequestDispatcher("admin.jsp").forward(request, response);
        }
    }

    private void updateBook(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        int id = Integer.parseInt(request.getParameter("bookId"));
        Part gambarBuku = request.getPart("gambarBuku");
        String namaBuku = request.getParameter("namaBuku");
        double hargaBuku = Double.parseDouble(request.getParameter("hargaBuku"));
        String genreBuku = request.getParameter("genreBuku");
        String deskripsiBuku = request.getParameter("deskripsiBuku");
        int stockBuku = Integer.parseInt(request.getParameter("stockBuku"));

        InputStream gambarStream = gambarBuku.getInputStream();

        bookBeans book = new bookBeans();
        book.setId(id);
        book.setGambar(gambarStream);
        book.setNama(namaBuku);
        book.setHarga(hargaBuku);
        book.setGenre(genreBuku);
        book.setDeskripsi(deskripsiBuku);
        book.setStock(stockBuku);

        boolean success = adminDao.updateBook(book);
        if (success) {
            response.sendRedirect("admin.jsp");
        } else {
            request.setAttribute("errorMessage", "Failed to update book.");
            request.getRequestDispatcher("admin.jsp").forward(request, response);
        }
    }

    private void deleteBook(HttpServletRequest request, HttpServletResponse response) throws IOException {
        int bookId = Integer.parseInt(request.getParameter("bookId"));
        boolean success = adminDao.deleteBook(bookId);
        if (success) {
            response.sendRedirect("admin.jsp");
        } else {
            response.sendRedirect("admin.jsp?error=Failed to delete book.");
        }
    }

    private void listBooks(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<bookBeans> books = adminDao.getAllBooks();
        request.setAttribute("books", books);
        request.getRequestDispatcher("admin.jsp").forward(request, response);
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
        return "Admin Servlet to handle book management";
    }
}
