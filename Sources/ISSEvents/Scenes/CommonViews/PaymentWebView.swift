//
//  File.swift
//  
//
//  Copyright by iSoftStone 2023.
//

import SwiftUI
import WebKit

struct PaymentWebView: UIViewRepresentable {
    let paymentURLString: String
    let paymentCompletionHandler: (Bool) -> Void
    
    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        webView.navigationDelegate = context.coordinator
        return webView
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        if let url = URL(string: paymentURLString) {
            let request = URLRequest(url: url)
            DispatchQueue.main.async {
                uiView.load(request)
            }
        }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, WKNavigationDelegate {
        var parent: PaymentWebView
        
        init(_ parent: PaymentWebView) {
            self.parent = parent
        }
        
        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
            // Detect if the payment is completed
            if webView.url?.absoluteString.contains("payment-success") == true {
                DispatchQueue.main.async {
                    self.parent.paymentCompletionHandler(true)
                }
            } else {
                DispatchQueue.main.async {
                    self.parent.paymentCompletionHandler(false)
                }
            }
        }
    }
}
