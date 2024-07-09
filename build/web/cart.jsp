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
</head>
<body>
    <a href="index.jsp" class="btn btn-secondary">Cancel</a>
    <div class="container mt-5">
        <h1>Keranjang Belanja</h1>
        <form id="cart-form" action="checkout.jsp" method="POST" onsubmit="return validateCheckout()">
            <div class="list-group">
                <% for (cartBeans item : cartItems) { %>
                    <div class="list-group-item">
                        <input type="checkbox" class="book-checkbox" name="cartItems" value="<%= item.getId() %>" data-price="<%= item.getBookPrice() %>" data-quantity="<%= item.getQuantity() %>">
                        <img src="" alt="<%= item.getBookName() %>" class="img-thumbnail" style="width: 100px; height: 150px;">
                        <div>
                            <h5><%= item.getBookName() %></h5>
                            <p>Rp <%= item.getBookPrice() %></p>
                        </div>
                        <div class="quantity-control">
                            <button type="button" class="btn btn-outline-secondary" onclick="changeQuantity(this, -1)">-</button>
                            <span class="quantity"><%= item.getQuantity() %></span>
                            <button type="button" class="btn btn-outline-secondary" onclick="changeQuantity(this, 1)">+</button>
                        </div>
                        <button type="button" class="btn btn-danger" onclick="confirmRemove('<%= item.getId() %>')">Remove</button>
                    </div>
                <% } %>
            </div>
            <div class="mt-3">
                <div class="total" id="total-price">Total: Rp 0</div>
                <button type="submit" class="btn btn-primary">Checkout</button>
            </div>
        </form>
    </div>

    <script>
    let cart = [];

    function updateTotal() {
        let total = 0;
        document.querySelectorAll('.book-checkbox:checked').forEach(checkbox => {
            const price = parseFloat(checkbox.getAttribute('data-price'));
            const quantity = parseInt(checkbox.getAttribute('data-quantity'));
            total += price * quantity;
        });
        document.getElementById('total-price').innerText = `Total: Rp ${total.toLocaleString()}`;
    }

    function changeQuantity(button, change) {
        const quantitySpan = button.parentNode.querySelector('.quantity');
        let quantity = parseInt(quantitySpan.innerText);
        const checkbox = button.parentNode.parentNode.querySelector('.book-checkbox');
        const cartId = checkbox.value; // ID dari item di keranjang

        quantity = Math.max(0, quantity + change);
        quantitySpan.innerText = quantity;
        checkbox.setAttribute('data-quantity', quantity);

    if (quantity === 0) {
        if (confirm('Apakah yakin untuk menghapus barang dari cart?')) {
            checkbox.parentNode.remove();
            removeFromCart(cartId); // Menghapus dari cart pada sisi client
        } else {
            quantitySpan.innerText = 1;
            checkbox.setAttribute('data-quantity', 1);
        }
    } else {
        // Kirim permintaan untuk memperbarui jumlah item di server
        updateCartItem(cartId, quantity);
    }

    updateTotal();
}


    function confirmRemove(cartId) {
        if (confirm('Apakah yakin untuk menghapus barang dari cart?')) {
            removeFromCart(cartId); // Menghapus dari cart pada sisi client
            document.querySelector(`input[value="${cartId}"]`).parentNode.remove(); // Hapus dari tampilan
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
    fetch('UpdateCartServlet', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/x-www-form-urlencoded'
        },
        body: `cartId=${cartId}&quantity=${quantity}`
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
        const checkedItems = document.querySelectorAll('.book-checkbox:checked');
        if (checkedItems.length === 0) {
            alert('Pilih minimal satu item untuk checkout.');
            return false;
        }
        return true;
    }

    document.querySelectorAll('.book-checkbox').forEach(checkbox => {
        checkbox.addEventListener('change', updateTotal);
    });
    updateTotal();
    </script>
</body>
</html>
