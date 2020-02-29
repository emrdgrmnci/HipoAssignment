
//  Github.swift
//  HipoAssignment
//
//  Created by Ali Emre Değirmenci on 27.02.2020.
//  Copyright © 2020 Ali Emre Degirmenci. All rights reserved.
//

import Foundation

struct Github: Codable {
    let login: String?
    let id: Int?
    let nodeId: String?
    let avatar_url: String?
    let gravatarId: String?
    let url: String?
    let htmlUrl: String?
    let followersUrl: String?
    let followingUrl: String?
    let gistsUrl: String?
    let starredUrl: String?
    let subscriptionsUrl: String?
    let organizationsUrl: String?
    let reposUrl: String?
    let eventsUrl: String?
    let receivedEventsUrl: String?
    let type: String?
    let siteAdmin: Bool?
    let name: String?
    let blog: String?
    let location: String?
    let bio: String?
    let publicRepos: Int?
    let publicGists: Int?
    let followers: Int?
    let following: Int?
    let createdAt: Date?
    let updatedAt: Date?

    enum CodingKeys: String, CodingKey {
        case login
        case id
        case nodeId
        case avatar_url
        case gravatarId
        case url
        case htmlUrl
        case followersUrl
        case followingUrl
        case gistsUrl
        case starredUrl
        case subscriptionsUrl
        case organizationsUrl
        case reposUrl
        case eventsUrl
        case receivedEventsUrl
        case type
        case siteAdmin
        case name
        case blog
        case location
        case bio
        case publicRepos
        case publicGists
        case followers
        case following
        case createdAt
        case updatedAt
    }
}

//struct Github: Codable {
//    let avatarURL: String?
//    let name: String?
//    let followers, following: Int?
//
//    enum CodingKeys: String, CodingKey {
//        case avatarURL = "avatar_url"
//        case name, followers, following
//
//    }
//}

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


