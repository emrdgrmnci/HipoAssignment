////
////  GithubRequest.swift
////  HipoAssignment
////
////  Created by Ali Emre Değirmenci on 27.02.2020.
////  Copyright © 2020 Ali Emre Degirmenci. All rights reserved.
////
//
//import Foundation
//
//enum GithubError: Error {
//    case noDataAvailable
//    case canNotProcessData
//}
//
//struct GithubRequest {
//    let resourceURL : URL
//
//    init(userName: String) {
//        let resourceString = "https://api.github.com/users/emrdgrmnci"
//        guard let resourceURL = URL(string: resourceString) else { fatalError()}
//        self.resourceURL = resourceURL
//    }
//
//
//    func getGithub(completion: @escaping(Result<Github, GithubError>) -> Void) {
//        let dataTask = URLSession.shared.dataTask(with: resourceURL) {data, _, _ in
//            guard let jsonData = data else {
//                completion(.failure(.noDataAvailable))
//                return
//            }
//
//            do {
//                let decoder = JSONDecoder()
//                let githubRepoResponse = try decoder.decode(Github.self, from: jsonData)
//                let githubRepoDetails = githubRepoResponse
//                completion(.success(githubRepoDetails))
//            } catch {
//                completion(.failure(.canNotProcessData))
//            }
//        }
//        dataTask.resume()
//    }
//}
