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

    let repos = [Repo]()

    static let  shared = GithubRequest()

    public func getGithubData(completion: @escaping (_ result: Github) -> Void) {
        let userName = "emrdgrmnci"
        let url = URL(string: "https://api.github.com/users/\(String(describing: userName))")
            guard let downloadURL = url else { return }
            URLSession.shared.dataTask(with: downloadURL) { data, urlResponse, error in
                guard let data = data else {return}
                do{
                    guard let jsonString = String(data: data, encoding: .utf8) else {return}
                    print(jsonString)
                    let downloadedRepos = try JSONDecoder().decode(Github.self, from: data)
                    completion(downloadedRepos)
                }catch(let err) {
                    print("something wrong after downloaded",err)
                }
            }.resume()
        }


        func getGithubRepoData(withCompletion completion: @escaping ([Repo]?) -> Void) {
            let session = URLSession(configuration: .default, delegate: nil, delegateQueue: .main)
            let userName = "emrdgrmnci"
            let url = URL(string: "https://api.github.com/users/\(String(describing: userName))")!
            let task = session.dataTask(with: url, completionHandler: { (data: Data?, response: URLResponse?, error: Error?) -> Void in
                guard let data = data else {
                    completion(nil)
                    return
                }
                let repo = try? JSONDecoder().decode([Repo].self, from: data)
                completion(repo)
            })
            task.resume()
        }

}
//class GithubRequest {
//
//    static let shared = GithubRequest(userName: "emrdgrmnci")
//    let resourceGithubURL: URL
//    let resourceRepoURL: URL
//
//    init(userName: String) {
//        let resourceGithubString = "https://api.github.com/users/\(userName)"
//        guard let resourceGithubURL = URL(string: resourceGithubString) else {fatalError()}
//        self.resourceGithubURL = resourceGithubURL
//
//        let resourceRepoString = "https://api.github.com/users/\(userName)/repos"
//             guard let resourceRepoURL = URL(string: resourceGithubString) else {fatalError()}
//             self.resourceRepoURL = resourceRepoURL
//
//        getGithubData()
//        getGithubRepoData()
//    }
//
//    func getGithubData(completion: @escaping (_ result: Github) -> Void) {
//         guard let downloadURL = url else { return }
//         URLSession.shared.dataTask(with: downloadURL) { data, urlResponse, error in
//             guard let data = data else {return}
//             do{
//                 guard let jsonString = String(data: data, encoding: .utf8) else {return}
//                 print(jsonString)
//                 let downloadedRepos = try JSONDecoder().decode(Github.self, from: data)
//                 completion(downloadedRepos)
//             }catch(let err) {
//                 print("something wrong after downloaded",err)
//             }
//         }.resume()
//     }
//
//func getGithubRepoData(completion: @escaping (_ result: Repo) -> Void) {
//        guard let downloadURL = url else { return }
//        URLSession.shared.dataTask(with: downloadURL) { data, urlResponse, error in
//            guard let data = data else {return}
//            do{
//                guard let jsonString = String(data: data, encoding: .utf8) else {return}
//                print(jsonString)
//                let downloadedRepos = try JSONDecoder().decode(Repo.self, from: data)
//                completion(downloadedRepos)
//            }catch(let err) {
//                print("something wrong after downloaded",err)
//            }
//        }.resume()
//    }
//}
