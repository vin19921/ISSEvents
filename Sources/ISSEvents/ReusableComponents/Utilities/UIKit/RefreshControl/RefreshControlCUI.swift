//
//  File.swift
//  
//
//  Copyright by iSoftStone 2023.
//

import SwiftUI
import UIKit

final public class RefreshControlCUI: UIRefreshControl, NibLoadableCUI {
    @IBOutlet private var contentView: UIView!
    @IBOutlet private var containerView: UIView!
    @IBOutlet private var circularLoadingView: CircularLoadingViewCUI!
    @IBOutlet private var heightConstraintForContainerView: NSLayoutConstraint!
    @IBOutlet private var topConstraintForCircularLoadingView: NSLayoutConstraint!
    @IBOutlet private var bottomConstraintForCircularLoadingView: NSLayoutConstraint!

    public var data: RefreshControlBuilderCUI.RefreshControlDataCUI? {
        didSet {
            setCircularLoadingViewData()
        }
    }

    private let maxPullDistance: CGFloat = 150
    // panDistance = height of CircularLoadingView
    //               + CircularLoadingView topconstratint to containerView constant
    //               + CircularLoadingView bottomConstraint to containerView constant
    private let panDistanceToTop: CGFloat = 64

    public override init() {
        super.init(frame: .zero)

        setup()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)

        setup()
    }

    public override func beginRefreshing() {
        super.beginRefreshing()

        circularLoadingView.isAnimating = true
    }

    public override func endRefreshing() {
        super.endRefreshing()

        circularLoadingView.isAnimating = false
    }

    // MARK: - Public Methods

    func updateProgress(with offsetY: CGFloat) {
        guard !circularLoadingView.isAnimating else { return }

        let progress = min(abs(offsetY / maxPullDistance), 1)
        circularLoadingView.updateProgress(with: progress)

        // offsetY is comes as negative when we pull, hence taking absolute value to add get postive value.
        // Default: topConstraint priority is low, bottomConstraint Priority is High
        // Reason: Pulling the refresh control will pull the circularViw From above without maintaining its top Constraint.
        // Logic: in `if` block Pulling beyond `panDistanceToTop` will make sure the CircularView Maintains it top constraint,
        // without maintaining the bottom space.
        heightConstraintForContainerView.constant = abs(offsetY)
        if abs(offsetY) > panDistanceToTop {
            // Keeping the top constraint priority high to keep the distance from top fixed.
            // Keeping the bottom constraint priority low to avoid the fixed distance from bottom.
            bottomConstraintForCircularLoadingView.priority = .defaultLow
            topConstraintForCircularLoadingView.priority = .defaultHigh
        } else {
            // Vice-versa
            topConstraintForCircularLoadingView.priority = .defaultLow
            bottomConstraintForCircularLoadingView.priority = .defaultHigh
        }
        containerView.layoutIfNeeded()
    }
}

// MARK: - Private Methods

private extension RefreshControlCUI {
    func setup() {
        loadFromNib(needSafeAreaInset: false)
//        setupAutomationIdentifiers()
        additionalSetup()
    }

    func additionalSetup() {
        heightConstraintForContainerView.constant = 0
        tintColor = .clear
        addTarget(self,
                  action: #selector(beginRefreshing),
                  for: .valueChanged)
    }

    func setCircularLoadingViewData() {
        guard let innerCircleColor = data?.innerCircleColor,
              let outerCircleColor = data?.outerCircleColor,
              let fillColor = data?.fillColor else { return }

        let circularLoadingViewData = CircularLoadingViewBuilderCUI()
            .setColors(CircularLoadingViewBuilderCUI.CircularLoadingViewColorsCUI(backgroundLayerColor: innerCircleColor,
                                                                            foregroundLayerColor: outerCircleColor,
                                                                            fillColor: fillColor))
            .build()
        circularLoadingView.data = circularLoadingViewData
    }
}

// MARK: - Automation Ids
//
//private extension RefreshControlCUI {
//    enum AutomationControl: String, AccessibilityIdentifierProviderCUI {
//        case refreshControl
//    }
//
//    func setupAutomationIdentifiers() {
//        accessibilityIdentifier = AutomationControl.refreshControl.accessibilityIdentifier()
//    }
//}
