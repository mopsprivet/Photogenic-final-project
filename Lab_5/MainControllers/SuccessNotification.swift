import UIKit

extension UIViewController {
    func showToast(message: String, duration: Double, completion: @escaping () -> Void) {
            let toastContainer = UIView(frame: CGRect())
            toastContainer.backgroundColor = UIColor.black.withAlphaComponent(0.8)
            toastContainer.alpha = 0.0
            toastContainer.layer.cornerRadius = 12
            toastContainer.clipsToBounds = true
            
            let toastLabel = UILabel(frame: CGRect())
            toastLabel.textColor = UIColor.white
            toastLabel.textAlignment = .center
            toastLabel.font = UIFont(name: "Montserrat-Light", size: 12.0)
            toastLabel.text = message
            toastLabel.clipsToBounds = true
            toastLabel.numberOfLines = 0
            
            let homeButton = UIButton(type: .system)
            homeButton.setTitle("Home", for: .normal)
            homeButton.setTitleColor(.blue, for: .normal)
            homeButton.addTarget(self, action: #selector(homeButtonTapped), for: .touchUpInside)
            
            toastContainer.addSubview(toastLabel)
            toastContainer.addSubview(homeButton)
            self.view.addSubview(toastContainer)
            
            toastLabel.translatesAutoresizingMaskIntoConstraints = false
            homeButton.translatesAutoresizingMaskIntoConstraints = false
            toastContainer.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                toastLabel.leadingAnchor.constraint(equalTo: toastContainer.leadingAnchor, constant: 12),
                toastLabel.trailingAnchor.constraint(equalTo: toastContainer.trailingAnchor, constant: -12),
                toastLabel.topAnchor.constraint(equalTo: toastContainer.topAnchor, constant: 12),
                
                homeButton.topAnchor.constraint(equalTo: toastLabel.bottomAnchor, constant: 8),
                homeButton.centerXAnchor.constraint(equalTo: toastContainer.centerXAnchor),
                homeButton.bottomAnchor.constraint(equalTo: toastContainer.bottomAnchor, constant: -12),
                
                toastContainer.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 24),
                toastContainer.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -24),
                toastContainer.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -50)
            ])
            
            UIView.animate(withDuration: 0.5, delay: 0.0, options: .curveEaseIn, animations: {
                toastContainer.alpha = 1.0
            }, completion: { _ in
                UIView.animate(withDuration: 0.5, delay: duration, options: .curveEaseOut, animations: {
                    toastContainer.alpha = 0.0
                }, completion: { _ in
                    toastContainer.removeFromSuperview()
                    completion()
                })
            })
        }
        
        @objc func homeButtonTapped() {
            navigationController?.popToRootViewController(animated: true)
        }
}
