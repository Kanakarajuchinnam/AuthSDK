//
//  UserLoginView.swift
//  UserAuthSDK
//
//  Created by vn5a3fl on 3/4/26.
//

import SwiftUI
import FirebaseAuth
import Observation

struct UserLoginView: View {

    @State private var email: String = ""
    @State private var password: String = ""
    @State private var isLoading: Bool = false
    @State private var isSuccess: Bool = false
    @State private var errorMessage: String = ""

    var body: some View {
        NavigationStack {
            VStack(alignment: .center, spacing: 20) {
                Image(systemName:"globe")
                    .font(.largeTitle)
                    .padding(8)
                UserInputTextField(title: "Email", text: $email)
                UserInputTextField(title: "Password", text: $password, isSecure: true)
                Button("Login") {
                    isLoading.toggle()
                    
                    UserAuthService.shared.userLogin(email: email, password: password) { result in
                        switch result {
                        case .success:
                            Task { @MainActor in
                                isSuccess = true
                            }

                        case .failure(_):
                            Task { @MainActor in
                                self.errorMessage = "User Login Failed"
                            }
                        }
                    }
                }
                NavigationLink("User Registration?") {
                    UserRegistrationView()
                }
                NavigationLink("Forget Password?") {
                    ResetPasswordView()
                }
               Text(errorMessage)
                    .foregroundColor(.red)
            }
            .padding()
        }
    }
}
