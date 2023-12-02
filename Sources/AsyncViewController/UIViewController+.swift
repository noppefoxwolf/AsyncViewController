import UIKit

extension UIViewController {
    func embed(_ viewController: UIViewController) {
        viewController.willMove(toParent: self)
        view.addSubview(viewController.view)
        viewController.view.translatesAutoresizingMaskIntoConstraints = false
        addChild(viewController)
        viewController.didMove(toParent: self)
        NSLayoutConstraint.activate([
            viewController.view.topAnchor.constraint(equalTo: view.topAnchor),
            view.bottomAnchor.constraint(equalTo: viewController.view.bottomAnchor),
            viewController.view.leftAnchor.constraint(equalTo: view.leftAnchor),
            view.rightAnchor.constraint(equalTo: viewController.view.rightAnchor),
        ])
    }
    
    @discardableResult
    func digup() -> UIViewController {
        willMove(toParent: nil)
        view.removeFromSuperview()
        removeFromParent()
        didMove(toParent: nil)
        return self
    }
}
