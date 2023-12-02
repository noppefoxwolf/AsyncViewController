import SwiftUI
import AsyncViewController

@main
struct App: SwiftUI.App {
    var body: some Scene {
        WindowGroup {
            ViewController()
        }
    }
}

struct ViewController: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> some UIViewController {
        ParentViewController()
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        
    }
}

class ParentViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        let vc = AsyncViewController(
            content: {
                UIHostingController(
                    rootView: Text($0)
                )
            },
            loading: {
                UIHostingController(
                    rootView: ProgressView().progressViewStyle(.circular)
                )
            },
            operation: {
                try await Task.sleep(for: .seconds(3))
                print("ok")
                return "Hello"
            }
        )
        present(vc, animated: true)
    }
}


