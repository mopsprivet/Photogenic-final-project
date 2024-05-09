import UIKit

class AuthenticationViewController: UIViewController {
    
    private let label: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 24, weight: .semibold)
        label.text = "Loading..."
        label.numberOfLines = 2
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
        self.label.text = "mopsprivet\nsitchenko.aa@gmail.com"
        
    }
    
    private func setupUI() {
        self.view.backgroundColor = #colorLiteral(red: 0.1255135536, green: 0.135696739, blue: 0.1907175183, alpha: 1)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(didTapLogout))
        self.view.addSubview(label)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.label.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.label.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)
            
        ])
        
    }
    
    @objc private func didTapLogout() {
        
    }
    
}
