//
//  RequestToken.swift
//  MRangelExamenCoppel
//
//  Created by MacBookMBA5 on 01/02/23.
//

import Foundation

struct RequestTokenModel : Codable{
    let success: Bool
    let expiresAt: String
    let requestToken: String

    enum CodingKeys: String, CodingKey {
        case success
        case expiresAt = "expires_at"
        case requestToken = "request_token"
    }
    init(success: Bool, expiresAt: String, requestToken: String) {
        self.success = success
        self.expiresAt = expiresAt
        self.requestToken = requestToken
    }
    init(){
        self.success = false
        self.expiresAt = ""
        self.requestToken = ""
    }
}
