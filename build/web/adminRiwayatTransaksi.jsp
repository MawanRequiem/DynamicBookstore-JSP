<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="model.transaksiBeans" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Transaction History - Admin</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 20px;
        }
        h1 {
            text-align: center;
            color: #333;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 20px;
        }
        table, th, td {
            border: 1px solid #ddd;
        }
        th, td {
            padding: 15px;
            text-align: left;
        }
        th {
            background-color: #f2f2f2;
        }
        tr:nth-child(even) {
            background-color: #f9f9f9;
        }
        .button-container {
            text-align: center;
        }
        .back-button {
            background-color: #007bff;
            color: white;
            border: none;
            padding: 10px 20px;
            text-align: center;
            text-decoration: none;
            display: inline-block;
            font-size: 16px;
            cursor: pointer;
            border-radius: 5px;
        }
        .back-button:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>
    <h1>Transaction History</h1>
    <table>
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
        <%
            List<transaksiBeans> transaksiList = (List<transaksiBeans>) request.getAttribute("transaksiList");
            if (transaksiList != null) {
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
            }
        %>
    </table>
    <div class="button-container">
        <button class="back-button" onclick="location.href='index.jsp'">Back to Home</button>
    </div>
</body>
</html>
