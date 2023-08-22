//
//  UIViewController+Extension.swift
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
