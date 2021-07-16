//
//  SenderTableViewCell.swift
//  ChatAppProject
//
//  Created by Riki on 5/23/19.
//  Copyright © 2019 Risto Anastasoski. All rights reserved.
//

import UIKit

class SenderTableViewCell: UITableViewCell {
    @IBOutlet weak var senderNameLabel: UILabel!
    @IBOutlet weak var senderTextLabel: UILabel!
    @IBOutlet weak var senderDateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func setUpCell(message:Message, senderName: String){
        senderDateLabel.text = message.sentAt?.description
        senderTextLabel.text = message.text
        senderNameLabel.text = senderName
    }
    
}
