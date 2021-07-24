//
//  AkciiTableViewCell.swift
//  ChatAppProject
//

//

import UIKit

class AkciiTableViewCell: UITableViewCell {
    @IBOutlet var lokacijaLabel: UILabel!
    @IBOutlet var opisLabel: UILabel!
    @IBOutlet var timeLabel: UILabel!
    @IBOutlet var imeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        
    }
 
    func setupCell(akcija: Akcija) {
        self.imeLabel.text = akcija.ime
        self.lokacijaLabel.text = akcija.lokacija
        let dateFormater = DateFormatter()
        dateFormater.dateStyle = .medium
        dateFormater.timeStyle = .long
        if let vreme = akcija.vreme {
        self.timeLabel.text = dateFormater.string(from: vreme)
        }
        self.opisLabel.text = akcija.opis
    }
}
