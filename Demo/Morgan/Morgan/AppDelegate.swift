import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  lazy var controller: ViewController = ViewController()

  var window: UIWindow?

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
    window = UIWindow()
    window?.frame = UIScreen.main.bounds
    window?.rootViewController = controller
    window?.makeKeyAndVisible()
    
    return true
  }
}
