//
//  PaymentProtocols.swift
//  Swift-Factory-Patterns
//
//  Created by Saurav Sagar on 05/07/26.
//

import Foundation

public struct TransactionResult {
    public let transactionId: String
    public let amount: Double
    public let timestamp: Date
}

public protocol PaymentProcessing {
    var name: String { get }
    func charge(amount: Double) async throws -> TransactionResult
    func refund(transactionId: String) async throws
}
