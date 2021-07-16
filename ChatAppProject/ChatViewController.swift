//
//  ChatViewController.swift
//  ChatAppProject
//
//  Created by Riki on 5/23/19.
//  Copyright © 2019 Risto Anastasoski. All rights reserved.
//

import UIKit
import Firebase

class ChatViewController: UIViewController, UITabBarDelegate, UITableViewDataSource {
    @IBOutlet weak var senderTextField: UITextField!
    @IBOutlet weak var chatTableView: UITableView!
    
    let db = Firestore.firestore()
    var myProfile: Profile?
    var messages : [Message] = []
    var profiles : [Profile] = []
    var action: Akcija?
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let message = messages[indexPath.row]
        var name = ""
        if let senderID = message.sender{
            name = getNameForProfileID(uid: senderID)
        }
        if message.sender == self.myProfile?.profileID{
            if let cell = tableView.dequeueReusableCell(withIdentifier: "senderCell", for: indexPath) as? SenderTableViewCell{
                cell.setUpCell(message: message, senderName: name)
                return cell
            }
        }
        else{
            if let cell = tableView.dequeueReusableCell(withIdentifier: "receiverCell", for: indexPath) as? ReceiverTableViewCell{
                cell.setUpCell(message: message, senderName: name)
                return cell
            }
        }
        
        return UITableViewCell()
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        chatTableView.rowHeight = UITableView.automaticDimension
        db.collection("messages").whereField("actionID", isEqualTo: self.action!.id!).order(by: "sentAt", descending: false).addSnapshotListener(includeMetadataChanges: true) { (snapshot, error) in
            if let snapshot = snapshot{
                self.messages.removeAll()
            for document in snapshot.documents {
                
                let message = Message(data: document)
                self.messages.append(message)
                
                }
            }
            self.chatTableView.reloadData()
            self.chatTableView.setContentOffset(CGPoint(x: 0, y: self.chatTableView.contentSize.height), animated: true)
            
        
            
            
        }
        
        db.collection("profiles").addSnapshotListener(includeMetadataChanges: true) { (snapshot, error) in
            if let error = error{
                print(error.localizedDescription)
            }else{
                if let snapshot = snapshot{
                    self.profiles.removeAll()
                    for document in snapshot.documents{
                        let profile = Profile(data: document)
                        self.profiles.append(profile)
                    }
                    self.chatTableView.reloadData()
                }
                
               
            }
        }
       

        // Do any additional setup after loading the view.
    }
    @IBAction func senderButton(_ sender: Any) {
        
        let message = Message()
        message.text = senderTextField.text
        message.sender = self.myProfile?.profileID
        message.sentAt = Date()
        message.actionID = self.action?.id
        var ref: DocumentReference? = nil
        ref = db.collection("messages").addDocument(data: message.params) { err in
            if let err = err {
                print("Error adding document: \(err)")
            } else {
                print("Document added with ID: \(ref!.documentID)")
            }
        }
        senderTextField.text = ""
        
    }
    
    func getNameForProfileID(uid: String) -> String{
        for profile in profiles{
            if profile.profileID == uid, let name = profile.name{
                return name
            }
        }
        return uid
    }
 
}
