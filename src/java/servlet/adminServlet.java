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
                    showEditForm(request, response);
                    break;
                case "update":
                    updateBook(request, response);
                    break;
                case "delete":
                    deleteBook(request, response);
                    break;
                case "list":
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
        String hargaBukuStr = request.getParameter("hargaBuku");
        String genreBuku = request.getParameter("genreBuku");
         String serialBuku = request.getParameter("serialBuku");
        String deskripsiBuku = request.getParameter("deskripsiBuku");
        String stockBukuStr = request.getParameter("stockBuku");

        double hargaBuku = 0;
        int stockBuku = 0;
        try {
            hargaBuku = Double.parseDouble(hargaBukuStr);
            stockBuku = Integer.parseInt(stockBukuStr);
        } catch (NumberFormatException e) {
            request.setAttribute("errorMessage", "Invalid input for price or stock.");
            listBooks(request, response);
            return;
        }

        InputStream gambarStream = gambarBuku.getInputStream();

        bookBeans book = new bookBeans();
        book.setGambar(gambarStream);
        book.setNama(namaBuku);
        book.setHarga(hargaBuku);
        book.setGenre(genreBuku);
          book.setSerial(serialBuku);
        book.setDeskripsi(deskripsiBuku);
        book.setStock(stockBuku);

        boolean success = adminDao.addBook(book);
        if (success) {
            request.setAttribute("message", "Book added successfully");
        } else {
            request.setAttribute("errorMessage", "Failed to add book");
        }
        listBooks(request, response);
    }

    private void showEditForm(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int bookId = Integer.parseInt(request.getParameter("bookId"));
        bookBeans existingBook = adminDao.getBookById(bookId);
        request.setAttribute("book", existingBook);
        request.getRequestDispatcher("editBookForm.jsp").forward(request, response);
    }

    private void updateBook(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        int id = Integer.parseInt(request.getParameter("bookId"));
        String namaBuku = request.getParameter("namaBuku");
        String hargaBukuStr = request.getParameter("hargaBuku");
        String genreBuku = request.getParameter("genreBuku");
        String serialBuku = request.getParameter("serialBuku");
        String deskripsiBuku = request.getParameter("deskripsiBuku");
        String stockBukuStr = request.getParameter("stockBuku");

        double hargaBuku = Double.parseDouble(hargaBukuStr);
        int stockBuku = Integer.parseInt(stockBukuStr);

        Part gambarBuku = request.getPart("gambarBuku");
        InputStream gambarStream = (gambarBuku != null && gambarBuku.getSize() > 0) ? gambarBuku.getInputStream() : null;

        bookBeans book = new bookBeans();
        book.setId(id);
        if (gambarStream != null) {
            book.setGambar(gambarStream);
        }
        book.setNama(namaBuku);
        book.setHarga(hargaBuku);
        book.setGenre(genreBuku);
        book.setSerial(serialBuku);
        book.setDeskripsi(deskripsiBuku);
        book.setStock(stockBuku);

        boolean success = adminDao.updateBook(book);
        if (success) {
            request.setAttribute("message", "Book updated successfully");
        } else {
            request.setAttribute("errorMessage", "Failed to update book");
        }
        listBooks(request, response);
    }

    private void deleteBook(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        int bookId = Integer.parseInt(request.getParameter("bookId"));

        boolean success = adminDao.deleteBook(bookId);
        if (success) {
            request.setAttribute("message", "Book deleted successfully");
        } else {
            request.setAttribute("errorMessage", "Failed to delete book");
        }
        listBooks(request, response);
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
