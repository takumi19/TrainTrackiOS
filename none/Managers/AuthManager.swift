import SwiftUI

struct AuthResponse: Codable {
    var id: Int64
    var token: String
}

class AuthManager: ObservableObject {
    static let shared = AuthManager()
    @Published var authenticated: Bool = false
    private var user: UserModel?

    func login(email: String, password: String) throws {
        // user = UserModel(fullName: fullName, login: login, email: email)
        let user = ["email": email,
                    "password": password]

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

            print("Parsing the response")
            guard let data = data else { return }
            let resData = try! JSONDecoder().decode(AuthResponse.self, from: data)
            print("Received token: \(resData.token)")

        }.resume()
        print("Sent the response")

    }

    func validateEmail(_ email: String) -> Bool {
        let emailValidationRegex = "^[\\p{L}0-9!#$%&'*+\\/=?^_`{|}~-][\\p{L}0-9.!#$%&'*+\\/=?^_`{|}~-]{0,63}@[\\p{L}0-9-]+(?:\\.[\\p{L}0-9-]{2,7})*$"

        let emailValidationPredicate = NSPredicate(format: "SELF MATCHES %@", emailValidationRegex)

        return emailValidationPredicate.evaluate(with: email)
    }
}

enum AuthError: Error {
    case invalidURL
    case invalidRequest
}
