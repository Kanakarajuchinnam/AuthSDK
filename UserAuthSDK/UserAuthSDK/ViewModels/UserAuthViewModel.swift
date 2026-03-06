//
//  UserAuthViewModel.swift
//  UserAuthSDK
//
//  Created by vn5a3fl on 3/4/26.
//
import Foundation
import Combine
import FirebaseAuth
import FirebaseCore

class UserAuthViewModel: ObservableObject {

    @Published var userInputDetails = UserInputDetailsModel()
    @Published var isLoading: Bool = false
    @Published var errorMessage: String? = nil
    @Published var isSuccess: Bool = false

    private let userAuthService: UserAuthServices

    init(userAuthService: UserAuthServices) {
        self.userAuthService = userAuthService
    }

    //User Registration
    func registerUser() {
        isLoading = true

        userAuthService.userRegistrationWithProfile(
            firstName: userInputDetails.firstName,
            lastName: userInputDetails.lastName,
            address: userInputDetails.address,
            phone: userInputDetails.phoneNumber,
            email: userInputDetails.email,
            password: userInputDetails.password
        ) { result in
            DispatchQueue.main.async {
                self.isLoading = false

                switch result {
                case .success(_):
                    self.isSuccess = true
                    self.errorMessage = nil
                case .failure(let error):
                    self.isSuccess = false
                    self.errorMessage = error.localizedDescription
                }
            }
        }
    }
}
