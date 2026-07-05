//
//  ConcreteProcessors.swift
//  Swift-Factory-Patterns
//
//  Created by Saurav Sagar on 05/07/26.
//

import Foundation

class CreditCardProcessor: PaymentProcessing {
    var name: String { "Credit Card" }

    func charge(amount: Double) async throws -> TransactionResult {
        try await Task.sleep(nanoseconds: 500_000_000) // Simulate network delay
        return TransactionResult(transactionId: "stripe_\(UUID().uuidString.prefix(6))", amount: amount, timestamp: Date())
    }

    func refund(transactionId: String) async throws { print("Refunding \(transactionId) via Stripe") }
}

class PayPalProcessor: PaymentProcessing {
    var name: String { "PayPal" }

    func charge(amount: Double) async throws -> TransactionResult {
        try await Task.sleep(nanoseconds: 500_000_000)
        return TransactionResult(transactionId: "paypal_\(UUID().uuidString.prefix(6))", amount: amount, timestamp: Date())
    }

    func refund(transactionId: String) async throws { print("Refunding \(transactionId) via PayPal") }
}

class ApplePayProcessor: PaymentProcessing {
    var name: String { "Apple Pay" }

    func charge(amount: Double) async throws -> TransactionResult {
        try await Task.sleep(nanoseconds: 500_000_000)
        return TransactionResult(transactionId: "applepay_\(UUID().uuidString.prefix(6))", amount: amount, timestamp: Date())
    }

    func refund(transactionId: String) async throws { print("Refunding \(transactionId) via Apple Pay") }
}
