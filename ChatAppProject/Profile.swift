//
//  Profile.swift
//  ChatAppProject
//
//  Created by Riki on 5/27/19.
//  Copyright © 2019 Risto Anastasoski. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class Profile: NSObject {

    var name: String?
    var profileID: String?
    var createdAt: Date?
    var params : [String:Any]{
        get{
            var data = [String : Any]()
            data["name"] = name
            data["profileID"] = profileID
            if let date = createdAt{
                data["createdAt"] = Timestamp(date: date)
            }
            return data
        }
    }
    
    override init() {
        super.init()
    }
    init(data: QueryDocumentSnapshot) {
        self.profileID = data.documentID
        self.name = data["name"] as? String
        if let date =  data["createdAt"] as? Timestamp{
            self.createdAt = date.dateValue()
        }
    }
    
    
}

