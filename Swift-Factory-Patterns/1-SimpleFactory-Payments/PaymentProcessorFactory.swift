//
//  PaymentProcessorFactory.swift
//  Swift-Factory-Patterns
//
//  Created by Saurav Sagar on 05/07/26.
//

import Foundation

public enum PaymentMethod: String, CaseIterable, Identifiable {
    case creditCard = "Credit Card"
    case payPal = "PayPal"
    case applePay = "Apple Pay"

    public var id: String { self.rawValue }
}

public class PaymentProcessorFactory {
    public static func makeProcessor(for method: PaymentMethod) -> PaymentProcessing {
        switch method {
        case .creditCard: return CreditCardProcessor()
        case .payPal: return PayPalProcessor()
        case .applePay: return ApplePayProcessor()
        }
    }
}
