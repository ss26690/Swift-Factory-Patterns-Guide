//
//  NotificationService.swift
//  Swift-Factory-Patterns
//
//  Created by Saurav Sagar on 05/07/26.
//

import Foundation

public enum NotificationChannel: String, CaseIterable, Identifiable {
    case push = "Push Notification"
    case sms = "SMS Gateway"

    public var id: String { self.rawValue }
}

public protocol NotificationService {
    func makeNotificationSender() -> NotificationSending // The Factory Method
}

extension NotificationService {
    // Shared template execution logic across any factory configuration
    public func sendNotification(title: String, body: String, to recipient: String) async throws -> String {
        let sender = makeNotificationSender()
        guard sender.validateRecipient(recipient) else { return "⚠️ Validation Failed for \(sender.channelName)" }
        try await sender.send(title: title, body: body, to: recipient)
        return "✅ Broadcast complete via \(sender.channelName)"
    }
}
