//
//  Message.swift
//  ChatAppProject
//
//  Created by Riki on 5/23/19.
//  Copyright © 2019 Risto Anastasoski. All rights reserved.
//

import UIKit
import Firebase

class Message: NSObject {
    
    var text : String?
    var sender : String?
    var sentAt : Date?
    var actionID: String?
    
    var id : String?
    var params : [String:Any]{
        get{
            var data = [String : Any]()
            data["text"] = text
            data["sender"] = sender
            if let date = sentAt{
                data["sentAt"] = Timestamp(date: date)
            }
            data["actionID"] = self.actionID
            return data
         }
    }
    
    override init() {
        super.init()
    }
    init(data: QueryDocumentSnapshot) {
        self.id = data.documentID
        self.text = data["text"] as? String
        self.sender = data["sender"] as? String
        if let date =  data["sentAt"] as? Timestamp{
            self.sentAt = date.dateValue()
            self.actionID = data["actionID"] as? String
        }
    }
    

}
