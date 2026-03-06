//
//  MainTabView.swift
//  UserAuthSDK
//
//  Created by vn5a3fl on 3/5/26.
//


import SwiftUI

struct MainTabView: View {
    var body: some View {
        TabView {
            UserHomeView()
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Home")
                }
            
            ProfileView()
                .tabItem {
                    Image(systemName: "person.fill")
                    Text("Profile")
                }

            UserRegistrationView()
                .tabItem {
                    Image(systemName: "person.crop.circle.fill")
                    Text("Register")
                }

            SettingsView()
                .tabItem {
                    Image(systemName: "gearshape.fill")
                    Text("Settings")
                }
        }
    }
}
