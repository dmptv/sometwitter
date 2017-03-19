//
//  Models.swift
//  SomeTwitter
//
//  Created by Kanat A on 15/03/2017.
//  Copyright © 2017 ak. All rights reserved.
//

import UIKit
import TRON
import SwiftyJSON

extension Collection where Iterator.Element == JSON {
    func decode<T: JSONDecodable>() throws -> [T] {
        return try map{try T(json: $0)}
    }
}

class HomeDatasource: Datasource, JSONDecodable {

    let users: [User]
    let tweets: [Tweet]
    
    // JSONDecodable - protocol
    required init(json: JSON) throws {
        
        guard let userJsonArray = json["users"].array, let tweetsJsonArray = json["tweets"].array  else {
            throw NSError(domain: "apple.com", code: 1, userInfo: [NSLocalizedDescriptionKey: "user's not valid in JSON"])
        }
        
        // map вернет массив с тем что было сконструировано в скобках {  }
//        self.users = userJsonArray.map{User(json: $0)}
//        self.tweets = tweetsJsonArray.map{Tweet(json: $0)}
        
        self.users = try  userJsonArray.decode()
        self.tweets = try tweetsJsonArray.decode()
        
    }

    override func footerClasses() -> [DatasourceCell.Type]? {
        return [UserFooter.self]
    }
    
    override func headerClasses() -> [DatasourceCell.Type]? {
        return [UserHeader.self]
    }
    
    // register cell
    override func cellClasses() -> [DatasourceCell.Type] {
        return [UserCell.self, TwitterCell.self]
    }
    
    // get item at indexPath
    override func item(_ indexPath: IndexPath) -> Any? {
        if indexPath.section == 1 {
            return tweets[indexPath.item]
        }
        return users[indexPath.item]
    }
    
    override func numberOfItems(_ section: Int) -> Int {
        if section == 1 {
            return tweets.count
        }
        return users.count
    }
    
    override func numberOfSections() -> Int {
        return 2
    }
    
}









