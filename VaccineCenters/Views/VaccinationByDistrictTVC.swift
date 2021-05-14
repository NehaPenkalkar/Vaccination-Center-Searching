//
//  VaccinationByDistrictTVC.swift
//  VaccineCenters
//
//  Created by Neha Penkalkar on 14/05/21.
//

import UIKit

class VaccinationByDistrictTVC: UITableViewCell {
    
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var idLbl: UILabel!
    @IBOutlet weak var viewDetails: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
