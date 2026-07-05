//
//  SimpleFactoryDemoView.swift
//  Swift-Factory-Patterns
//
//  Created by Saurav Sagar on 05/07/26.
//

import SwiftUI

struct SimpleFactoryDemoView: View {
    @State private var selectedMethod: PaymentMethod = .creditCard
    @State private var inputAmount: String = "99.99"
    @State private var logs: [String] = []
    @State private var isProcessing = false

    var body: some View {
        Form {
            Section(header: Text("Configuration")) {
                Picker("Payment Method", selection: $selectedMethod) {
                    ForEach(PaymentMethod.allCases) { method in
                        Text(method.rawValue).tag(method)
                    }
                }
                TextField("Amount", text: $inputAmount)
                    .keyboardType(.decimalPad)
            }

            Section {
                Button(action: executePayment) {
                    if isProcessing {
                        ProgressView()
                    } else {
                        Text("Process with Factory")
                            .frame(maxWidth: .infinity)
                    }
                }
                .disabled(isProcessing)
            }

            Section(header: Text("Console Output")) {
                ForEach(logs, id: \.self) { log in
                    Text(log).font(.system(.caption, design: .monospaced))
                }
            }
        }
        .navigationTitle("Simple Factory")
    }

    private func executePayment() {
        guard let amount = Double(inputAmount) else { return }
        isProcessing = true

        Task {
            // Client interactions happen only through abstractions!
            let processor = PaymentProcessorFactory.makeProcessor(for: selectedMethod)
            logs.append("⚡ Factory built: \(processor.name)")

            do {
                let result = try await processor.charge(amount: amount)
                logs.append("✅ Success! Txn ID: \(result.transactionId)")
            } catch {
                logs.append("❌ Error processing payment")
            }
            isProcessing = false
        }
    }
}
