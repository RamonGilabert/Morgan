import UIKit
import Walker

public extension UIButton {

  public func buttonDown(completion: (() -> ())? = nil) {
    guard let imageView = imageView else { return }

    imageView.pushDown(completion: {
      completion?()
    })
  }

  public func buttonUp(completion: (() -> ())? = nil) {
    guard let imageView = imageView else { return }

    imageView.pushUp(completion: {
      completion?()
    })
  }
}
