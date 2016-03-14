import UIKit
import Walker

public extension UIView {

  public func shake(landscape: Bool = true, duration: NSTimeInterval = 0.075, completion: (() -> ())? = nil) {
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
    }.finally {
      completion?()
    }
  }

  // MARK: - Float

  public func levitate(duration: NSTimeInterval = 0.5, times: Float = Float.infinity, completion: (() -> ())? = nil) {
    animate(self, duration: duration, options: [.Reverse, .Repeat(times)]) {
      $0.transform3D = CATransform3DMakeScale(0.97, 0.97, 0.97)
    }.finally {
      completion?()
    }
  }

  // MARK: - Push

  public func pushDown(duration: NSTimeInterval = 0.15, completion: (() -> ())? = nil) {
    animate(self, duration: duration) {
      $0.transform = CGAffineTransformMakeScale(0.9, 0.9)
    }.chain(duration: duration / 2) {
      $0.transform = CGAffineTransformMakeScale(1.1, 1.1)
    }.chain(duration: duration / 2) {
      $0.transform = CGAffineTransformIdentity
    }.finally {
      completion?()
    }
  }

  public func pushUp(duration: NSTimeInterval = 0.2, completion: (() -> ())? = nil) {
    animate(self, duration: duration) {
      $0.transform = CGAffineTransformMakeScale(1.1, 1.1)
    }.chain(duration: duration / 2) {
      $0.transform = CGAffineTransformMakeScale(0.9, 0.9)
    }.chain(duration: duration / 2) {
      $0.transform = CGAffineTransformIdentity
    }.finally {
      completion?()
    }
  }

  public func peek(completion: (() -> ())? = nil) {
    layer.transform = CATransform3DMakeScale(0.01, 0.01, 1)

    spring(self, delay: 0.01, spring: 100, friction: 10, mass: 10) {
      $0.transform = CGAffineTransformIdentity
    }.finally {
      completion?()
    }
  }

  // MARK: - Fade

  public func fade(appear: Bool = false, duration: NSTimeInterval = 0.4,
    remove: Bool = false, completion: (() -> ())? = nil) {

      animate(self, duration: duration) {
        $0.alpha = appear ? 1 : 0
      }.finally {
        if remove { self.removeFromSuperview() }

        completion?()
      }
  }

  // MARK: - Transformations

  public func morph(duration: NSTimeInterval = 0.2, completion: (() -> ())? = nil) {
    animate(self, duration: duration) {
      $0.transform = CGAffineTransformMakeScale(1.3, 0.7)
    }.chain(duration: duration) {
      $0.transform = CGAffineTransformMakeScale(0.7, 1.3)
    }.chain(duration: duration) {
      $0.transform = CGAffineTransformMakeScale(1.2, 0.8)
    }.chain(spring: 100, friction: 10, mass: 10) {
      $0.transform = CGAffineTransformIdentity
    }.finally {
      completion?()
    }
  }

  public func swing(duration: NSTimeInterval = 0.075, completion: (() -> ())? = nil) {
    animate(self, duration: duration) {
      $0.transform3D = CATransform3DMakeRotation(0.25, 0, 0, 1)
    }.chain(duration: duration) {
      $0.transform3D = CATransform3DMakeRotation(-0.25, 0, 0, 1)
    }.chain(duration: duration) {
      $0.transform3D = CATransform3DMakeRotation(0.1, 0, 0, 1)
    }.chain(duration: duration) {
      $0.transform = CGAffineTransformIdentity
    }.finally {
      completion?()
    }
  }

  // MARK: - Fall

  public func fall(duration: NSTimeInterval = 0.15, reset: Bool = false, completion: (() -> ())? = nil) {
    let initialAnchor = layer.anchorPoint
    let initialOrigin = layer.frame.origin

    layer.anchorPoint = CGPoint(x: 0, y: 0)
    layer.frame.origin = CGPoint(
      x: layer.frame.origin.x - layer.frame.size.width / 2,
      y: layer.frame.origin.y - layer.frame.size.height / 2) 

    animate(self, duration: duration) {
      $0.transform3D = CATransform3DMakeRotation(0.32, 0, 0, 1)
    }.chain(duration: duration / 1.2) {
      $0.transform3D = CATransform3DMakeRotation(0.22, 0, 0, 1)
    }.chain(duration: duration / 1.2) {
      $0.transform3D = CATransform3DMakeRotation(0.25, 0, 0, 1)
      }.chain(delay: 0.25, duration: duration * 4.5) {
      $0.transform = CGAffineTransformMakeTranslation(0, 1000)
    }.finally {
      if reset {
        self.layer.anchorPoint = initialAnchor
        self.layer.transform = CATransform3DIdentity
        self.layer.frame.origin = initialOrigin
      }

      completion?()
    }
  }

  // MARK: - Flip

  public func flip(duration: NSTimeInterval = 0.5, vertical: Bool = true, completion: (() -> ())? = nil) {
    let initialZ = layer.zPosition
    let x: CGFloat = vertical ? 0 : 1
    let y: CGFloat = vertical ? 1 : 0

    layer.zPosition = 400

    var perspective = CATransform3DIdentity
    perspective.m34 = -0.4 / layer.frame.size.width

    let original = CATransform3DRotate(perspective, 0, x, y, 0)
    let rotated = CATransform3DRotate(perspective, CGFloat(M_PI), x, y, 0)

    animate(self, duration: duration) {
      $0.transform3D =
        CATransform3DEqualToTransform(self.layer.transform, original)
        || CATransform3DIsIdentity(self.layer.transform)
        ? rotated : original
    }.finally {
      self.layer.transform = CATransform3DIdentity
      self.layer.zPosition = initialZ

      completion?()
    }
  }

  // MARK: - Appear

  public func slide(duration: NSTimeInterval = 0.5,
    fade: Bool = true, origin: CGPoint = CGPointZero, completion: (() -> ())? = nil) {
      
      let point = origin == CGPointZero ? layer.frame.origin : origin
      let anchorPoint = layer.anchorPoint
      let initialOrigin = layer.frame.origin

      layer.opacity = fade ? 0 : layer.opacity
      layer.frame.origin.x = -500

      animate(self, delay: 0.01, duration: duration) {
        $0.origin = point
        $0.alpha = 1
      }.then {
        self.layer.anchorPoint = CGPoint(x: 0, y: 0)
        self.layer.frame.origin = CGPoint(
          x: self.layer.frame.origin.x - self.layer.frame.size.width / 2,
          y: self.layer.frame.origin.y - self.layer.frame.size.height / 2)
      }.chain(duration: 0.1) {
        $0.transform3D = CATransform3DMakeRotation(-0.075, 0, 0, 1)
      }.chain(spring: 200, friction: 10, mass: 10) {
        $0.transform3D = CATransform3DIdentity
      }.finally {
        self.layer.anchorPoint = anchorPoint
        self.layer.frame.origin = initialOrigin

        completion?()
      }
  }

  // MARK: - Disappear

  public func disappear(duration: NSTimeInterval = 0.5, reset: Bool = false, completion: (() -> ())? = nil) {
    let anchorPoint = layer.anchorPoint

    layer.anchorPoint = CGPoint(x: 0, y: 0)
    layer.frame.origin = CGPoint(
      x: layer.frame.origin.x - layer.frame.size.width / 2,
      y: layer.frame.origin.y - layer.frame.size.height / 2)

    animate(self, duration: 0.1) {
      $0.transform = CGAffineTransformMakeTranslation(-15, 0)
    }.chain(duration: duration) {
      $0.transform = CGAffineTransformMakeTranslation(500, 0)
    }.finally {
      self.layer.anchorPoint = anchorPoint
      self.layer.frame.origin = CGPoint(
        x: self.layer.frame.origin.x + self.layer.frame.size.width / 2,
        y: self.layer.frame.origin.y + self.layer.frame.size.height / 2)

      if reset {
        self.layer.transform = CATransform3DIdentity
      }

      completion?()
    }
  }

  // MARK: - Zoom

  public func zoom(duration: NSTimeInterval = 0.5, zoomOut: Bool = true, completion: (() -> ())? = nil) {

    if zoomOut {
      animate(self) {
        $0.transform = CGAffineTransformMakeScale(3, 3)
        $0.alpha = 0
      }.finally {
        completion?()
      }
    } else {
      layer.transform = CATransform3DMakeScale(0.01, 0.01, 1)

      spring(self, spring: 75, friction: 10, mass: 10) {
        $0.transform = CGAffineTransformIdentity
      }.finally {
        completion?()
      }
    }
  }
}
