//
//  MessageCell.swift
//  Flash Chat iOS13
//
//  Created by Jay Cool on 3/24/22.
//  Copyright © 2022 Angela Yu. All rights reserved.
//

import UIKit

// awakeFromNib, Nib is an old name for the xib. Whats happening here is going to initialize w/e it is that we put into this design here. 

class MessageCell: UITableViewCell {

    @IBOutlet weak var messageBubble: UIView!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var rightImageView: UIImageView!
    @IBOutlet weak var leftImageView: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        messageBubble.layer.cornerRadius = messageBubble.frame.size.height / 5
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
