//
//  FactoryMethodTests.swift
//  Swift-Factory-PatternsTests
//
//  Created by Saurav Sagar on 05/07/26.
//

import XCTest
@testable import Swift_Factory_Patterns

final class FactoryMethodTests: XCTestCase {

    func testPushNotificationService_ShouldCreatePushSender() {
        // Arrange
        let service = PushNotificationService()

        // Act
        let sender = service.makeNotificationSender()

        // Assert
        XCTAssertEqual(sender.channelName, "Push Notification")
    }

    func testSMSNotificationService_ShouldCreateSMSSender() {
        // Arrange
        let service = SMSNotificationService()

        // Act
        let sender = service.makeNotificationSender()

        // Assert
        XCTAssertEqual(sender.channelName, "SMS")
    }

    func testNotificationServiceExtension_ShouldFail_WhenRecipientValidationFails() async throws {
        // Arrange
        let service = SMSNotificationService()
        let invalidRecipient = "invalid_phone_no_prefix"

        // Act
        let executionLog = try await service.sendNotification(
            title: "Alert",
            body: "Test message",
            to: invalidRecipient
        )

        // Assert
        XCTAssertTrue(executionLog.contains("Validation Failed"), "Service should block execution if validation fails.")
    }

    func testNotificationServiceExtension_ShouldSucceed_WhenRecipientIsValid() async throws {
        // Arrange
        let service = SMSNotificationService()
        let validRecipient = "+15551234567"

        // Act
        let executionLog = try await service.sendNotification(
            title: "Alert",
            body: "Test message",
            to: validRecipient
        )

        // Assert
        XCTAssertTrue(executionLog.contains("Broadcast complete"), "Service failed to route validation pass through factory output.")
    }
}
