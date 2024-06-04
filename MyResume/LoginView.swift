//
//  LoginView.swift
//  MyResume
//
//  Created by 立大資訊 on 2024/6/4.
//

import SwiftUI
import LineSDK

struct LoginView: View {
    
    @State private var isLoggedIn = false
    @State private var userProfile: UserProfile?
    
    @State private var text = "123"
    
    var body: some View {
        VStack {
            
            Text(text)
            
            if isLoggedIn {
                if let profile = userProfile {
                    Text("Hello, \(profile.displayName)!")
                }
            } else {
                Button(action: {
                    self.loginWithLine()
                }) {
                    Text("Login with LINE")
                        .padding()
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
            }
        }
        .padding()
    }
    
    
    func loginWithLine() {
        LoginManager.shared.login(permissions: [.profile]) { result in
            switch result {
            case .success(let loginResult):
                if let profile = loginResult.userProfile {
                    DispatchQueue.main.async { 
                        text = "User ID: \(profile.userID), User Display Name: \(profile.displayName)"
                        isLoggedIn = true
                        userProfile = profile
                        print("User ID: \(profile.userID)")
                        print("User Display Name: \(profile.displayName)")
                        print("User Icon: \(String(describing: profile.pictureURL))")
                    }
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    print("Login failed: \(error.localizedDescription)")
                    text = "Login failed: \(error.localizedDescription)"
                }
            }
        }
    }
}

#Preview {
    LoginView()
}

