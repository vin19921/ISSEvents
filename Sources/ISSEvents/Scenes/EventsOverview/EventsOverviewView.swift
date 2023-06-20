//
//  File.swift
//  
//
//  Created by Wing Seng Chew on 15/06/2023.
//

import SwiftUI

public struct EventsOverviewView: View {

    @ObservedObject private var presenter: EventsOverviewPresenter

    // MARK: Injection

    init(presenter: EventsOverviewPresenter) {
        self.presenter = presenter
    }

    // MARK: View

    public var body: some View {
        ZStack(alignment: .top) {
            VStack(spacing: 0) {
                Text("This is event overview page")
            }
        }
    }
}
