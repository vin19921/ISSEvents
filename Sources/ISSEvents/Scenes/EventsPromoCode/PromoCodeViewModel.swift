//
//  PromoCodeViewModel.swift
//  
//
//  Copyright by iSoftStone 2023.
//

import SwiftUI

public final class PromoCodeViewModel: ObservableObject {
    static let shared = PromoCodeViewModel()
    @Published var promoCode: String = ""
    @Published var promoPrice: Double = 0.00

    func applyPromoCode(code: String, price: Double) {
        promoCode = code
        promoPrice = price
    }

    func resetPromoCode() {
        promoCode = ""
        promoPrice = 0.00
    }
}
