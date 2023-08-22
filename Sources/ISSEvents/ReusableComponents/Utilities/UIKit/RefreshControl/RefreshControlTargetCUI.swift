//
//  File.swift
//  
//
//  Copyright by iSoftStone 2023.
//

import UIKit

final public class RefreshControlTargetCUI: NSObject, ObservableObject {
    // MARK: - Instance properties

    private var contentOffsetObserver: NSKeyValueObservation?
    private var onValueChanged: ((_ refreshControl: UIRefreshControl) -> Void)?

    // MARK: - Public methods

//    public func addRefreshControl(on scrollView: UIScrollView,
//                           refreshControlData: AmwayRefreshControlBuilderCUI.AmwayRefreshControlDataCUI = AmwayRefreshControlBuilderCUI().build(),
//                           onValueChanged: @escaping ((UIRefreshControl) -> Void))
//    {
//        observeContentOffset(scrollView: scrollView)
//
//        guard scrollView.refreshControl == nil else {
//            return
//        }
//
//        let refreshControl = createRefreshControl(refreshControlData: refreshControlData)
//        // In iOS 16, refresh control goes behind the background view.
//        // To avoid this refresh control's zPosition is incremented by 1.
//        refreshControl.layer.zPosition += 1
//        scrollView.refreshControl = refreshControl
//
//        self.onValueChanged = onValueChanged
//    }
//
//    func observeContentOffset(scrollView: UIScrollView) {
//
//        contentOffsetObserver = scrollView.observe(\.contentOffset,
//                                                   options: .new) { _, _ in
//            guard let refreshControl = scrollView.refreshControl as? AmwayRefreshControlCUI,
//                  let view = scrollView.parentViewCUI
//            else {
//                return
//            }
//            refreshControl.updateProgress(with: scrollView.contentOffset.y + view.safeAreaLayoutGuide.layoutFrame.minY)
//        }
//    }
    
    deinit {
        contentOffsetObserver?.invalidate()
        contentOffsetObserver = nil
    }
}

// MARK: - Private methods
extension RefreshControlTargetCUI {

    private func createRefreshControl(refreshControlData: RefreshControlBuilderCUI.RefreshControlDataCUI) -> RefreshControlCUI {
        let refreshControl = RefreshControlCUI()
        refreshControl.data = refreshControlData
        refreshControl.addTarget(self,
                                 action: #selector(onValueChangedAction),
                                 for: .valueChanged)
        return refreshControl
    }

    @objc private func onValueChangedAction(sender: UIRefreshControl) {
        onValueChanged?(sender)
    }
}

