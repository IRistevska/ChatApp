//
//  ReceiverTableViewCell.swift
//  ChatAppProject
//
//  

import UIKit

class ReceiverTableViewCell: UITableViewCell {
    @IBOutlet weak var receiverNameLabel: UILabel!
    @IBOutlet weak var receiverTextLabel: UILabel!
    @IBOutlet weak var receiverDateLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    func setUpCell(message:Message, senderName:String){
        receiverDateLabel.text = message.sentAt?.description
        receiverTextLabel.text = message.text
        receiverNameLabel.text = senderName
    }
    

}
