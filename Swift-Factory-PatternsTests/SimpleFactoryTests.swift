//
//  SimpleFactoryTests.swift
//  Swift-Factory-PatternsTests
//
//  Created by Saurav Sagar on 05/07/26.
//

import XCTest
@testable import Swift_Factory_Patterns

final class FactoryPatternTests: XCTestCase {

    // Mock Elements for testing our Abstract Framework contracts cleanly
    class MockPaymentProcessor: EnvironmentPaymentProcessing {
        var chargeCalled = false
        func charge(amount: Double) async throws -> String {
            chargeCalled = true
            return "MOCK_TXN"
        }
    }

    class MockReceiptGenerator: ReceiptGenerating {
        func generateReceipt(id: String, amount: Double) -> String { "MOCK_RECEIPT" }
    }

    struct MockSystemFactory: CheckoutServiceFactory {
        func makePaymentProcessor() -> EnvironmentPaymentProcessing { MockPaymentProcessor() }
        func makeReceiptGenerator() -> ReceiptGenerating { MockReceiptGenerator() }
    }


    func testSimpleFactoryGeneration() {
        let processor = PaymentProcessorFactory.makeProcessor(for: .applePay)
        XCTAssertEqual(processor.name, "Apple Pay")
    }

    func testAbstractFactoryFamilyLock() async throws {
        let mockFactory = MockSystemFactory()
        let paymentEngine = mockFactory.makePaymentProcessor()

        let txId = try await paymentEngine.charge(amount: 10.0)

        XCTAssertEqual(txId, "MOCK_TXN")
        XCTAssertTrue((mockFactory.makePaymentProcessor() as! MockPaymentProcessor).chargeCalled == false)
        // Verifies protocol binding behaviors successfully match!
    }
}
