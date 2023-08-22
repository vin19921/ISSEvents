//
//  File.swift
//  
//
//  Copyright by iSoftStone 2023.
//

import SwiftUI

extension UIViewController {
    func addToHostingController<T: View>(hostingController: UIHostingController<T>) {
        addChild(hostingController)
        view.addSubview(hostingController.view)

        hostingController.view.translatesAutoresizingMaskIntoConstraints = false
        let constraints = [hostingController.view.topAnchor.constraint(equalTo: view.topAnchor),
                           hostingController.view.leftAnchor.constraint(equalTo: view.leftAnchor),
                           view.bottomAnchor.constraint(equalTo: hostingController.view.bottomAnchor),
                           view.rightAnchor.constraint(equalTo: hostingController.view.rightAnchor)]

        NSLayoutConstraint.activate(constraints)
        hostingController.didMove(toParent: self)
    }

    func present<Content: View>(style: UIModalPresentationStyle = .automatic, @ViewBuilder builder: () -> Content) {
        let toPresent = UIHostingController(rootView: AnyView(EmptyView()))
        toPresent.modalPresentationStyle = style
        toPresent.modalTransitionStyle = .crossDissolve
        toPresent.rootView = AnyView(
            builder()
                .environment(\.viewController, toPresent)
        )
        toPresent.view.backgroundColor = .clear
        NotificationCenter.default.addObserver(forName: Notification.Name(rawValue: "dismissModal"), object: nil, queue: nil) { [weak toPresent] _ in
            toPresent?.dismiss(animated: true, completion: nil)
        }
        present(toPresent, animated: false, completion: nil)
    }

//    func present<Content: View>(style: UIModalPresentationStyle = .automatic, @ViewBuilder builder: () -> Content) {
//        let dimmingView = UIView()
//        dimmingView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
//        dimmingView.translatesAutoresizingMaskIntoConstraints = false
//
//        view.addSubview(dimmingView)
//        NSLayoutConstraint.activate([
//            dimmingView.topAnchor.constraint(equalTo: view.topAnchor),
//            dimmingView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//            dimmingView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
//            dimmingView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
//        ])
//
//        let toPresent = UIHostingController(rootView: AnyView(EmptyView()))
//        toPresent.modalPresentationStyle = style
//        toPresent.modalTransitionStyle = .crossDissolve
//        toPresent.rootView = AnyView(
//            builder()
//                .background(Color.clear)
//        )
//        toPresent.view.backgroundColor = .clear
//
////        weak var weakSelf = self
//        NotificationCenter.default.addObserver(forName: Notification.Name(rawValue: "dismissModal"), object: nil, queue: nil) { [weak toPresent] _ in
//            toPresent?.dismiss(animated: true, completion: nil)
//        }
//        present(toPresent, animated: false, completion: nil)
//    }
}

struct ViewControllerHolder {
    weak var value: UIViewController?
}

struct ViewControllerKey: EnvironmentKey {
    static var defaultValue: ViewControllerHolder {
        return ViewControllerHolder(value: UIApplication.shared.windows.first?.rootViewController)
    }
}

extension EnvironmentValues {
    var viewController: UIViewController? {
        get { return self[ViewControllerKey.self].value }
        set { self[ViewControllerKey.self].value = newValue }
    }
}


//// MARK: - Dim overlay
//
//extension UIViewController {
//    struct OverlayViewData {
//        let backgroundColor: UIColor = .dim
//        let delay: CGFloat = 0.1
//        let duration: CGFloat = 0.5
//        let options: UIView.AnimationOptions = .curveEaseIn
//        var alpha: CGFloat = 0.75
//    }
//
//    func addOverlayView(overlayViewData: OverlayViewData = OverlayViewData()) {
//        let overlayView = UIView(frame: UIScreen.main.bounds)
//
//        overlayView.tag = Tags.dimOverlay.rawValue
//        overlayView.backgroundColor = overlayViewData.backgroundColor
//        UIApplication.shared.currentWindow?.addSubview(overlayView)
//        overlayView.alpha = 0
//        UIView.animate(withDuration: overlayViewData.duration,
//                       delay: overlayViewData.delay,
//                       options: overlayViewData.options,
//                       animations: {
//                           overlayView.alpha = overlayViewData.alpha
//                       })
//    }
//
//    func removeOverlayView() {
//        guard let overlayView = UIApplication.shared.currentWindow?.viewWithTag(Tags.dimOverlay.rawValue) else { return }
//
//        overlayView.removeFromSuperview()
//    }
//}
