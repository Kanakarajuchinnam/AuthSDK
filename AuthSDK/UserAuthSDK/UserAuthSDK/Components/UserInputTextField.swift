//
//  UserInputTextField.swift
//  UserAuthSDK
//
//  Created by vn5a3fl on 3/5/26.
//

import SwiftUI

struct UserInputTextField: View {

    let title: String
    @Binding var text: String

    var isSecure: Bool = false
    var keyboardType: UIKeyboardType = .default

    var body: some View {

        VStack(alignment: .leading) {
            Group {
                if isSecure  {
                    SecureField(title, text: $text)
                } else {
                    TextField(title, text: $text)
                }
            }
        }
        .padding(10)
        .background(Color(.systemGray6))
        .cornerRadius(8)
        .keyboardType(keyboardType)
        .textInputAutocapitalization(.never)
        .autocorrectionDisabled(true)
    }
}


