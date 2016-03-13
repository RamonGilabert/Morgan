import UIKit
import Walker

public extension UIButton {

  public func buttonDown(button: UIButton, completion: (() -> ())? = nil) {
    guard let imageView = button.imageView else { return }

    imageView.pushDown(completion: {
      completion?()
    })
  }

  public func buttonUp(button: UIButton, completion: (() -> ())? = nil) {
    guard let imageView = button.imageView else { return }

    imageView.pushUp(completion: {
      completion?()
    })
  }
}
