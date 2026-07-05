//
//  ConcreteNotificationSenders.swift
//  Swift-Factory-Patterns
//
//  Created by Saurav Sagar on 05/07/26.
//

import Foundation

class PushNotificationSender: NotificationSending {
    var channelName: String { "Push Notification" }
    func send(title: String, body: String, to recipient: String) async throws { try await Task.sleep(nanoseconds: 300_000_000) }
    func validateRecipient(_ recipient: String) -> Bool { return recipient.count > 10 }
}

class SMSNotificationSender: NotificationSending {
    var channelName: String { "SMS" }
    func send(title: String, body: String, to recipient: String) async throws { try await Task.sleep(nanoseconds: 300_000_000) }
    func validateRecipient(_ recipient: String) -> Bool { return recipient.hasPrefix("+") }
}
