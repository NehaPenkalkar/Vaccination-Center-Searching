//
//  DetailsVC.swift
//  VaccineCenters
//
//  Created by Neha Penkalkar on 14/05/21.
//

import UIKit

class DetailsVC: UIViewController {
    
    var address = ""
    var from = ""
    var fees = ""
    var vaccineName = ""
    var slots = ""

    @IBOutlet weak var addressLbl: UILabel!
    @IBOutlet weak var fromTimeLbl: UILabel!
    @IBOutlet weak var feesLbl: UILabel!
    @IBOutlet weak var vaccineNameLbl: UILabel!
    @IBOutlet weak var slotsLbl: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        addressLbl.text = address
        fromTimeLbl.text = from
        feesLbl.text = fees
        vaccineNameLbl.text = vaccineName
        slotsLbl.text = slots
        
    }
}
