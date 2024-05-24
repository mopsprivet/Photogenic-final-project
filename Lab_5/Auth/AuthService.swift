import Foundation
import FirebaseFirestoreInternal
import FirebaseAuth
import FirebaseFirestore

class AuthService {
    
    public static let shared = AuthService()
    
    private init() {
        
    }
    
    
    //метод для регистрации пользователей
    public func registerUser(with userRequest: RegiserUserRequest, completion: @escaping (Bool, Error?) -> Void) {
        let username = userRequest.username
        let email = userRequest.email
        let password = userRequest.password
                
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
                    if let error = error {
                        completion(false, error)
                        return
                    }
                    
                    guard let resultUser = result?.user else {
                        completion(false, nil)
                        return
                    }
                    
                    let database = Firestore.firestore()
                    database.collection("users").document(resultUser.uid).setData([
                            "username": username,
                            "email": email
                        ]) { error in
                            if let error = error {
                                completion(false, error)
                                return
                            }
                            
                            completion(true, nil)
                        }
                }

    }
    
    
    //метод для авторизации пользователей
    public func signIn(with userRequest: LoginUserRequest, completion: @escaping (Error?)->Void) {
            Auth.auth().signIn(
                withEmail: userRequest.email,
                password: userRequest.password
            ) { result, error in
                if let error = error {
                    completion(error)
                    return
                } else {
                    completion(nil)
                }
            }
        }
        
    //метод для выхода пользователей 
    public func signOut(completion: @escaping (Error?)->Void) {
        do {
            try Auth.auth().signOut()
            completion(nil)
        } catch let error {
            completion(error)
        }
    }
    
    //метод для восстановления пароля 
    public func forgotPassword(with email: String, completion: @escaping (Error?) -> Void) {
        Auth.auth().sendPasswordReset(withEmail: email) { error in
            completion(error)
        }
    }
    
    public func fetchUser(completion: @escaping (UserRequest?, Error?) -> Void) {
            guard let userID = Auth.auth().currentUser?.uid else { return }
            
            let database = Firestore.firestore()
            
            database.collection("users").document(userID).getDocument { snapshot, error in
                if let error = error {
                    completion(nil, error)
                    return
                }
                
                if let snapshot = snapshot,
                    let snapshotData = snapshot.data(),
                    let username = snapshotData["username"] as? String,
                    let email = snapshotData["email"] as? String {
                    let user = UserRequest(username: username, email: email, userID: userID)
                    completion(user, nil)
                }
                    
            }
        }
}



