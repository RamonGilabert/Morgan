import UIKit
import Morgan
import Walker

class ViewController: UIViewController {

  struct Dimensions {
    static let viewSize: CGFloat = 125
  }

  lazy var animationView: UIView = {
    let view = UIView()
    view.backgroundColor = UIColor.white
    view.translatesAutoresizingMaskIntoConstraints = false
    view.layer.cornerRadius = 7.5
    view.layer.shadowColor = UIColor.black.withAlphaComponent(0.15).cgColor
    view.layer.shadowOffset.height = 5
    view.layer.shadowRadius = 5
    view.layer.shadowOpacity = 1

    return view
  }()

  lazy var codeLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont(name: "Menlo-Regular", size: 16)
    label.textColor = UIColor.white
    label.textAlignment = .center
    label.text = "Tap the view to animate"
    label.translatesAutoresizingMaskIntoConstraints = false

    return label
  }()

  lazy var tapGesture: UITapGestureRecognizer = { [unowned self] in
    let gesture = UITapGestureRecognizer()
    gesture.addTarget(self, action: #selector(ViewController.handleTapGesture))

    return gesture
  }()

  override func viewDidLoad() {
    super.viewDidLoad()

    [codeLabel, animationView].forEach { view.addSubview($0) }

    view.backgroundColor = UIColor(red:0, green:0.56, blue:0.98, alpha:1)

    animationView.addGestureRecognizer(tapGesture)

    setupConstraints()
  }

  // MARK: - Action methods

  func handleTapGesture() {
    closeDistilleries()
    animationView.layer.transform = CATransform3DIdentity

    switch Int(arc4random_uniform(6)) {
    case 0:
      animationView.shake()
      codeLabel.text = "view.shake()"
    case 1:
      animationView.levitate(times: 2)
      codeLabel.text = "view.levitate()"
    case 2:
      animationView.morph()
      codeLabel.text = "view.morph()"
    case 3:
      animationView.swing()
      codeLabel.text = "view.swing()"
    case 4:
      animationView.peek()
      codeLabel.text = "view.peek()"
    case 5:
      animationView.flip()
      codeLabel.text = "view.flip()"
    default:
      animationView.peek()
      codeLabel.text = "view.peek()"
    }
  }

  // MARK: - Configuration

  func setupConstraints() {
    NSLayoutConstraint.activate([
      codeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      codeLabel.centerYAnchor.constraint(greaterThanOrEqualTo: animationView.topAnchor, constant: -75),

      animationView.widthAnchor.constraint(equalToConstant: Dimensions.viewSize),
      animationView.heightAnchor.constraint(equalToConstant: Dimensions.viewSize),
      animationView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      animationView.centerYAnchor.constraint(greaterThanOrEqualTo: view.centerYAnchor, constant: -120)
    ])
  }

  // MARK: - Helper methods

  override var preferredStatusBarStyle : UIStatusBarStyle {
    return .lightContent
  }
}
