//
//  File.swift
//  
//
//  Copyright by iSoftStone 2023.
//

import SwiftUI

final class EventsPaymentPresenter: ObservableObject {

//    @StateObject var promoCodeViewModel = PromoCodeViewModel()

    enum State {
        case isLoading
        case failure
        case success
    }

    @Published var state = State.isLoading
}

