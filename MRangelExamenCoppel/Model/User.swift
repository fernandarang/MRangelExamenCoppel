//
//  User.swift
//  MRangelExamenCoppel
//
//  Created by MacBookMBA5 on 01/02/23.
//

import Foundation

struct Account: Codable{
    let username: String
    
    enum CodingKeys: String, CodingKey {
        case username
    }
    init(username: String) {
        self.username = username
    }
    init(){
        self.username = ""
    }
    
}
