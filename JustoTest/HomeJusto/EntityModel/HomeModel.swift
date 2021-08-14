//
//  HomeModel.swift
//  JustoTest
//
//  Created by David Guia on 14/08/21.
//

import UIKit
import Foundation

struct ResultModel: Decodable {
    var results: [TestModelConsult]
    
    enum CodingKeys: String, CodingKey {
        case results
    }
}

struct TestModelConsult: Decodable {
    
    var gender: String?
    var email: String?
    var phone: String?
    var cell: String?
    var name: NameConsult?
    var picture: PictureConsult?
    var location: LocationConsult?
    
    enum CodingKeys: String, CodingKey {
        case gender = "gender"
        case email = "email"
        case phone = "phone"
        case name
        case picture
        case location
    }
}

struct NameConsult: Codable {
    
    var title: String?
    var first: String?
    var last: String?
    
    enum CodingKeys: String, CodingKey {
        case title = "title"
        case first = "first"
        case last = "last"
    }
}

struct PictureConsult: Codable {
    
    var large: String?
    
    enum CodingKeys: String, CodingKey {
        case large = "large"
    }
}

struct LocationConsult: Codable {
    var city: String?
    var state: String?
    
    enum CodingKeys: String, CodingKey {
        case city = "city"
        case state = "state"
    }
}
