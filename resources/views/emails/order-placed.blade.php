<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Order Confirmation</title>
</head>
<body>
    <h2>Hi {{ $order->first_name }},</h2>

    <p>Thank you for your order!</p>

    <p><strong>Order ID:</strong> #{{ $order->id }}</p>
    <p><strong>Total Amount:</strong> Rs{{ $order->total }}</p>
    <p><strong>Status:</strong> {{ ucfirst($order->status) }}</p>

    <h3>Shipping Address</h3>
    <p>
        {{ $order->address1 }}<br>
        {{ $order->city }}, {{ $order->state }} - {{ $order->zipcode }}<br>
        {{ $order->country }}
    </p>

    <hr>
    <p>We will contact you if any issues arise. Thanks for shopping with us!</p>
</body>
</html>
