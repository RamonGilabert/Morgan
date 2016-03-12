import UIKit
import Walker

public extension UIButton {

  public func buttonDown(button: UIButton) {
    guard let imageView = button.imageView else { return }

    imageView.pushDown()
  }

  public func buttonUp(button: UIButton) {
    guard let imageView = button.imageView else { return }

    imageView.pushUp()
  }
}
