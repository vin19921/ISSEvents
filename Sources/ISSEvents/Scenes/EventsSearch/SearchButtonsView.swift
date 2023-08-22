//
//  SearchButtonsView.swift
//  
//
//  Copyright by iSoftStone 2023.
//

import ISSTheme
import SwiftUI

struct SearchButtonsView: View {
    struct ViewData {
        let title: String
        let isSelected: Bool
    }

    private let viewData: ViewData

    init(viewData: ViewData) {
        self.viewData = viewData
    }

    var body: some View {
        Text(viewData.title)
            .fontWithLineHeight(font: Theme.current.bodyTwoMedium.uiFont,
                                lineHeight: Theme.current.bodyTwoMedium.lineHeight,
                                verticalPadding: 16)
            .padding(.horizontal)
            .foregroundColor(viewData.isSelected ? Theme.current.issWhite.color : Theme.current.issBlack.color)
            .background(viewData.isSelected ? Theme.current.issBlack.color : Theme.current.issWhite.color)
            .cornerRadius(12)
    }
}
