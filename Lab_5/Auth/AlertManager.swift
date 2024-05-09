import Foundation
import UIKit

class AlertManager {
    private static func showBasicAlert(on vc: UIViewController, with title: String, and message: String?) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: nil))
            vc.present(alert, animated: true)
        }
    }
}

extension AlertManager {
    
    public static func showInvalidEmailAlert(on vc: UIViewController) {
        self.showBasicAlert(on: vc, with: "Invalid Email", and: "Please, enter a valid email")
    } 
    
    public static func showInvalidPasswordAlert(on vc: UIViewController) {
        self.showBasicAlert(on: vc, with: "Invalid Password", and: "Please, enter a valid password")
    }
    
    public static func showInvalidUsernameAlert(on vc: UIViewController) {
        self.showBasicAlert(on: vc, with: "Invalid Username", and: "Please, enter a valid username")
    }
}


//registration errors
extension AlertManager {
    
    public static func showRegistrationErrorAlert(on vc: UIViewController) {
        self.showBasicAlert(on: vc, with: "Registration Error", and: nil)
    }
    
    public static func showRegistrationErrorAlert(on vc: UIViewController, with error: Error) {
        self.showBasicAlert(on: vc, with: "Registration Error", and: "\(error.localizedDescription)")
    }
}

//login errors
extension AlertManager {
    
    public static func showSignInErrorAlert(on vc: UIViewController) {
        self.showBasicAlert(on: vc, with: "Sign In Error", and: nil)
    }
    
    
    public static func showSignInAlert(on vc: UIViewController, with error: Error) {
        self.showBasicAlert(on: vc, with: "Sign In Error", and: "\(error.localizedDescription)")
    }
}

//logout eerors
extension AlertManager {
    
    public static func showLogoutErrorAlert(on vc: UIViewController, with error: Error) {
        self.showBasicAlert(on: vc, with: "Log Out Error", and: "\(error.localizedDescription)")
    }
}

//forgot password errors
extension AlertManager {
    
    public static func showPasswordResetSentAlert(on vc: UIViewController) {
        self.showBasicAlert(on: vc, with: "Password Reset Sent", and: nil)
    }
    
    public static func showErrorSendingPasswordResetAlert(on vc: UIViewController, with error: Error) {
        self.showBasicAlert(on: vc, with: "Error Sending Password Reset", and: "\(error.localizedDescription)")
    }
}

//fetching user errors
extension AlertManager {
    
    public static func showFetchingUserErrorAlert(on vc: UIViewController, with error: Error) {
        self.showBasicAlert(on: vc, with: "Error Fetching User", and: "\(error.localizedDescription)")
    }
    
    public static func showUnknownFetchingUserAlert(on vc: UIViewController) {
        self.showBasicAlert(on: vc, with: "Unknown Fetching User", and: nil)
    }
}




