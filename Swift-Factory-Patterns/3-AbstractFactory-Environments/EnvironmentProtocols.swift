//
//  EnvironmentProtocols.swift
//  Swift-Factory-Patterns
//
//  Created by Saurav Sagar on 05/07/26.
//

import Foundation

public protocol EnvironmentPaymentProcessing {
    func charge(amount: Double) async throws -> String
}

public protocol ReceiptGenerating {
    func generateReceipt(id: String, amount: Double) -> String
}

// The Abstract Factory contract defining structural consistency
public protocol CheckoutServiceFactory {
    func makePaymentProcessor() -> EnvironmentPaymentProcessing
    func makeReceiptGenerator() -> ReceiptGenerating
}
