import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  lazy var controller: ViewController = ViewController()

  var window: UIWindow?

  func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
    window = UIWindow()
    window?.frame = UIScreen.mainScreen().bounds
    window?.rootViewController = controller
    window?.makeKeyAndVisible()
    
    return true
  }
}
