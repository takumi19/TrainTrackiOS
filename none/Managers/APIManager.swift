//
//  APIManager.swift
//  none
//
//  Created by Max Vaughan on 15.04.2025.
//

import Foundation
import SwiftUI

class APIManager {
    static let shared = APIManager()
    // JWT Access Token
    private var accessToken: String = ""
    private(set) var userId: Int64 = 1

    @AppStorage("logged_in") var logged_in: Bool = false

    func login(email: String, password: String) /*throws*/ {
        // user = UserModel(fullName: fullName, login: login, email: email)
        let user = ["email": email,
                    "password": password]

        let body = try! JSONSerialization.data(withJSONObject: user)
        guard let url = URL(string: AppEnv.serverBaseURL + "v1/login") else {
//            throw AuthError.invalidURL
            return
        }

        var req = URLRequest(url: url)
        req.httpMethod = "POST"
        req.httpBody = body
        req.setValue("application/json", forHTTPHeaderField: "Content-Type")

        URLSession.shared.dataTask(with: req) { (data, response, error) in
            guard let data = data else { return }
            guard error == nil else { return }
            let resData = try! JSONDecoder().decode(AuthResponse.self, from: data)
            self.accessToken = resData.token
            self.userId = resData.id
            self.logged_in = true
            print("Received token: \(resData.token)")
        }.resume()
    }

    func signup(email: String, password: String) /*throws*/ {
        // user = UserModel(fullName: fullName, login: login, email: email)
        let user = ["full_name": "name",
                    "login": "login",
                    "email": email,
                    "password": password]

        let body = try! JSONSerialization.data(withJSONObject: user)
        guard let url = URL(string: AppEnv.serverBaseURL + "v1/signup") else {
//            throw AuthError.invalidURL
            return
        }

        var req = URLRequest(url: url)
        req.httpMethod = "POST"
        req.httpBody = body
        req.setValue("application/json", forHTTPHeaderField: "Content-Type")

        URLSession.shared.dataTask(with: req) { (data, response, error) in
            guard let data = data else { return }
            guard error == nil else { return }
            let resData = try! JSONDecoder().decode(AuthResponse.self, from: data)
            self.accessToken = resData.token
            self.userId = resData.id
            self.logged_in = true
            print("Received token: \(resData.token)")
        }.resume()
    }

    func validateEmail(_ email: String) -> Bool {
        let emailValidationRegex = "^[\\p{L}0-9!#$%&'*+\\/=?^_`{|}~-][\\p{L}0-9.!#$%&'*+\\/=?^_`{|}~-]{0,63}@[\\p{L}0-9-]+(?:\\.[\\p{L}0-9-]{2,7})*$"

        let emailValidationPredicate = NSPredicate(format: "SELF MATCHES %@", emailValidationRegex)

        return emailValidationPredicate.evaluate(with: email)
    }

    func listExercises(completed: @escaping (Result<[ExerciseInfo], APIError>) -> Void) {
        guard let url = URL(string: AppEnv.serverBaseURL + "v1/exercises/") else {
            //            throw AuthError.invalidURL
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"

        // Perform HTTP Request
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let _ = error {
                completed(.failure(.unableToComplete))
                return
            }

            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.invalidResponse))
                return
            }

            guard let data = data else {
                completed(.failure(.invalidData))
                return
            }

            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let decodedResponse = try decoder.decode([ExerciseInfo].self, from: data)
                completed(.success(decodedResponse))
            } catch let err {
                print(err.localizedDescription)
                completed(.failure(.invalidData))
            }
        }
        task.resume()
    }

    func getUserLogs(completed: @escaping (Result<[Workout], APIError>) -> Void) {
        guard let url = URL(string: AppEnv.serverBaseURL + "v1/users/\(userId)/logs") else {
            // throw AuthError.invalidURL
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"

        // Perform HTTP Request
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let _ = error {
                completed(.failure(.unableToComplete))
                return
            }

            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.invalidResponse))
                return
            }

            guard let data = data else {
                completed(.failure(.invalidData))
                return
            }

            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                decoder.dateDecodingStrategy = .iso8601
                let decodedResponse = try decoder.decode([Workout].self, from: data)
                completed(.success(decodedResponse))
            } catch let err {
                print(err.localizedDescription)
                completed(.failure(.invalidData))
            }
        }
        task.resume()
    }

    func getUsers(completed: @escaping (Result<[UserModel], APIError>) -> Void) {
        guard let url = URL(string: AppEnv.serverBaseURL + "v1/users/") else {
            // throw AuthError.invalidURL
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"

        // Perform HTTP Request
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let _ = error {
                completed(.failure(.unableToComplete))
                return
            }

            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.invalidResponse))
                return
            }

            guard let data = data else {
                completed(.failure(.invalidData))
                return
            }

            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                decoder.dateDecodingStrategy = .iso8601
                let decodedResponse = try decoder.decode([UserModel].self, from: data)
                completed(.success(decodedResponse))
            } catch let err {
                print(err.localizedDescription)
                completed(.failure(.invalidData))
            }
        }
        task.resume()
    }
}

enum APIError: Error {
    case invalidURL
    case unableToComplete
    case invalidResponse
    case invalidData
}
