//
//  File.swift
//  
//
//  Copyright by iSoftStone 2023.
//

import ISSTheme
import UIKit

public class CircularLoadingViewBuilderCUI {
    // MARK: - Builder Data Model

    public struct CircularLoadingViewDataCUI {
        let colors: CircularLoadingViewColorsCUI
        let lineWidth: CGFloat
        let lineCap: CAShapeLayerLineCap
        let strokeStartAnimation: StrokeAnimationCUI
        let strokeEndAnimation: StrokeAnimationCUI
        let strokeAnimationDuration: CFTimeInterval
        let strokeAnimationRepeatDuration: CFTimeInterval
        let rotationAnimation: RotationAnimationCUI

        public init(colors: CircularLoadingViewBuilderCUI.CircularLoadingViewColorsCUI,
                    lineWidth: CGFloat,
                    lineCap: CAShapeLayerLineCap,
                    strokeStartAnimation: CircularLoadingViewBuilderCUI.StrokeAnimationCUI,
                    strokeEndAnimation: CircularLoadingViewBuilderCUI.StrokeAnimationCUI,
                    strokeAnimationDuration: CFTimeInterval,
                    strokeAnimationRepeatDuration: CFTimeInterval,
                    rotationAnimation: CircularLoadingViewBuilderCUI.RotationAnimationCUI)
        {
            self.colors = colors
            self.lineWidth = lineWidth
            self.lineCap = lineCap
            self.strokeStartAnimation = strokeStartAnimation
            self.strokeEndAnimation = strokeEndAnimation
            self.strokeAnimationDuration = strokeAnimationDuration
            self.strokeAnimationRepeatDuration = strokeAnimationRepeatDuration
            self.rotationAnimation = rotationAnimation
        }
    }

    public struct CircularLoadingViewColorsCUI {
        let backgroundLayerColor: UIColor
        let foregroundLayerColor: UIColor
        let fillColor: UIColor

        public init(backgroundLayerColor: UIColor,
                    foregroundLayerColor: UIColor,
                    fillColor: UIColor)
        {
            self.backgroundLayerColor = backgroundLayerColor
            self.foregroundLayerColor = foregroundLayerColor
            self.fillColor = fillColor
        }
    }

    public struct StrokeAnimationCUI {
        let keyPath: StrokeAnimationKeyPath
        let beginTime: CFTimeInterval
        let fromValue: CGFloat
        let toValue: CGFloat
        let duration: CFTimeInterval
        let timingFunction: CAMediaTimingFunction

        public enum StrokeAnimationKeyPath: String {
            case strokeStart
            case strokeEnd
        }

        public init(keyPath: StrokeAnimationKeyPath,
                    beginTime: CFTimeInterval,
                    fromValue: CGFloat = 0.0,
                    toValue: CGFloat = 1.0,
                    duration: CFTimeInterval = 0.75,
                    timingFunction: CAMediaTimingFunction = .init(name: .easeInEaseOut))
        {
            self.keyPath = keyPath
            self.beginTime = beginTime
            self.fromValue = fromValue
            self.toValue = toValue
            self.duration = duration
            self.timingFunction = timingFunction
        }
    }

    public struct RotationAnimationCUI {
        let keyPath: RotationAnimationKeyPath
        let fromValue: CGFloat
        let toValue: CGFloat
        let duration: CFTimeInterval
        let repeatCount: Float

        public enum RotationAnimationKeyPath: String {
            case rotateX = "transform.rotation.x"
            case rotateY = "transform.rotation.y"
            case rotateZ = "transform.rotation.z"
        }

        public init(keyPath: RotationAnimationKeyPath,
                    fromValue: CGFloat,
                    toValue: CGFloat,
                    duration: CFTimeInterval,
                    repeatCount: Float)
        {
            self.keyPath = keyPath
            self.fromValue = fromValue
            self.toValue = toValue
            self.duration = duration
            self.repeatCount = repeatCount
        }
    }

    // MARK: - Private properties

    private(set) var colors: CircularLoadingViewColorsCUI =
        CircularLoadingViewColorsCUI(backgroundLayerColor: Theme.current.loaderBackgroundColor.uiColor,
                                     foregroundLayerColor: Theme.current.issWhite.uiColor,
                                     fillColor: .clear)
    private(set) var lineWidth: CGFloat = 4
    private(set) var lineCap: CAShapeLayerLineCap = .round
    private(set) var strokeStartAnimation: StrokeAnimationCUI =
        StrokeAnimationCUI(keyPath: .strokeStart,
                           beginTime: 0.5)
    private(set) var strokeEndAnimation: StrokeAnimationCUI =
        StrokeAnimationCUI(keyPath: .strokeEnd,
                           beginTime: 0.0)
    private(set) var rotationAnimation: RotationAnimationCUI =
        RotationAnimationCUI(keyPath: .rotateZ,
                             fromValue: 0,
                             toValue: .pi * 2,
                             duration: 2.0,
                             repeatCount: .greatestFiniteMagnitude)
    private(set) var strokeAnimationDuration: CFTimeInterval = 1.0
    private(set) var strokeAnimationRepeatDuration: CFTimeInterval = .infinity

    // MARK: - Intializer

    public init() {}

    // MARK: - Public functions

    public func setColors(_ colors: CircularLoadingViewColorsCUI) -> CircularLoadingViewBuilderCUI {
        self.colors = colors
        return self
    }

    public func setLineWidth(_ lineWidth: CGFloat) -> CircularLoadingViewBuilderCUI {
        self.lineWidth = lineWidth
        return self
    }

    public func setLineCap(_ lineCap: CAShapeLayerLineCap) -> CircularLoadingViewBuilderCUI {
        self.lineCap = lineCap
        return self
    }

    public func setStrokeStartAnimation(_ strokeStartAnimation: StrokeAnimationCUI) -> CircularLoadingViewBuilderCUI {
        self.strokeStartAnimation = strokeStartAnimation
        return self
    }

    public func setStrokeEndAnimation(_ strokeEndAnimation: StrokeAnimationCUI) -> CircularLoadingViewBuilderCUI {
        self.strokeEndAnimation = strokeEndAnimation
        return self
    }

    public func setRotationAnimation(_ rotationAnimation: RotationAnimationCUI) -> CircularLoadingViewBuilderCUI {
        self.rotationAnimation = rotationAnimation
        return self
    }

    public func setStrokeAnimationDuration(_ strokeAnimationDuration: CFTimeInterval) -> CircularLoadingViewBuilderCUI {
        self.strokeAnimationDuration = strokeAnimationDuration
        return self
    }

    public func setStrokeAnimationRepeatDuration(_ strokeAnimationRepeatDuration: CFTimeInterval) -> CircularLoadingViewBuilderCUI {
        self.strokeAnimationRepeatDuration = strokeAnimationRepeatDuration
        return self
    }

    public func build() -> CircularLoadingViewDataCUI {
        CircularLoadingViewDataCUI(colors: colors,
                                   lineWidth: lineWidth,
                                   lineCap: lineCap,
                                   strokeStartAnimation: strokeStartAnimation,
                                   strokeEndAnimation: strokeEndAnimation,
                                   strokeAnimationDuration: strokeAnimationDuration,
                                   strokeAnimationRepeatDuration: strokeAnimationRepeatDuration,
                                   rotationAnimation: rotationAnimation)
    }
}

