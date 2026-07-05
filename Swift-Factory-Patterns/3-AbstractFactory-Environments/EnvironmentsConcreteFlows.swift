//
//  EnvironmentsConcreteFlows.swift
//  Swift-Factory-Patterns
//
//  Created by Saurav Sagar on 05/07/26.
//

import Foundation

// --- Sandbox Variant Family ---
class SandboxPaymentProcessor: EnvironmentPaymentProcessing {
    func charge(amount: Double) async throws -> String { "SANDBOX_TXN_\(Int.random(in: 1000...9999))" }
}

class SandboxReceiptGenerator: ReceiptGenerating {
    func generateReceipt(id: String, amount: Double) -> String { "🧪 [TEST RECEIPT] Item cost: $\(amount)" }
}

public struct SandboxCheckoutFactory: CheckoutServiceFactory {
    public init() {}
    public func makePaymentProcessor() -> EnvironmentPaymentProcessing { SandboxPaymentProcessor() }
    public func makeReceiptGenerator() -> ReceiptGenerating { SandboxReceiptGenerator() }
}

// --- Production Variant Family ---
class StripeProductionProcessor: EnvironmentPaymentProcessing {
    func charge(amount: Double) async throws -> String { "LIVE_STRIPE_\(UUID().uuidString.prefix(8).uppercased())" }
}

class LivePDFReceiptGenerator: ReceiptGenerating {
    func generateReceipt(id: String, amount: Double) -> String { "📄 [OFFICIAL RECEIPT] Secure Verification Ref: \(id)" }
}

public struct ProductionCheckoutFactory: CheckoutServiceFactory {
    public init() {}
    public func makePaymentProcessor() -> EnvironmentPaymentProcessing { StripeProductionProcessor() }
    public func makeReceiptGenerator() -> ReceiptGenerating { LivePDFReceiptGenerator() }
}
