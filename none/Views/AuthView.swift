//
//  AuthView.swift
//  none
//
//  Created by Max Vaughan on 17.04.2025.
//
import SwiftUI

struct RegisterView: View {
    @State var email: String = ""
    @State var password: String = ""
    @State var confirmationPassword: String = ""

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Register")
                .font(.largeTitle)
                .fontWeight(.regular)
                .foregroundStyle(Color.primaryLabel)

            AuthTextField(placeholderText: "Email", email: $email)

            AuthPasswordField(password: $password)

            AuthPasswordField(password: $confirmationPassword)

            Button("NEXT", action: {
                print("Proceeding with login...")
                guard password == confirmationPassword else {
                    print("Password did not match")
                    return
                }
                guard APIManager.shared.validateEmail(email) else {
                    print("Invalid email")
                    return
                }
                APIManager.shared.signup(email: email, password: password)
            })
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color.tertiaryBg)
            .foregroundStyle(.primaryLabel)
            .clipShape(.buttonBorder)
            .fontWeight(.bold)

            Spacer()
        }
        .padding(.top, 100)
        .padding(.horizontal)
        .background(Color.primaryBg)
    }
}

struct LoginView: View {
    @State var email: String = ""
    @State var password: String = ""

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Login")
                .font(.largeTitle)
                .fontWeight(.regular)
                .foregroundStyle(Color.primaryLabel)

            AuthTextField(placeholderText: "Email", email: $email)

            AuthPasswordField(password: $password)

            Button("Forgot Password?") {
                print("Forgot")
            }
            .frame(maxWidth: .infinity, alignment: .trailing)
            .foregroundStyle(.secondaryLabel)
            .underline()

            Button("NEXT", action: {
                print("Proceeding with login...")
                guard APIManager.shared.validateEmail(email) else {
                    print("Invalid email")
                    return
                }
                APIManager.shared.login(email: email, password: password)
            })
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color.tertiaryBg)
            .foregroundStyle(.primaryLabel)
            .clipShape(.buttonBorder)
            .fontWeight(.bold)

            Spacer()
        }
        .padding(.top, 100)
        .padding(.horizontal)
        .background(Color.primaryBg)
    }
}

struct AuthTextField: View {
    @State var placeholderText: String = "Enter"
    @Binding var email: String

    var body: some View {
        TextField(placeholderText, text: $email)
            .padding()
            .autocorrectionDisabled()
            .textInputAutocapitalization(.never)
            .lineLimit(1)
            .frame(maxWidth: .infinity, maxHeight: 52, alignment: .leading)
            .background(
                RoundedRectangle(cornerRadius: 5)
                    .stroke(Color.primaryLabel, lineWidth: 2)
            )
    }
}

struct AuthPasswordField: View {
    @Binding var password: String

    var body: some View {
        SecureField("Password", text: $password)
            .padding()
            .lineLimit(1)
            .frame(maxWidth: .infinity, maxHeight: 52, alignment: .leading)
            .background(
                RoundedRectangle(cornerRadius: 5)
                    .stroke(Color.primaryLabel, lineWidth: 2)
            )
    }
}

#Preview {
//    LoginView()
    RegisterView()
}
