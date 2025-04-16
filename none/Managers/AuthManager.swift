import SwiftUI

struct AuthResponse: Codable {
    var token: String
}

class AuthManager: ObservableObject {
    @Published var authenticated: Bool = false
    private var user: UserModel?

    func login(fullName: String, login: String, email: String, password: String) throws {
        // user = UserModel(fullName: fullName, login: login, email: email)
        let user = ["full_name": fullName,
                    "login": login,
                    "email": email,
                    "password": password]

        let js = JSONSerialization()
        let body = try! JSONSerialization.data(withJSONObject: user)
        print("Serialized into JSON")

        guard let url = URL(string: AppEnv.serverBaseURL + "v1/login") else {
            throw AuthError.invalidURL
        }

        print("Parsed the URL: \(url.absoluteString)")

        var req = URLRequest(url: url)
        req.httpMethod = "POST"
        req.httpBody = body
        req.setValue("application/json", forHTTPHeaderField: "Content-Type")

        URLSession.shared.dataTask(with: req) { (data, response, error) in

            guard let data = data else { return }
            let resData = try! JSONDecoder().decode(AuthResponse.self, from: data)
            print("Received token: \(resData.token)")

        }.resume()

    }
}

enum AuthError: Error {
    case invalidURL
    case invalidRequest
}
