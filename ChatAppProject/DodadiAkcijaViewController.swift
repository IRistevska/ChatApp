//
//  DodadiAkcijaViewController.swift
//  ChatAppProject
//
//

import UIKit
import Firebase

class DodadiAkcijaViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var imeNaNovaAkcija: UITextField!
    @IBOutlet weak var lokacijaNaNovaAkcija: UITextField!
    @IBOutlet weak var opisNaNovaAkcija: UITextField!
    @IBOutlet var dataTextFiled: UITextField!
    var selectedDate: Date?
    
      let db = Firestore.firestore()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func doneButton(_ sender: Any) {
        
        self.dismiss(animated: true) {
            
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func doneButtonAction(_ sender: Any) {
        
        var akcija : Akcija = Akcija()
        akcija.ime = imeNaNovaAkcija.text
        akcija.lokacija = lokacijaNaNovaAkcija.text
        akcija.opis = opisNaNovaAkcija.text
        
        textFieldDidBeginEditing(dataTextFiled)
     
        akcija.vreme = selectedDate
        
        var ref: DocumentReference? = nil
        ref = db.collection("akcija").addDocument(data: akcija.parametri()) { err in
            if let err = err {
                print("Error adding document: \(err)")
            } else {
                print("Document added with ID: \(ref!.documentID)")
            }
        }
        self.dismiss(animated: true, completion: nil)
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        print("did begin editing")
        var datePicker = UIDatePicker()
        textField.inputView = datePicker // za da se znae deka koga ke se klikne vo textfiled, da se otvori date pikerot
        datePicker.datePickerMode = .dateAndTime
        datePicker.addTarget(self, action: #selector(DodadiAkcijaViewController.handleDatePicker(sender:)), for: .valueChanged)
        
        
    }
    
    @objc func handleDatePicker(sender: UIDatePicker) { // obj c e ostanato od prethodno, ne e promeneto vo swift
        print("choose date", sender.date)
        var timeFormater = DateFormatter()
        timeFormater.dateStyle = .full // stilot na datumot
        timeFormater.timeStyle = .short // stilot na vremeto
        dataTextFiled.text = timeFormater.string(from: sender.date)
        selectedDate = sender.date
    }
}
