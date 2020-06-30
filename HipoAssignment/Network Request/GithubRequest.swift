//////
//////  GithubRequest.swift
//////  HipoAssignment
//////
//////  Created by Ali Emre Değirmenci on 27.02.2020.
//////  Copyright © 2020 Ali Emre Degirmenci. All rights reserved.
//////
////
import Foundation

class GithubRequest{

    init() { }

    func githubAPICall<T:Codable>(url: String, expectingReturnType: T.Type, completion: @escaping ((Result<T, Error>) -> Void)) {
        let task = URLSession.shared.dataTask(with: URL(string: url)!, completionHandler: { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            var decodedResult: T?
            do {
                decodedResult = try JSONDecoder().decode(T.self, from: data)
            } catch {
            }
            guard let result = decodedResult else { return }
            completion(.success(result))
        })
        task.resume()
    }
}


