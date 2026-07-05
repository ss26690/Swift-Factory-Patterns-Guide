//
//  NotificationProtocols.swift
//  Swift-Factory-Patterns
//
//  Created by Saurav Sagar on 05/07/26.
//

import Foundation

public protocol NotificationSending {
    var channelName: String { get }
    func send(title: String, body: String, to recipient: String) async throws
    func validateRecipient(_ recipient: String) -> Bool
}
