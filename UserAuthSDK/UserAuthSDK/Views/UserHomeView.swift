//
//  UserHomeView.swift
//  UserAuthSDK
//
//  Created by vn5a3fl on 3/4/26.
//

import SwiftUI

struct UserHomeView: View {
    @State private var isLoading: Bool = false

    @StateObject var userAuthViewModel = UserAuthViewModel(userAuthService: UserAuthService.shared)

    var body: some View {
        VStack(spacing: 16) {
            if userAuthViewModel.isLoading {
                ProgressView()
            } else {
                Text("Welcome \(userAuthViewModel.userInputDetails.firstName)")
                    .font(.largeTitle)
                    .padding(8)
            }
        }
        .background(Color(.yellow))
        .padding()
    }
}
