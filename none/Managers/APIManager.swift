//
//  APIManager.swift
//  none
//
//  Created by Max Vaughan on 15.04.2025.
//

import Foundation

class APIManager {
    static let shared = APIManager()

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
}

enum APIError: Error {
    case invalidURL
    case unableToComplete
    case invalidResponse
    case invalidData
}
