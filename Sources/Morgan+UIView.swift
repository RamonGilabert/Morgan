import UIKit
import Walker

public extension UIView {

  public func shake(_ landscape: Bool = true, duration: TimeInterval = 0.075, completion: (() -> ())? = nil) {
    let x: CGFloat = landscape ? 25 : 0
    let y: CGFloat = landscape ? 0 : 25

    animate(self, duration: duration) {
      $0.transform = CGAffineTransform(translationX: -x, y: -y)
    }.chain(duration: duration) {
      $0.transform = CGAffineTransform(translationX: x, y: y)
    }.chain(duration: duration) {
      $0.transform = CGAffineTransform(translationX: -x / 2, y: -y / 2)
    }.chain(duration: duration) {
      $0.transform = CGAffineTransform.identity
    }.finally {
      completion?()
    }
  }

  // MARK: - Float

  public func levitate(_ duration: TimeInterval = 0.5, times: Float = Float.infinity, completion: (() -> ())? = nil) {
    animate(self, duration: duration, options: [.reverse, .repeat(times)]) {
      $0.transform3D = CATransform3DMakeScale(0.97, 0.97, 0.97)
    }.finally {
      completion?()
    }
  }

  // MARK: - Push

  public func pushDown(_ duration: TimeInterval = 0.15, completion: (() -> ())? = nil) {
    animate(self, duration: duration) {
      $0.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
    }.chain(duration: duration / 2) {
      $0.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
    }.chain(duration: duration / 2) {
      $0.transform = CGAffineTransform.identity
    }.finally {
      completion?()
    }
  }

  public func pushUp(_ duration: TimeInterval = 0.2, completion: (() -> ())? = nil) {
    animate(self, duration: duration) {
      $0.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
    }.chain(duration: duration / 2) {
      $0.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
    }.chain(duration: duration / 2) {
      $0.transform = CGAffineTransform.identity
    }.finally {
      completion?()
    }
  }

  public func peek(_ completion: (() -> ())? = nil) {
    layer.transform = CATransform3DMakeScale(0.01, 0.01, 1)

    spring(self, delay: 0.01, spring: 100, friction: 10, mass: 10) {
      $0.transform = CGAffineTransform.identity
    }.finally {
      completion?()
    }
  }

  // MARK: - Fade

  public func fade(_ appear: Bool = false, duration: TimeInterval = 0.4,
    remove: Bool = false, completion: (() -> ())? = nil) {

      animate(self, duration: duration) {
        $0.alpha = appear ? 1 : 0
      }.finally {
        if remove { self.removeFromSuperview() }

        completion?()
      }
  }

  // MARK: - Transformations

  public func morph(_ duration: TimeInterval = 0.2, completion: (() -> ())? = nil) {
    animate(self, duration: duration) {
      $0.transform = CGAffineTransform(scaleX: 1.3, y: 0.7)
    }.chain(duration: duration) {
      $0.transform = CGAffineTransform(scaleX: 0.7, y: 1.3)
    }.chain(duration: duration) {
      $0.transform = CGAffineTransform(scaleX: 1.2, y: 0.8)
    }.chain(spring: 100, friction: 10, mass: 10) {
      $0.transform = CGAffineTransform.identity
    }.finally {
      completion?()
    }
  }

  public func swing(_ duration: TimeInterval = 0.075, completion: (() -> ())? = nil) {
    animate(self, duration: duration) {
      $0.transform3D = CATransform3DMakeRotation(0.25, 0, 0, 1)
    }.chain(duration: duration) {
      $0.transform3D = CATransform3DMakeRotation(-0.25, 0, 0, 1)
    }.chain(duration: duration) {
      $0.transform3D = CATransform3DMakeRotation(0.1, 0, 0, 1)
    }.chain(duration: duration) {
      $0.transform = CGAffineTransform.identity
    }.finally {
      completion?()
    }
  }

  // MARK: - Fall

  public func fall(_ duration: TimeInterval = 0.15, reset: Bool = false, completion: (() -> ())? = nil) {
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
      $0.transform = CGAffineTransform(translationX: 0, y: 1000)
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

  public func flip(_ duration: TimeInterval = 0.5, vertical: Bool = true, completion: (() -> ())? = nil) {
    let initialZ = layer.zPosition
    let x: CGFloat = vertical ? 0 : 1
    let y: CGFloat = vertical ? 1 : 0

    transform = CGAffineTransform.identity
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

  public func slide(_ duration: TimeInterval = 0.5,
    fade: Bool = true, origin: CGPoint = CGPoint.zero, completion: (() -> ())? = nil) {
      
      let point = origin == CGPoint.zero ? layer.frame.origin : origin
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

  public func disappear(_ duration: TimeInterval = 0.5, reset: Bool = false, completion: (() -> ())? = nil) {
    let anchorPoint = layer.anchorPoint

    layer.anchorPoint = CGPoint(x: 0, y: 0)
    layer.frame.origin = CGPoint(
      x: layer.frame.origin.x - layer.frame.size.width / 2,
      y: layer.frame.origin.y - layer.frame.size.height / 2)

    animate(self, duration: 0.1) {
      $0.transform = CGAffineTransform(translationX: -15, y: 0)
    }.chain(duration: duration) {
      $0.transform = CGAffineTransform(translationX: 500, y: 0)
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

  public func zoom(_ duration: TimeInterval = 0.5, zoomOut: Bool = true, completion: (() -> ())? = nil) {

    if zoomOut {
      animate(self) {
        $0.transform = CGAffineTransform(scaleX: 3, y: 3)
        $0.alpha = 0
      }.finally {
        completion?()
      }
    } else {
      layer.transform = CATransform3DMakeScale(0.01, 0.01, 1)

      spring(self, spring: 75, friction: 10, mass: 10) {
        $0.transform = CGAffineTransform.identity
      }.finally {
        completion?()
      }
    }
  }
}
