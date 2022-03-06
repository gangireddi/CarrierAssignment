//
//  DeviceDetailsCell.swift
//  CarrierAssignment
//
//  Created by Sandeep on 06/03/22.
//

import UIKit

class DeviceDetailsCell: UITableViewCell {
    
    @IBOutlet weak var idLbl: UILabel!
    @IBOutlet weak var modelLbl: UILabel!
    @IBOutlet weak var thValLbl: UILabel!
    @IBOutlet weak var cellBgVw: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
