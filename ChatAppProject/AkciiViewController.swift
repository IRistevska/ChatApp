//
//  AkciiViewController.swift
//  ChatAppProject
//
//  Created by Jovan Stojanovski on 5/29/19.
//  Copyright © 2019 Risto Anastasoski. All rights reserved.
//

import UIKit
import FirebaseFirestore

class AkciiViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    @IBOutlet var akciiTableView: UITableView!
    
    var akcii: [Akcija] = []
    var selectedAction: Akcija?
    var myProfile: Profile?
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return akcii.count // kolku sto ke imame akcii, zatoa e count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AkciiCell") as? AkciiTableViewCell
        cell?.setupCell(akcija: akcii[indexPath.row])// se zemaa soodvetnata akcija vo soodvetnata kelija
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row % 2 == 0{
            
            return 200
        }else{
            return 120
            
        }
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "akcii naslov"
    }
    func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        return "akcii footer"
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let action = akcii[indexPath.row]
        self.selectedAction = action
        self.performSegue(withIdentifier: "showChatID", sender: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let db = Firestore.firestore()
        db.collection("akcija").addSnapshotListener { (snapshot, error) in // se pristapuva do kolekcija akcija na firebase
            if let snapshot = snapshot {
                for document in snapshot.documents {
                    let akcija = Akcija(data: document)
                    self.akcii.append(akcija)
                    
                }
                self.akciiTableView.reloadData() //vrakanje na tabelata
            }
        }
        
        

        // Do any additional setup after loading the view.
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let controller = segue.destination as? ChatViewController{
            controller.action = self.selectedAction
            controller.myProfile = self.myProfile
        }
    }
 

}
