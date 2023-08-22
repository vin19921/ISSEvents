//
//  File.swift
//  
//
//  Copyright by iSoftStone 2023.
//

import ISSCommonUI
import ISSTheme
import SwiftUI

struct NavBarAppearance {
    var title: String
    var font: UIFont = Theme.current.headline4.uiFont
    var smallTitleFont: UIFont = Theme.current.subtitle2.uiFont
    var bgColor: UIColor = Theme.current.backgroundGray.uiColor
    var tintColor: UIColor = Theme.current.issWhite.uiColor
    var leftBarButton: BarButtonInfo?
    var middleContent: TextFieldBarItem<Text>?
    var rightBarButton: BarButtonInfo?
}

struct BarButtonInfo {
    var image: UIImage?
    var accessibilityId: String?
}

struct TextFieldBarItem<Label: View> {
    var textfield: TextField<Label>?
    var accessibilityId: String?
}
