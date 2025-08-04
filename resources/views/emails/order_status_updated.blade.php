<!DOCTYPE html>
<html>
<head>
    <title>Order Status Updated</title>
</head>
<body>
    <h2>Hello {{ $order->first_name }} {{ $order->last_name }},</h2>

    <p>Your order with ID <strong>#{{ $order->id }}</strong> has been updated.</p>
  <p><strong>New Status:</strong> {{ $order->status }}</p>

@if($showReviewMessage)
    <p style="margin-top:20px;">
        Thank you for your purchase!  
        <strong>Please <a href="{{ url('http://127.0.0.1:8000/track-order/' . $order->id) }}">leave a review</a></strong> and let us know how we did.
    </p>
@endif


    <p>Thank you for shopping with us.</p>
</body>
</html>
