import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var msImage: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        columBreakPoint()
    }

    func columBreakPoint() {
        let name: [String?] = ["Apple", "Samsung", "Microsoft", "Google", nil]
        let filtered = name.compactMap { $0 }
            .filter { $0.count <= 6 }
            .map { "Tech: \($0)" }
        print(filtered)
    }
}
