
//  Github.swift
//  HipoAssignment
//
//  Created by Ali Emre Değirmenci on 27.02.2020.
//  Copyright © 2020 Ali Emre Degirmenci. All rights reserved.
//

import Foundation

struct Github: Codable {
    let login: String?
    let avatar_url: String?
    let url: String?
    let type: String?
    let name: String?
    let location: String?
    let followers: Int?
    let following: Int?
    let updatedAt: Date?

    enum CodingKeys: String, CodingKey {
        case login
        case avatar_url
        case url
        case type
        case name
        case location
        case followers
        case following
        case updatedAt
    }
}

// MARK: - Repo
struct Repo : Codable {
    let name : String?
    let updatedAt : String?
    let stargazersCount : Int?
    let language : String?

    enum CodingKeys: String, CodingKey {
        case name = "name"
        case updatedAt = "updated_at"
        case stargazersCount = "stargazers_count"
        case language = "language"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        updatedAt = try values.decodeIfPresent(String.self, forKey: .updatedAt)
        stargazersCount = try values.decodeIfPresent(Int.self, forKey: .stargazersCount)
        language = try values.decodeIfPresent(String.self, forKey: .language)
    }

}


