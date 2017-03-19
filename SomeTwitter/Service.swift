//
//  Service.swift
//  SomeTwitter
//
//  Created by Kanat A on 18/03/2017.
//  Copyright © 2017 ak. All rights reserved.
//

import UIKit
import TRON
import SwiftyJSON

struct Service {
    let tron = TRON(baseURL: "https://api.letsbuildthatapp.com")
    
    static let sharedInstance = Service()
    
    func fetchHomeFeed(completion: @escaping (HomeDatasource?, Error?)->() ) {
        print("fetch home feed")
        
        let request: APIRequest<HomeDatasource, JSONError> = tron.request("/twitter/home")
        
        request.perform(withSuccess: { (homeDatasource) in
            print("Fetched succesfully...")
            
            completion(homeDatasource, nil)
            
        }) { (err) in
            completion(nil, err)
            print("ERROR happens...", err)
        }
        
    }
    
    class JSONError: JSONDecodable {
        required init(json: JSON) throws {
            print("JSON ERROR")
        }
    }
}





















