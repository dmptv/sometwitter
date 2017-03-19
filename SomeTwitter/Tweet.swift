//
//  Tweet.swift
//  SomeTwitter
//
//  Created by Kanat A on 16/03/2017.
//  Copyright © 2017 ak. All rights reserved.
//

import UIKit
import SwiftyJSON
import TRON

struct Tweet: JSONDecodable {
    let user: User
    let message: String
    
    init(json: JSON) {
        let userJson = json["user"]
        self.user = User(json: userJson)
        
        self.message = json["message"].stringValue
    }
}
