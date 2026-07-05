//
//  FactoryMethodDemoView.swift
//  Swift-Factory-Patterns
//
//  Created by Saurav Sagar on 05/07/26.
//

import SwiftUI

struct FactoryMethodDemoView: View {
    @State private var selectedChannel: NotificationChannel = .push
    @State private var recipient: String = "+15551234567"
    @State private var logs: [String] = []

    var body: some View {
        Form {
            Section(header: Text("Routing Channel")) {
                Picker("Channel", selection: $selectedChannel) {
                    ForEach(NotificationChannel.allCases) { channel in
                        Text(channel.rawValue).tag(channel)
                    }
                }
                TextField("Recipient Address/Token", text: $recipient)
            }

            Section {
                Button("Trigger Subclass Factory Execution") {
                    let service: NotificationService = {
                        switch selectedChannel {
                        case .push: return PushNotificationService()
                        case .sms: return SMSNotificationService()
                        }
                    }()

                    Task {
                        let result = try await service.sendNotification(title: "Hello!", body: "Testing Pattern", to: recipient)
                        logs.append(result)
                    }
                }
            }

            Section(header: Text("System Logs")) {
                ForEach(logs, id: \.self) { Text($0).font(.system(.caption, design: .monospaced)) }
            }
        }
        .navigationTitle("Factory Method")
    }
}
