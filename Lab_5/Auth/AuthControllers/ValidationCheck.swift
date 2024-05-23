import Foundation

class ValidationCheck {
    
    private static let emailRegEx = "^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}$"
    private static let usernameRegEx = "^[A-Za-z0-9]{4,30}$"
    
    static func isValidEmail(_ email: String) -> Bool {
        let trimmedEmail = email.trimmingCharacters(in: .whitespacesAndNewlines)
        return evaluate(trimmedEmail, with: emailRegEx)
    }
        
    static func isValidUsername(_ username: String) -> Bool {
        let trimmedUsername = username.trimmingCharacters(in: .whitespacesAndNewlines)
        return evaluate(trimmedUsername, with: usernameRegEx)
    }
    
    private static func evaluate(_ string: String, with pattern: String) -> Bool {
        let predicate = NSPredicate(format: "SELF MATCHES %@", pattern)
        return predicate.evaluate(with: string)
    }
}
