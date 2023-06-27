//
//  File.swift
//  
//
//  Created by Wing Seng Chew on 15/06/2023.
//

import ISSCommonUI
import ISSTheme
import SwiftUI

public struct EventsOverviewView: View {

    @ObservedObject private var presenter: EventsOverviewPresenter

    // MARK: Injection

    init(presenter: EventsOverviewPresenter) {
        self.presenter = presenter
    }

    // MARK: View

    public var body: some View {
//        ZStack(alignment: .top) {
            VStack(spacing: 0) {
                ISSNavigationBarSUI(data: navigationBarData)
                CarouselView()
                VStack {
                    Spacer()
                    Text("This is event overview page")
                    Text("This is event overview page")
                    Text("This is event overview page")
                    Button(action: {
                       // Handle button tap action
                       print("Button tapped")
                        presenter.fetchEmployee() {_ in }
                    }) {
                       Text("Tap Me")
                           .foregroundColor(.white)
                           .font(.title)
                           .padding()
                           .background(Color.blue)
                           .cornerRadius(10)
                    }
                    Spacer()
                    switch presenter.state {
                    case let .success(_):
                        Text("Success")
                    case .isLoading:
                        Text("Loading...")
                    case .failure(_):
                        Text("Failure")
                    }
                }
            }
            .edgesIgnoringSafeArea(.top)
//        }
    }

    private var navigationBarData: ISSNavigationBarBuilder.ISSNavigationBarData {
        let rightAlignedItem = ToolBarItemDataBuilder()
            .setImage(Image(systemName: "heart"))
            .setCallback {
//                presenter.routeToSavedEvents()
            }
            .build()
        let leftAlignedItem = ToolBarItemDataBuilder()
            .setTitleString("Title")
            .build()
        let toolBarItems = ToolBarItemsDataBuilder()
            .setLeftAlignedItem(leftAlignedItem)
            .setRightAlignedItem(rightAlignedItem)
            .build()
        let issNavBarData = ISSNavigationBarBuilder()
            .setToolBarItems(toolBarItems)
            .setBackgroundColor(Theme.current.darkPurple.color)
            .setTintColor(Theme.current.issWhite.color)
            .includeStatusBarArea(true)
            .build()
        return issNavBarData
    }
}
