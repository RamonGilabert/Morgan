import UIKit

class ViewController: UIViewController {

  struct Dimensions {
    static let viewSize: CGFloat = 125
  }

  lazy var animationView: UIView = {
    let view = UIView()
    view.backgroundColor = UIColor.whiteColor()
    view.translatesAutoresizingMaskIntoConstraints = false
    view.layer.cornerRadius = 7.5

    return view
  }()

  override func viewDidLoad() {
    super.viewDidLoad()

    view.addSubview(animationView)
    view.backgroundColor = UIColor(red:0, green:0.56, blue:0.98, alpha:1)

    setupConstraints()
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
}
