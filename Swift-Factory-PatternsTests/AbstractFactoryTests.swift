//
//  AbstractFactoryTests.swift
//  Swift-Factory-PatternsTests
//
//  Created by Saurav Sagar on 05/07/26.
//

import XCTest
@testable import Swift_Factory_Patterns // <-- Match your exact main app target name

// MARK: - Test Cases
final class AbstractFactoryTests: XCTestCase {

    // MARK: - Testing Mocks
    final class MockPaymentProcessor: EnvironmentPaymentProcessing {
        var wasChargeCalled = false
        var simulatedTxId = "MOCK_LIVE_TXN_999"

        func charge(amount: Double) async throws -> String {
            wasChargeCalled = true
            return simulatedTxId
        }
    }

    final class MockReceiptGenerator: ReceiptGenerating {
        func generateReceipt(id: String, amount: Double) -> String {
            return "MOCK_RECEIPT_OUTPUT_FOR_\(id)"
        }
    }

    struct MockSystemFactory: CheckoutServiceFactory {
        let paymentMock: MockPaymentProcessor
        let receiptMock: MockReceiptGenerator

        func makePaymentProcessor() -> EnvironmentPaymentProcessing { paymentMock }
        func makeReceiptGenerator() -> ReceiptGenerating { receiptMock }
    }


    func testSandboxFactory_ShouldCreateSandboxFamilyObjects() {
        let factory = SandboxCheckoutFactory()
        let processor = factory.makePaymentProcessor()
        let receiptGen = factory.makeReceiptGenerator()

        XCTAssertNotNil(processor)
        XCTAssertNotNil(receiptGen)
    }

    func testProductionFactory_ShouldCreateProductionFamilyObjects() {
        let factory = ProductionCheckoutFactory()
        let processor = factory.makePaymentProcessor()
        let receiptGen = factory.makeReceiptGenerator()

        XCTAssertNotNil(processor)
        XCTAssertNotNil(receiptGen)
    }

    func testClientFlow_WithMockFactoryInjection_ShouldExecuteWithoutSideEffects() async throws {
        // Arrange
        let paymentMock = MockPaymentProcessor()
        let receiptMock = MockReceiptGenerator()
        let mockFactory = MockSystemFactory(paymentMock: paymentMock, receiptMock: receiptMock)

        // Act
        let activeProcessor = mockFactory.makePaymentProcessor()
        let activeReceipt = mockFactory.makeReceiptGenerator()

        let returnedTxId = try await activeProcessor.charge(amount: 100.0)
        let generatedReceiptString = activeReceipt.generateReceipt(id: returnedTxId, amount: 100.0)

        // Assert
        XCTAssertTrue(paymentMock.wasChargeCalled, "The mock factory failed to trigger downstream targets.")
        XCTAssertEqual(returnedTxId, "MOCK_LIVE_TXN_999")
        XCTAssertEqual(generatedReceiptString, "MOCK_RECEIPT_OUTPUT_FOR_MOCK_LIVE_TXN_999")
    }
}
