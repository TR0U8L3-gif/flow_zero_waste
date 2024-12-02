import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

/// This class will be used to handle all the stripe related services.
class StripeService {
  /// Singleton factory
  factory StripeService() {
    return _instance;
  }
  StripeService._();

  static final _instance = StripeService._();

  Future<bool> makePayment(double price, String currency) async {
    try {
      final paymentIntent =
          await _createPaymentIntent((price * 100).toInt(), currency);
      if (paymentIntent == null) return false;
      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: paymentIntent,
          merchantDisplayName: 'Flow - Zero Waste App',
        ),
      );
      await _processPayment();
      return true;
    } catch (e) {
      debugPrint('Error: $e');
    }
    return false;
  }

  Future<String?> _createPaymentIntent(int amount, String currency) async {
    try {
      // get the environment variables
      await dotenv.load(fileName: 'assets/env/.env');

      Stripe.publishableKey = dotenv.env['stripe_public_key'] ?? '';

      final dio = Dio();
      final data = <String, dynamic>{
        'amount': amount,
        'currency': currency,
      };
      final response = await dio.post(
        'https://api.stripe.com/v1/payment_intents',
        data: data,
        options: Options(
          contentType: Headers.formUrlEncodedContentType,
          headers: {
            'Authorization': 'Bearer ${dotenv.env['stripe_secret_key']}',
            'Content-Type': 'application/x-www-form-urlencoded',
          },
        ),
      );
      if (response.statusCode != null) {
        debugPrint('Response: ${response.data}');
        return response.data['client_secret'] as String;
      } else {
        return null;
      }
    } catch (e) {
      debugPrint('Error: $e');
    }
    return null;
  }

  Future<void> _processPayment() async {
    try {
      await Stripe.instance.presentPaymentSheet();
    } catch (e) {
      debugPrint('Error: $e');
    }
  }
}
