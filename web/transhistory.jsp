<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="model.transaksiBeans" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Transaction History</title>
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
</head>

<body>
    <div class="container mt-5">
        <h2>Transaction History</h2>
        <table class="table table-striped">
            <thead>
                <tr>
                    <th>Book Name</th>
                    <th>User Name</th>
                    <th>Buyer Name</th>
                    <th>Book Price</th>
                    <th>Date</th>
                    <th>Quantity</th>
                    <th>Email</th>
                    <th>Address</th>
                    <th>Payment Method</th>
                </tr>
            </thead>
            <tbody>
                <% 
                    List<transaksiBeans> transaksiList = (List<transaksiBeans>) request.getAttribute("transaksiList");
                    if (transaksiList != null && !transaksiList.isEmpty()) {
                        for (transaksiBeans transaksi : transaksiList) {
                %>
                <tr>
                    <td><%= transaksi.getNameBuku() %></td>
                    <td><%= transaksi.getNamaUser() %></td>
                    <td><%= transaksi.getNamaPembeli() %></td>
                    <td><%= transaksi.getHargaBuku() %></td>
                    <td><%= transaksi.getTanggal() %></td>
                    <td><%= transaksi.getJumlah() %></td>
                    <td><%= transaksi.getEmail() %></td>
                    <td><%= transaksi.getAlamat() %></td>
                    <td><%= transaksi.getMetodePem() %></td>
                </tr>
                <%
                        }
                    } else {
                %>
                <tr>
                    <td colspan="9">No transactions found</td>
                </tr>
                <%
                    }
                %>
            </tbody>
        </table>
        <a href="index.jsp" class="btn btn-primary">Back to Home</a>
    </div>

    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.3/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
