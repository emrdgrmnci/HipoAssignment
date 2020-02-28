//////
//////  GithubRequest.swift
//////  HipoAssignment
//////
//////  Created by Ali Emre Değirmenci on 27.02.2020.
//////  Copyright © 2020 Ali Emre Degirmenci. All rights reserved.
//////
////
//import Foundation
////
////enum GithubError: Error {
////    case noDataAvailable
////    case canNotProcessData
////}
////
////class GithubRequest {
//
////    static let shared = GithubRequest(userName: "emrdgrmnci")
////    let resourceGithubURL: URL
////    let resourceRepoURL: URL
//////
////    init(userName: String) {
////        let resourceGithubString = "https://api.github.com/users/\(userName)"
////        guard let resourceGithubURL = URL(string: resourceGithubString) else {fatalError()}
////        self.resourceGithubURL = resourceGithubURL
////
////        let resourceRepoString = "https://api.github.com/users/\(userName)/repos"
////             guard let resourceRepoURL = URL(string: resourceGithubString) else {fatalError()}
////             self.resourceRepoURL = resourceRepoURL
////
////        getGithubData()
////        getGithubRepoData()
////    }
//
////func getGithubData() {
//////    let jsonUrlString = "https://api.github.com/users/\(userName)"
//////    guard let resourceURL = URL(string: jsonUrlString) else { fatalError()}
////    URLSession.shared.dataTask(with: resourceGithubURL) { (data, response, err) in
////
////        guard let data = data else { return }
////
////        do {
////             let githubInfoResponse = try JSONDecoder().decode(Github.self, from: data)
////            let githubDetails = githubInfoResponse
////            print("(GITHUB_____---->>>\(githubDetails)")
////        }catch let jsonErr {
////            print(jsonErr.localizedDescription)
////        }
////
////    }.resume()
////}
////
////func getGithubRepoData() {
////
//////    let jsonUrlString = "https://api.github.com/users/\(userName)/repos"
//////    let url = URL(string: jsonUrlString)
////
////    URLSession.shared.dataTask(with: resourceRepoURL) { (data, response, err) in
////
////        guard let data = data else { return }
////
////        do {
////            let repoElementResponse = try JSONDecoder().decode(RepoElement.self, from: data)
////            let repoElementDetails = repoElementResponse
////            print("(GITHUBREPO_____---->>>\(repoElementDetails)")
////        }catch let jsonErr {
////            print(jsonErr.localizedDescription)
////        }
////    }.resume()
////}
////}
//
//
// class GithubRequest {
//
//     var userName: String = "emrdgrmnci"
//
//     static let shared = GithubRequest()
//
//     public func getGithubData(completion: @escaping(Github) -> () ) {
//         guard let url = URL(string: "https://api.github.com/users/\(userName)") else {return}
//         let session = URLSession.shared
//         session.dataTask(with: url) { (data, response, error) in
//             guard error == nil else {
//                 print("Error: \(error!)")
//                 return
//             }
//             guard let data = data else {
//                 print("No data!!!")
//                 return
//             }
//             do {
//                 let decoder = try JSONDecoder().decode(Github.self, from: data)
//                 DispatchQueue.main.async {
//                     completion(decoder)
//                 }
//             } catch {
//                 print(error.localizedDescription)
//             }
//             }.resume()
//     }
//
//    public func getRepoData(completion: @escaping([Repo]) -> () ) {
//            guard let url = URL(string: "https://api.github.com/users/\(userName)/repos") else {return}
//            let session = URLSession.shared
//            session.dataTask(with: url) { (data, response, error) in
//                guard error == nil else {
//                    print("Error: \(error!)")
//                    return
//                }
//                guard let data = data else {
//                    print("No data!!!")
//                    return
//                }
//                do {
//                    let decoder = try JSONDecoder().decode([Repo].self, from: data)
//                    print("DECODER\(decoder)")
//                    DispatchQueue.main.async {
//                        completion(decoder)
//                    }
//                } catch {
//                    print("REPO JSON PARSING ERROR \(error.localizedDescription)")
//                }
//                }.resume()
//        }
// }
//
