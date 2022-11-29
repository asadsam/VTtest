//
//  RoomDetailsTableViewCell.swift
//  VT_Test
//
//  Created by Asadullah Jamadar on 28/11/2022.
//

import UIKit

class EmployeeDetailsTableViewCell: UITableViewCell {

    @IBOutlet weak var m_jobTitle: UILabel!
    @IBOutlet weak var m_email: UILabel!
    @IBOutlet weak var m_favoriteColor: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
