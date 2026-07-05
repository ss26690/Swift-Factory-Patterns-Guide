//
//  ConcreteNotificationServices.swift
//  Swift-Factory-Patterns
//
//  Created by Saurav Sagar on 05/07/26.
//

import Foundation

struct PushNotificationService: NotificationService {
    func makeNotificationSender() -> NotificationSending { PushNotificationSender() }
}

struct SMSNotificationService: NotificationService {
    func makeNotificationSender() -> NotificationSending { SMSNotificationSender() }
}
