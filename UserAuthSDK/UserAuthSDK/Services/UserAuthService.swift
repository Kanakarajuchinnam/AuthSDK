//
//  UserAuthService.swift
//  UserAuthSDK
//
//  Created by vn5a3fl on 3/4/26.
//

import FirebaseAuth
import FirebaseFirestore

protocol UserAuthServices {
    var auth: Auth { get }
    var firestore: Firestore { get }

    // User Registration
    func userRegistrationWithProfile(
        firstName: String,
        lastName: String,
        address: String,
        phone: String,
        email: String,
        password: String,
        completion: @escaping (Result<User, Error>) -> Void
    )

    // User Login
    func userLogin(email: String, password: String, completion: @escaping (Result<User, Error>) -> Void)

    // User Logout
    func userLogOut() throws
}

class UserAuthService: UserAuthServices {

    static let shared = UserAuthService()

    let auth: Auth
    let firestore: Firestore

    private init() {
        self.auth = Auth.auth()
        self.firestore = Firestore.firestore()
    }

    // User Registration
    func userRegistrationWithProfile(
        firstName: String,
        lastName: String,
        address: String,
        phone: String,
        email: String,
        password: String,
        completion: @escaping (Result<User, Error>) -> Void
    ) {

        auth.createUser(withEmail: email, password: password) { result, error in

            if let error = error {
                completion(.failure(error))
                return
            }

            guard let regUser = result?.user else {
                return
            }

            let userData: [String: Any] = [
                "firstName": firstName,
                "lastName": lastName,
                "address": address,
                "phone": phone,
                "email": email,
                "createdAt": Timestamp()
            ]

            self.firestore
                .collection("users")
                .document(regUser.uid)
                .setData(userData) { error in

                    if let error = error {
                        completion(.failure(error))
                    } else {
                        completion(.success(regUser))
                    }
                }
        }
    }

    // User Login
    func userLogin(email: String, password: String, completion: @escaping(Result<User, Error>) -> Void) {

        auth.signIn(withEmail: email, password: password) { result, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let user = result?.user else { return }
            completion(.success(user))
        }
    }

    // User Logout
    func userLogOut() throws {
        try auth.signOut()
    }
}
