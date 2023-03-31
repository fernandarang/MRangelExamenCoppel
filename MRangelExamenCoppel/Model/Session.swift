//
//  Session.swift
//  MRangelExamenCoppel
//
//  Created by MacBookMBA5 on 02/02/23.
//

import Foundation
struct SessionModel : Codable{
    let success : Bool
    let sessionId : String
    
    enum CodingKeys : String, CodingKey{
        case success
        case sessionId = "session_id"
    }
    init(success: Bool, sessionId: String) {
        self.success = success
        self.sessionId = sessionId
    }
    init(){
        self.success = false
        self.sessionId = ""
    }
}
