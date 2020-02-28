////
////  GithubRequest.swift
////  HipoAssignment
////
////  Created by Ali Emre Değirmenci on 27.02.2020.
////  Copyright © 2020 Ali Emre Degirmenci. All rights reserved.
////
//
import Foundation
//
//enum GithubError: Error {
//    case noDataAvailable
//    case canNotProcessData
//}
//
struct GithubRequest {
    let resourceGithubURL: URL
    let resourceRepoURL: URL
//
    init(userName: String) {
        let resourceGithubString = "https://api.github.com/users/\(userName)"
        guard let resourceGithubURL = URL(string: resourceGithubString) else {fatalError()}
        self.resourceGithubURL = resourceGithubURL

        let resourceRepoString = "https://api.github.com/users/\(userName)/repos"
             guard let resourceRepoURL = URL(string: resourceGithubString) else {fatalError()}
             self.resourceRepoURL = resourceRepoURL
    }
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

func getGithubData() {
//    let jsonUrlString = "https://api.github.com/users/\(userName)"
//    guard let resourceURL = URL(string: jsonUrlString) else { fatalError()}
    URLSession.shared.dataTask(with: resourceGithubURL) { (data, response, err) in

        guard let data = data else { return }

        do {
             let githubInfoResponse = try JSONDecoder().decode(Github.self, from: data)
            let githubDetails = githubInfoResponse
            print("(GITHUB_____---->>>\(githubDetails)")
        }catch let jsonErr {
            print(jsonErr.localizedDescription)
        }

    }.resume()
}

func getGithubRepoData() {

//    let jsonUrlString = "https://api.github.com/users/\(userName)/repos"
//    let url = URL(string: jsonUrlString)

    URLSession.shared.dataTask(with: resourceRepoURL) { (data, response, err) in

        guard let data = data else { return }

        do {
            let repoElementResponse = try JSONDecoder().decode(Repo.self, from: data)
            let repoElementDetails = repoElementResponse
            print("(GITHUB_____---->>>\(repoElementDetails)")
        }catch let jsonErr {
            print(jsonErr.localizedDescription)
        }
    }.resume()
}
}
