//
//  Authentication.swift
//  MRangelExamenCoppel
//
//  Created by MacBookMBA5 on 30/01/23.
//

import Foundation

struct User: Codable{
    let username: String
    let password: String
    var requestToken : String
    
    enum CodingKeys: String, CodingKey {
        case username
        case password
        case requestToken = "request_token"
    }
    
    init(username: String, password: String, requestToken: String) {
        self.username = username
        self.password = password
        self.requestToken = requestToken
    }
    init(){
        self.username = ""
        self.password = ""
        self.requestToken = ""
    }
}
