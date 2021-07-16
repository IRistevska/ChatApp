//
//  Akcija.swift
//  ChatAppProject
//
//  Created by Jovan Stojanovski on 5/29/19.
//  Copyright © 2019 Risto Anastasoski. All rights reserved.
//

import UIKit
import Firebase

class Akcija: NSObject {

    var ime : String?
    var lokacija: String?
    var opis: String?
    var vreme: Date?
    var id: String?
    
    func parametri() -> [String:Any]{
        var data = [String : Any]()
        data["ime"] = ime
        data["lokacija"] = lokacija
        data["opis"] = opis
    if let vreme = vreme { // proveruvame dali vo "vreme" ima akcija ili nema (vo slucajot ne smee da e nil)
       data["vreme"] = Timestamp(date: vreme)

       }
       
        return data
    }
    
    var params : [String:Any]{
        get{
            var data = [String : Any]()
            data["ime"] = ime
            data["lokacija"] = lokacija
            data["opis"] = opis
            return data
        }
    }
    
    init(data: QueryDocumentSnapshot) {
        self.id = data.documentID
        self.ime = data["ime"] as? String
        self.opis = data["opis"] as? String
        self.lokacija = data["lokacija"] as? String
        
        if let date =  data["vreme"] as? Timestamp{
            self.vreme = date.dateValue()
        }
    }
    
    required override init () {
        super.init()
    }
}
