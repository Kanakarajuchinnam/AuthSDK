//
//  UserRegistrationView.swift
//  UserAuthSDK
//
//  Created by vn5a3fl on 3/4/26.
//

import SwiftUI
import Combine

struct UserRegistrationView: View {

    @State private var form = UserInputDetailsModel()

    @State private var isLoading: Bool = false
    @State private var isSuccess: Bool = false
    @State private var errorMessage: String = ""
    @State private var navigateToProfile: Bool = false

    var body: some View {
        NavigationStack {
            VStack(alignment: .center, spacing: 20) {
                ScrollView {
                    VStack(alignment: .leading, spacing: 10) {
                        Text("User Register")
                            .font(.largeTitle)
                            .foregroundColor(Color(.blue))
                            .cornerRadius(8)
                        
                        UserInputTextField(
                            title: "First Name",
                            text: $form.firstName)
                        
                        UserInputTextField(
                            title: "Last Name",
                            text: $form.lastName)
                        
                        UserInputTextField(
                            title: "Address",
                            text: $form.address)
                        
                        UserInputTextField(
                            title: "Phone",
                            text: $form.phoneNumber,
                            keyboardType: .phonePad)
                        
                        UserInputTextField(
                            title: "Email",
                            text: $form.email,
                            keyboardType: .emailAddress)
                        
                        UserInputTextField(
                            title: "Password",
                            text: $form.password,
                            isSecure: true)
                    }
                    
                    Button("Register Me", action: {
                        isLoading = true
                        UserAuthService.shared.userRegistrationWithProfile(
                            firstName: form.firstName,
                            lastName: form.lastName,
                            address: form.address,
                            phone: form.phoneNumber,
                            email: form.email,
                            password: form.password
                        ) { result in
                            isLoading = false
                            switch result {
                            case .success(let user):
                                isSuccess = true
                                errorMessage = ""
                                print("Successfully registered: \(user)")
                                navigateToProfile = true
                            case .failure(let error):
                                isSuccess = false
                                errorMessage = "Failed to register: \(error.localizedDescription)"
                                print("Failed to register: \(error)")
                            }
                        }
                    })
                }
                .padding(8)
                .cornerRadius(8)
                .background(Color(.yellow))
            }
            // New iOS 16+ style boolean-driven navigation
            .navigationDestination(isPresented: $navigateToProfile) {
                MainTabView()
            }
        }
    }
}
