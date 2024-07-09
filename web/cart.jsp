<%@page import="model.cartBeans"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="controller.CartDAO, model.cartBeans, java.sql.Connection" %>
<%@ page import="javax.servlet.http.HttpSession" %>
<%
    String username = (String) session.getAttribute("uName");
    if (username == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    Connection connection = (Connection) getServletContext().getAttribute("DBConnection");
    CartDAO cartDAO = new CartDAO();
    List<cartBeans> cartItems = cartDAO.getCartItems(username);
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Keranjang Belanja</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Zen+Maru+Gothic&display=swap');
        html, body {
            font-family: 'Zen Maru Gothic', sans-serif;
        }
        .container {
            margin-top: 50px;
        }
        .card {
            display: flex;
            flex-direction: row;
            align-items: center;
            justify-content: space-between;
            margin-bottom: 20px;
            padding: 10px;
            background-color: #f8f9fa;
            border: 1px solid #dee2e6;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
        .card-body {
            display: flex;
            flex-direction: row;
            align-items: center;
        }
        .card-body img {
            width: 100px;
            height: auto;
            margin-right: 20px;
        }
        .book-details {
            flex: 1;
        }
        .book-title {
            font-size: 18px;
            font-weight: bold;
            margin-bottom: 5px;
        }
        .book-price {
            color: #EB6611;
            font-size: 16px;
        }
        .quantity-control {
            display: flex;
            align-items: center;
            justify-content: center;
        }
        .quantity-control button {
            width: 30px;
            height: 30px;
            font-size: 16px;
            border: 1px solid #ccc;
            border-radius: 5px;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            background-color: #f8f9fa;
        }
        .quantity-control .quantity {
            margin: 0 10px;
            width: 30px;
            text-align: center;
        }
        .remove-button {
            margin-top: 10px;
            align-self: flex-end;
        }
        .summary-card {
            padding: 20px;
            background-color: #ffffff;
            border: 1px solid #dee2e6;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
        .summary-card .total {
            font-size: 20px;
            font-weight: bold;
        }
        .summary-card .checkout-button {
            width: 100%;
            margin-top: 20px;
        }
        .select-all-card {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 10px;
            background-color: #ffffff;
            border: 1px solid #dee2e6;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            margin-bottom: 20px;
        }
        .btn-remove {
            display: none;
            background-color: white;
            color: black;
            border: 1px solid black;
        }
        .btn-remove:hover {
            background-color: red;
            color: white;
            cursor: pointer;
        }
        .modal-dialog {
            max-width: 400px;
            margin: 30vh auto;
        }
        .modal-content {
            padding: 20px;
        }
        .modal-footer .btn {
            min-width: 100px;
        }
    </style>
</head>
<body>
    <div class="container">
        <a href="index.jsp" class="btn btn-danger">Cancel</a>
        <h1 class="mt-3 mb-4">Keranjang Belanja</h1>
        
        <div class="select-all-card">
            <div>
                <input type="checkbox" id="select-all" onclick="toggleSelectAll()"> Pilih Semua
            </div>
            <button type="button" class="btn btn-remove" id="remove-selected" onclick="showRemoveAllModal()">Hapus</button>
        </div>
        
        <div class="row">
            <div class="col-md-8">
                <form id="cart-form" action="checkout.jsp" method="POST" onsubmit="return validateCheckout()">
                    <input type="hidden" name="fromCart" value="true">
                    <% for (cartBeans item : cartItems) { %>
                        <div class="card" id="cart-item-<%= item.getId() %>">
                            <div class="card-body">
                                <input type="checkbox" class="book-checkbox" name="selectedItems" value="<%= item.getId() %>" data-price="<%= item.getBookPrice() %>" data-quantity="<%= item.getQuantity() %>" onclick="updateTotal()">
                                <img src="data:image/png;base64,<%= item.getImageBase64() %>" alt="<%= item.getBookName() %>" class="img-thumbnail">
                                <div class="book-details">
                                    <h5 class="book-title"><%= item.getBookName() %></h5>
                                    <p class="book-price">Rp <%= item.getBookPrice() %></p>
                                </div>
                                <div class="quantity-control">
                                    <button type="button" class="btn btn-outline-secondary" onclick="changeQuantity(this, -1, '<%= item.getId() %>', '<%= item.getStock() %>')">-</button>
                                    <span class="quantity"><%= item.getQuantity() %></span>
                                    <button type="button" class="btn btn-outline-secondary" onclick="changeQuantity(this, 1, '<%= item.getId() %>', '<%= item.getStock() %>')">+</button>
                                </div>
                            </div>
                            <button type="button" class="btn btn-danger remove-button" onclick="changeQuantity(this, -<%= item.getQuantity() %>, '<%= item.getId() %>', '<%= item.getStock() %>')">Remove</button>
                        </div>
                    <% } %>
                </form>
            </div>
            <div class="col-md-4">
                <div class="summary-card">
                    <h5>Ringkasan Belanja</h5>
                    <div class="total">
                        Total: Rp <span id="total-price">0</span>
                    </div>
                    <button type="submit" form="cart-form" class="btn btn-success checkout-button">Beli</button>
                </div>
            </div>
        </div>
    </div>

    <!-- Modal -->
    <div class="modal fade" id="removeAllModal" tabindex="-1" role="dialog" aria-labelledby="removeAllModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="removeAllModalLabel">Konfirmasi Hapus</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    Apakah Anda yakin ingin menghapus semua item yang dipilih?
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-light" data-dismiss="modal">Batal</button>
                    <button type="button" class="btn btn-success" onclick="removeSelectedItems()">Hapus</button>
                </div>
            </div>
        </div>
    </div>

    <!-- Alert Modal -->
    <div class="modal fade" id="alertModal" tabindex="-1" role="dialog" aria-labelledby="alertModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="alertModalLabel">Peringatan</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body" id="modalContent">
                    <!-- Modal content will be set by JavaScript -->
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-primary" data-dismiss="modal">Tutup</button>
                </div>
            </div>
        </div>
    </div>

    <script>
        let totalHarga = 0;

        function updateTotal() {
            totalHarga = 0;
            let isAnyCheckboxChecked = false;

            document.querySelectorAll('.book-checkbox:checked').forEach(checkbox => {
                const price = parseFloat(checkbox.getAttribute('data-price'));
                const quantity = parseInt(checkbox.getAttribute('data-quantity'));
                totalHarga += price * quantity;
                isAnyCheckboxChecked = true;
            });

            document.getElementById('total-price').innerText = totalHarga.toLocaleString('id-ID');
            document.getElementById('remove-selected').style.display = isAnyCheckboxChecked ? 'inline-block' : 'none';
        }

        function changeQuantity(button, change, bookId, maxStock) {
            const quantitySpan = button.parentNode.querySelector('.quantity');
            let quantity = parseInt(quantitySpan.innerText);
            const checkbox = button.parentNode.parentNode.querySelector('.book-checkbox');

            quantity += change;

            if (quantity > maxStock) {
                showModal('Kuantitas melebihi stock yang ada.');
                return;
            }

            if (quantity <= 0) {
                if (confirm('Apakah yakin untuk menghapus barang dari cart?')) {
                    const card = document.getElementById('cart-item-' + bookId);
                    card.parentNode.removeChild(card);
                    removeFromCart(bookId);
                } else {
                    quantity = 1;
                }
            }

            quantitySpan.innerText = quantity;
            checkbox.setAttribute('data-quantity', quantity);
            updateCartItem(bookId, quantity);
            updateTotal();
        }

        function showModal(message) {
            const modalContent = document.getElementById('modalContent');
            modalContent.innerText = message;
            $('#alertModal').modal('show');
        }

        function confirmRemove(bookId) {
            if (confirm('Apakah yakin untuk menghapus barang dari cart?')) {
                const card = document.getElementById('cart-item-' + bookId);
                card.parentNode.removeChild(card);
                removeFromCart(bookId);
            }
        }

        function removeFromCart(cartId) {
            fetch('RemoveFromCartServlet?cartId=' + cartId, {
                method: 'POST'
            })
            .then(response => {
                if (response.ok) {
                    updateTotal();
                } else {
                    alert('Gagal menghapus barang dari cart.');
                }
            })
            .catch(error => {
                console.error('Error removing from cart:', error);
                alert('Terjadi kesalahan saat menghapus barang dari cart.');
            });
        }

        function updateCartItem(cartId, quantity) {
            fetch('UpdateCartServlet?cartId=' + cartId + '&quantity=' + quantity, {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/x-www-form-urlencoded'
                }
            })
            .then(response => {
                if (response.ok) {
                    console.log('Berhasil memperbarui jumlah barang di keranjang.');
                } else {
                    alert('Gagal memperbarui jumlah barang di keranjang.');
                }
            })
            .catch(error => {
                console.error('Error updating cart item:', error);
                alert('Terjadi kesalahan saat memperbarui jumlah barang di keranjang.');
            });
        }

        function validateCheckout() {
            if (document.querySelectorAll('.book-checkbox:checked').length === 0) {
                alert('Pilih setidaknya satu item untuk melanjutkan.');
                return false;
            }
            return true;
        }

        function toggleSelectAll() {
            const selectAllCheckbox = document.getElementById('select-all');
            const itemCheckboxes = document.querySelectorAll('.book-checkbox');

            itemCheckboxes.forEach(checkbox => {
                checkbox.checked = selectAllCheckbox.checked;
            });

            updateTotal();
        }

        function showRemoveAllModal() {
            $('#removeAllModal').modal('show');
        }

        function removeSelectedItems() {
            const selectedItems = document.querySelectorAll('.book-checkbox:checked');
            selectedItems.forEach(item => {
                const cartItem = document.getElementById('cart-item-' + item.value);
                cartItem.parentNode.removeChild(cartItem);
            });
            $('#removeAllModal').modal('hide');
            updateTotal();
        }

        document.addEventListener('DOMContentLoaded', updateTotal);
    </script>

    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
