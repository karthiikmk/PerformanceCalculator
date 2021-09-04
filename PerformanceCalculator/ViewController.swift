import UIKit
import OrderedDictionary
import AppDataSerializable

class ViewController: UIViewController {

    @IBOutlet weak var msImage: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()

        let decoder = CodableDecoder<APIArrayResponse<Event>>()
        do {
			let decoded = try decoder.throwableDecode(getDate("Test"))
			debugPrint("✅ Decoded: \(decoded)")
        } catch {
            debugPrint(error)
        }
    }

    func columBreakPoint() {
        let name: [String?] = ["Apple", "Samsung", "Microsoft", "Google", nil]
        let filtered = name.compactMap { $0 }
            .filter { $0.count <= 6 }
            .map { "Tech: \($0)" }
        print(filtered)
    }


    func convertJsonToOrderedDictionary() {
        let decoder = JSONDecoder()
        let url = Bundle.main.url(forResource: "Settings", withExtension: "json")!
        let data = try! Data(contentsOf: url)
        let dict: Dictionary<String, String> = try! decoder.decode([String: String].self, from: data)
        let ordered = OrderedDictionary.init(unsorted: dict) { Int($0.key)! < Int($1.key)! }
        print(ordered)
    }

    func getDate(_ fileName: String) -> Data {
        let url = Bundle.main.url(forResource: fileName, withExtension: "json")!
        let data = try! Data(contentsOf: url)
        return data
    }
}

struct Event: Decodable {
    let id: String
    let eventResponseId: String
    let date: String

    @DecodableType.String
    var count: Int
    @DecodableType.String
    var guests: Int
}

