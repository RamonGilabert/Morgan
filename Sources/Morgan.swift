import UIKit

public struct Morgan {

  // MARK: - Transitions

  public static func flip<T : UIView>(view: T, subview: T,
    right: Bool = true, duration: NSTimeInterval = 0.6,
    completion: (() -> Void)? = nil) {

      let options: UIViewAnimationOptions = right
        ? .TransitionFlipFromRight : .TransitionFlipFromLeft

      UIView.transitionFromView(view, toView: subview,
        duration: duration, options: [options,
          .BeginFromCurrentState, .OverrideInheritedOptions],
        completion: { _ in
          completion?()
      })
  }
}
