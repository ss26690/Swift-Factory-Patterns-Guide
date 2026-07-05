//
//  AbstractFactoryDemoView.swift
//  Swift-Factory-Patterns
//
//  Created by Saurav Sagar on 05/07/26.
//

import SwiftUI

struct AbstractFactoryDemoView: View {
    @State private var isProduction = false
    @State private var consoleOutput: [String] = []

    var body: some View {
        Form {
            Section(header: Text("Environment Matrix Switch")) {
                Toggle(isProduction ? "PRODUCTION DEPLOYMENT" : "SANDBOX ENVIRONMENT", isOn: $isProduction)
            }

            Section {
                Button("Run Checkout Flow Ecosystem") {
                    // Instantiating the unified factory engine ensures families are never mixed!
                    let factory: CheckoutServiceFactory = isProduction ? ProductionCheckoutFactory() : SandboxCheckoutFactory()

                    let paymentSystem = factory.makePaymentProcessor()
                    let receiptSystem = factory.makeReceiptGenerator()

                    Task {
                        let txId = try await paymentSystem.charge(amount: 450.00)
                        let details = receiptSystem.generateReceipt(id: txId, amount: 450.00)
                        consoleOutput.append("Executed: \(txId)")
                        consoleOutput.append(details)
                    }
                }
            }

            Section(header: Text("Unified Infrastructure Output")) {
                ForEach(consoleOutput, id: \.self) { Text($0).font(.system(.caption, design: .monospaced)) }
            }
        }
        .navigationTitle("Abstract Factory")
    }
}
