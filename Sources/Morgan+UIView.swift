import UIKit
import Walker

public extension UIView {

  public func shake(landscape: Bool = true, duration: NSTimeInterval = 0.075) {
    let x: CGFloat = landscape ? 25 : 0
    let y: CGFloat = landscape ? 0 : 25

    animate(self, duration: duration) {
      $0.transform = CGAffineTransformMakeTranslation(-x, -y)
    }.chain(duration: duration) {
      $0.transform = CGAffineTransformMakeTranslation(x, y)
    }.chain(duration: duration) {
      $0.transform = CGAffineTransformMakeTranslation(-x / 2, -y / 2)
    }.chain(duration: duration) {
      $0.transform = CGAffineTransformIdentity
    }
  }

  // MARK: - Float

  public func levitate(duration: NSTimeInterval = 0.5) {
    animate(self, duration: duration, options: [.Reverse, .Repeat(Float.infinity)]) {
      $0.transform3D = CATransform3DMakeScale(0.97, 0.97, 0.97)
    }
  }

  // MARK: - Push

  public func pushDown(duration: NSTimeInterval = 0.2) {
    animate(self, duration: duration) {
      $0.transform = CGAffineTransformMakeScale(0.9, 0.9)
    }.chain(spring: 200, friction: 10, mass: 10) {
      $0.transform = CGAffineTransformIdentity
    }
  }

  public func pushUp(duration: NSTimeInterval = 0.2) {
    animate(self, duration: duration) {
      $0.transform = CGAffineTransformMakeScale(1.1, 1.1)
    }.chain(spring: 200, friction: 10, mass: 10) {
      $0.transform = CGAffineTransformIdentity
    }
  }

  public func peek() {
    spring(self, spring: 100, friction: 10, mass: 10) {
      $0.transform = CGAffineTransformIdentity
    }
  }

  // MARK: - Fade

  public func fade(appear: Bool = false, duration: NSTimeInterval = 0.4, remove: Bool = false) {
    animate(self, duration: duration) {
      $0.alpha = appear ? 1 : 0
    }.finally {
      if remove { self.removeFromSuperview() }
    }
  }
}

//struct Animator {
//
//  // MARK: - Flipping
//
//  static func flip<T : UIView>(view: T, subview: T, right: Bool = true, duration: NSTimeInterval = 0.6, completion: (() -> Void)? = nil) {
//    let options: UIViewAnimationOptions = right ? .TransitionFlipFromRight : .TransitionFlipFromLeft
//
//    UIView.transitionFromView(view, toView: subview, duration: duration, options: [options, .BeginFromCurrentState, .OverrideInheritedOptions], completion: { _ in
//      completion?()
//    })
//  }
//
//  // MARK: - Floating
//
//  static func float<T: UIView>(view: T) {
//    let duration: NSTimeInterval = 0.75
//
//    UIView.animateWithDuration(duration, delay: 0, options: [.BeginFromCurrentState], animations: {
//      view.transform = CGAffineTransformMakeScale(1.025, 1.025)
//      }, completion: { _ in
//        UIView.animateWithDuration(duration, delay: 0, options: [.Autoreverse, .Repeat, .BeginFromCurrentState], animations: {
//          view.transform = CGAffineTransformMakeScale(0.975, 0.975)
//          }, completion: nil)
//    })
//  }
//
//  // MARK: - Wrapper methods
//
//  static func floatCoupon(coupon: CouponView) {
//    let duration = 1.25
//    let rotation: CGFloat = 0.2
//
//    coupon.layer.zPosition = 400
//
//    UIView.animateWithDuration(0.4, delay: 0, usingSpringWithDamping: 0.65, initialSpringVelocity: 1, options: [], animations: {
//      coupon.alpha = 1
//      coupon.layer.transform = CATransform3DScale(CATransform3DMakeRotation(rotation, 0, 1, 0.25), 1, 1, 1)
//      }, completion: { _ in
//        UIView.animateWithDuration(duration, delay: 0, options: [.Autoreverse, .Repeat, .BeginFromCurrentState], animations: {
//          coupon.layer.transform = CATransform3DMakeRotation(-rotation, 0, 1, 0.25)
//          coupon.reflectionView.layer.transform = CATransform3DMakeRotation(-rotation * 1.5, 1, 0.5, 0.15)
//          }, completion: nil)
//    })
//  }
//
//  static func pushButtonDown(button: UIButton) {
//    guard let imageView = button.imageView else { return }
//    pushDown(imageView)
//  }
//
//  static func pushButtonUp(button: UIButton) {
//    guard let imageView = button.imageView else { return }
//    pushUp(imageView)
//  }
//}

