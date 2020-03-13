import UIKit

class ViewController: UIViewController {

    struct UserAsset: Codable {
        let email: String
        let password: String
    }

    private struct UserAssetList: Codable {
        let local: UserAsset
        let bot1: UserAsset
        let bot2: UserAsset
        let bot3: UserAsset
        let bot4: UserAsset
    }

    enum testDevice: String {
        case bot1 = "iPad 5th WiFi_12.0"
        case bot2 = "iPhone 11 Pro_13.3"
        case bot3 = "iPhone 8_11.2.5"
        case bot4 = "iPhone X_11.4.1"
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        let userInfo = getUserAsset()
        print(userInfo)
    }

    func getUserAsset() -> UserAsset {

        let path: URL? = Bundle.main.url(forResource: "users", withExtension: "json")

        let data: Data = try! Data(contentsOf: path!, options: .uncached)

        let userList: UserAssetList = try! JSONDecoder().decode(UserAssetList.self, from: data)

        let deviceName = "iPhone X" // org: YMTGetDeviceName.share.getDeviceName()
        let systemVersion = "11.4.1"// org: UIDevice().systemVersion
        let device = testDevice(rawValue: "\(deviceName)_\(systemVersion)")

        if /*!*/isBitrise() {
            return userList.local
        }

        switch device {
        case .bot1:
            return userList.bot1
        case .bot2:
            return userList.bot2
        case .bot3:
            return userList.bot3
        case .bot4:
            return userList.bot4
        default:
            return userList.local
        }

    }

    func isBitrise() -> Bool {
        return false
    }
}
