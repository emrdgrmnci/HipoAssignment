
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
    let updated_at : String?
    let stargazers_count : Int?
    let language : String?

    enum CodingKeys: String, CodingKey {
        case name = "name"
        case updated_at = "updated_at"
        case stargazers_count = "stargazers_count"
        case language = "language"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        updated_at = try values.decodeIfPresent(String.self, forKey: .updated_at)
        stargazers_count = try values.decodeIfPresent(Int.self, forKey: .stargazers_count)
        language = try values.decodeIfPresent(String.self, forKey: .language)
    }

}

