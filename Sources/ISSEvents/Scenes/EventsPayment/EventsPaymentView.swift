//
//  EventsPaymentView.swift
//  
//
//  Copyright by iSoftStone 2023.
//

import SwiftUI

public struct EventsPaymentView: View {
    @ObservedObject private var presenter: EventsPaymentPresenter
    @State private var isPaymentCompleted = false
    @State private var isLoading = true

    @State private var data: [String] = ["Item 1", "Item 2", "Item 3"]
    
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.safeAreaInsets) private var safeAreaInsets

    init(presenter: EventsPaymentPresenter) {
        self.presenter = presenter
    }

    public var body: some View {
        VStack {
            if isLoading {
                ProgressView("Loading...")
                    .progressViewStyle(CircularProgressViewStyle())
                    .padding()
            } else if !isPaymentCompleted {
                PaymentWebView(paymentURLString: "https://www.google.com",
                               paymentCompletionHandler: { success in
                    isPaymentCompleted = success
                })
            } else {
                Text("Payment Completed!")
                Button(action: {
                    self.presentationMode.wrappedValue.dismiss()
                }) {
                    HStack {
                        Text("Go back")
                    }
                }
            }
        }
        .onAppear {
            // Show the loading indicator initially
            isLoading = true

            // Simulate delay to show the loading indicator
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                isLoading = false
                DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                    isPaymentCompleted = true
                }
            }
        }
    }

    func refreshData(completionHandler: (() -> Void)? = nil) {
        data.append("Item \(data.count+1)")
        completionHandler?()
   }
}

private struct SafeAreaInsetsKey: EnvironmentKey {
    static var defaultValue: EdgeInsets {
        (UIApplication.shared.windows.first(where: { $0.isKeyWindow })?.safeAreaInsets ?? .zero).insets
    }
}

extension EnvironmentValues {
    var safeAreaInsets: EdgeInsets {
        self[SafeAreaInsetsKey.self]
    }
}

private extension UIEdgeInsets {
    var insets: EdgeInsets {
        EdgeInsets(top: top, leading: left, bottom: bottom, trailing: right)
    }
}
