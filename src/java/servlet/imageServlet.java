package servlet;

import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import controller.adminDao;

@WebServlet("/imageServlet")
public class imageServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            int bookId = Integer.parseInt(request.getParameter("id"));
            adminDao dao = new adminDao();
            InputStream imageStream = dao.getBookImageStream(bookId);
            
            if (imageStream != null) {
                response.setContentType("image/jpeg");
                response.setContentLength(imageStream.available());
                
                try (OutputStream out = response.getOutputStream()) {
                    byte[] buffer = new byte[1024];
                    int bytesRead;
                    while ((bytesRead = imageStream.read(buffer)) != -1) {
                        out.write(buffer, 0, bytesRead);
                    }
                }
            } else {
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "Image not found");
            }
        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid book ID format");
        } catch (Exception e) {
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "An error occurred while processing the request");
            e.printStackTrace();
        }
    }
}
