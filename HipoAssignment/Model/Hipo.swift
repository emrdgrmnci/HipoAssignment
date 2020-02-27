//
//  Hipo.swift
//  HipoAssignment
//
//  Created by Ali Emre Değirmenci on 26.02.2020.
//  Copyright © 2020 Ali Emre Degirmenci. All rights reserved.
//

import Foundation

// MARK: - Hipo
struct Hipo: Codable {
    let company, team: String
    let members: [Member]
}

// MARK: - Member
struct Member: Codable {
    let name: String
    let age: Int
    let location, github: String //member github username
    let hipo: HipoClass
}

// MARK: - HipoClass
struct HipoClass: Codable {
    let position: String
    let yearsInHipo: Int

    enum CodingKeys: String, CodingKey {
        case position
        case yearsInHipo = "years_in_hipo"
    }
}
