//////
//////  GithubRequest.swift
//////  HipoAssignment
//////
//////  Created by Ali Emre Değirmenci on 27.02.2020.
//////  Copyright © 2020 Ali Emre Degirmenci. All rights reserved.
//////
////
import Foundation

let urlForGithubRepo =  "https://api.github.com/users/"
let urlForGithub = "https://api.github.com/users/"

class GithubRequest{
    
    static func getGithubData(userName: String, completion: @escaping (_ result: Github) -> Void) {
        
        guard let downloadURL =  URL(string: urlForGithub + userName)  else { return }
        URLSession.shared.dataTask(with: downloadURL) { data, urlResponse, error in
            guard let data = data else {return}
            do{
                guard let jsonString = String(data: data, encoding: .utf8) else {return}
                print(jsonString)
                let downloadedGithub = try JSONDecoder().decode(Github.self, from: data)
                completion(downloadedGithub)
            }catch(let err) {
                print("something went wrong after downloaded",err)
            }
        }.resume()
    }
    
    static func getGithubRepoData(userName: String, completion: @escaping (_ result: [Repo]) -> Void) {
        guard let downloadURL = URL(string: urlForGithubRepo + userName + "/repos")else { return }
        URLSession.shared.dataTask(with: downloadURL) { data, urlResponse, error in
            guard let data = data else {return}
            do{
                guard let jsonString = String(data: data, encoding: .utf8) else {return}
                print(jsonString)
                let downloadedRepos = try JSONDecoder().decode([Repo].self, from: data)
                completion(downloadedRepos)
            }catch(let err) {
                print("something went wrong after downloaded",err)
            }
        }.resume()
    }
}


