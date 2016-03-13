import UIKit
import Morgan

class ViewController: UIViewController {

  struct Dimensions {
    static let viewSize: CGFloat = 125
  }

  lazy var animationView: UIView = {
    let view = UIView()
    view.backgroundColor = UIColor.whiteColor()
    view.translatesAutoresizingMaskIntoConstraints = false
    view.layer.cornerRadius = 7.5
    view.layer.shadowColor = UIColor.blackColor().colorWithAlphaComponent(0.15).CGColor
    view.layer.shadowOffset.height = 5
    view.layer.shadowRadius = 5
    view.layer.shadowOpacity = 1

    return view
  }()

  lazy var tapGesture: UITapGestureRecognizer = { [unowned self] in
    let gesture = UITapGestureRecognizer()
    gesture.addTarget(self, action: "handleTapGesture")

    return gesture
  }()

  override func viewDidLoad() {
    super.viewDidLoad()

    view.addSubview(animationView)
    view.backgroundColor = UIColor(red:0, green:0.56, blue:0.98, alpha:1)

    animationView.addGestureRecognizer(tapGesture)

    setupConstraints()
  }

  // MARK: - Action methods

  func handleTapGesture() {
    tapGesture.enabled = false
    
    switch Int(arc4random_uniform(6)) {
    case 0:
      animationView.shake()
    case 1:
      animationView.levitate(times: 2)
    case 2:
      animationView.morph()
    case 3:
      animationView.swing()
    case 4:
      animationView.fall(reset: true)
    case 5:
      animationView.flip()
    default:
      animationView.fall(reset: true)
    }

    let delayTime = dispatch_time(DISPATCH_TIME_NOW, Int64(1 * Double(NSEC_PER_SEC)))
    dispatch_after(delayTime, dispatch_get_main_queue()) {
      self.tapGesture.enabled = true
    }
  }

  // MARK: - Configuration

  func setupConstraints() {
    NSLayoutConstraint.activateConstraints([
      animationView.widthAnchor.constraintEqualToConstant(Dimensions.viewSize),
      animationView.heightAnchor.constraintEqualToConstant(Dimensions.viewSize),
      animationView.centerXAnchor.constraintEqualToAnchor(view.centerXAnchor),
      animationView.centerYAnchor.constraintGreaterThanOrEqualToAnchor(view.centerYAnchor, constant: -120)
    ])
  }

  // MARK: - Helper methods

  override func preferredStatusBarStyle() -> UIStatusBarStyle {
    return .LightContent
  }
}
