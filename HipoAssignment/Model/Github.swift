
//  Github.swift
//  HipoAssignment
//
//  Created by Ali Emre Değirmenci on 27.02.2020.
//  Copyright © 2020 Ali Emre Degirmenci. All rights reserved.
//

import Foundation

struct Github: Codable {
    let avatarURL: String?
    let name: String?
    let followers, following: Int?

    enum CodingKeys: String, CodingKey {
        case avatarURL = "avatar_url"
        case name, followers, following

    }
}

//struct RepoElement: Codable {
//    let name: String?
//    let updatedAt: String?
//    let stargazersCount: Int?
//    let language: String?
//
//    enum CodingKeys: String, CodingKey {
//        case name
//        case updatedAt = "updated_at"
//        case stargazersCount = "stargazers_count"
//        case language
//    }
//
//    typealias Repo = [RepoElement]
//}


