<?php

if (!function_exists('format_currency')) {
    function format_currency($amount, $currency = 'Rs') {
        return $currency . ' ' . number_format($amount, 2);
    }
}
