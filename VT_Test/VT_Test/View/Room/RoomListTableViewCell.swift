//
//  RoomListTableViewCell.swift
//  VT_Test
//
//  Created by Asadullah Jamadar on 28/11/2022.
//

import UIKit

class RoomListTableViewCell: UITableViewCell {
    
    @IBOutlet weak var m_thumbnailImageView: UIImageView!
    @IBOutlet weak var m_titleLabel: UILabel!
    
    @IBOutlet weak var m_subTitleLabel: UILabel!
    
    
    @IBOutlet weak var m_dateLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
