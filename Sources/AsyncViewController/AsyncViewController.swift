
import UIKit

public final class AsyncViewController<Content: UIViewController, Loading: UIViewController, Result>: UIViewController {
    
    let makeContentViewController: (Result) -> Content
    let makeLoadingViewController: () -> Loading
    let operation: () async throws -> Result
    var task: Task<Void, any Error>? = nil
    
    public init(
        content: @escaping @Sendable @MainActor (Result) -> Content,
        loading: @escaping @Sendable @MainActor () -> Loading,
        operation: @escaping () async throws -> Result
    ) {
        self.makeContentViewController = content
        self.makeLoadingViewController = loading
        self.operation = operation
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        let loadingViewController = makeLoadingViewController()
        embed(loadingViewController)
        task = Task {
            let result = try await operation()
            let contentViewController = makeContentViewController(result)
            loadingViewController.digup()
            embed(contentViewController)
        }
    }
    
    public override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        task?.cancel()
    }
}

