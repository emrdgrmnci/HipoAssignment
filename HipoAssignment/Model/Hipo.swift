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
    var company, team: String
    var members: [Member]
}

// MARK: - Member
struct Member: Codable, Comparable {

    var name: String
    var age: Int
    var location, github: String //member github username
    var hipo: HipoClass

    static func < (lhs: Member, rhs: Member) -> Bool {
        lhs.name > rhs.name
    }
    static func == (lhs: Member, rhs: Member) -> Bool {
        lhs.name > rhs.name
    }
}

// MARK: - HipoClass
struct HipoClass: Codable {
    var position: String
    var yearsInHipo: Int

    enum CodingKeys: String, CodingKey {
        case position
        case yearsInHipo = "years_in_hipo"
    }
}
