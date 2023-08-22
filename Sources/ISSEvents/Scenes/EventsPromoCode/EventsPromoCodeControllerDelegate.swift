//
//  File.swift
//  
//
//  Copyright by iSoftStone 2023.
//

import Foundation

protocol EventsPromoCodeControllerDelegate: AnyObject {
    func didApplyPromoCode(_ code: String)
}

final class EventsPromoCodeControllerDelegateWrapper: EventsPromoCodeControllerDelegate {
    private let didApplyPromoCodeClosure: (String) -> Void

    init(didApplyPromoCodeClosure: @escaping (String) -> Void) {
        self.didApplyPromoCodeClosure = didApplyPromoCodeClosure
    }

    func didApplyPromoCode(_ code: String) {
        didApplyPromoCodeClosure(code)
    }
}
