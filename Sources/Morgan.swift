import UIKit

public struct Morgan {

  // MARK: - Transitions

  public static func flip<T : UIView>(_ view: T, subview: T,
    right: Bool = true, duration: TimeInterval = 0.6,
    completion: (() -> ())? = nil) {

      let options: UIViewAnimationOptions = right
        ? .transitionFlipFromRight : .transitionFlipFromLeft

      UIView.transition(from: view, to: subview,
        duration: duration, options: [options,
          .beginFromCurrentState, .overrideInheritedOptions],
        completion: { _ in
          completion?()
      })
  }
}
