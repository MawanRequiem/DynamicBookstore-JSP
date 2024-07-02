<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Checkout</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f5f5f5;
        }
        .checkout {
            width: 80%;
            margin: 20px auto;
            background-color: white;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
        .checkout-item {
            border-bottom: 1px solid #ddd;
            padding: 10px 0;
        }
        .checkout-item:last-child {
            border-bottom: none;
        }
        .total {
            text-align: center;
            font-weight: bold;
            margin-top: 10px;
            font-size: 1.5em;
        }
    </style>
</head>
<body>
    <div class="checkout">
        <h1>Checkout</h1>
        <div>
            <% 
                String[] cartItems = request.getParameterValues("cartItems[]");
                int total = 0;
                if (cartItems != null) {
                    for (String item : cartItems) {
                        String[] itemDetails = item.split("\\|");
                        if (itemDetails.length == 3) {
                            String title = itemDetails[0];
                            int price = Integer.parseInt(itemDetails[1]);
                            int quantity = Integer.parseInt(itemDetails[2]);
                            int subtotal = price * quantity;
                            total += subtotal;
            %>
            <div class="checkout-item">
                <span><%= title %></span>
                <span> - Rp <%= String.format("%,d", price) %> x <%= quantity %> = Rp <%= String.format("%,d", subtotal) %></span>
            </div>
            <% 
                        }
                    }
                } 
            %>
        </div>
        <div class="total">Total: Rp <%= String.format("%,d", total) %></div>
        <!-- Tambahkan formulir pembayaran sesuai kebutuhan -->
    </div>
</body>
</html>
