//
//  ContentView.swift
//  Swift-Factory-Patterns
//
//  Created by Saurav Sagar on 05/07/26.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            List {
                Section(header: Text("Creational Patterns")) {
                    NavigationLink(destination: SimpleFactoryDemoView()) {
                        Label("Simple Factory (Payments)", systemImage: "creditcard.fill")
                    }

                    NavigationLink(destination: FactoryMethodDemoView()) {
                        Label("Factory Method (Notifications)", systemImage: "bell.badge.fill")
                    }

                    NavigationLink(destination: AbstractFactoryDemoView()) {
                        Label("Abstract Factory (Environments)", systemImage: "flask.fill")
                    }
                }
            }
            .navigationTitle("Factory Patterns")
        }
    }
}

#Preview {
    ContentView()
}
