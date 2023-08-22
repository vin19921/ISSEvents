//
//  RefreshControlBuilderCUI.swift
//  
//
//  Copyright by iSoftStone 2023.
//

import UIKit
import ISSTheme

public class RefreshControlBuilderCUI {
    // MARK: - Builder Data Model

    public struct RefreshControlDataCUI {
        let innerCircleColor: UIColor
        let outerCircleColor: UIColor
        let fillColor: UIColor
    }

    // MARK: - Private properties

    private(set) var innerCircleColor: UIColor = Theme.current.loaderBackgroundColor.uiColor
    private(set) var outerCircleColor: UIColor = Theme.current.issWhite.uiColor
    private(set) var fillColor: UIColor = .clear

    // MARK: - Intializer

    public init() {}

    // MARK: - Public functions

    public func setInnerCircleColor(_ innerCircleColor: UIColor) -> RefreshControlBuilderCUI {
        self.innerCircleColor = innerCircleColor
        return self
    }

    public func setOuterCircleColor(_ outerCircleColor: UIColor) -> RefreshControlBuilderCUI {
        self.outerCircleColor = outerCircleColor
        return self
    }

    public func setFillColor(_ fillColor: UIColor) -> RefreshControlBuilderCUI {
        self.fillColor = fillColor
        return self
    }

    public func build() -> RefreshControlDataCUI {
        RefreshControlDataCUI(innerCircleColor: innerCircleColor,
                              outerCircleColor: outerCircleColor,
                              fillColor: fillColor)
    }
}

