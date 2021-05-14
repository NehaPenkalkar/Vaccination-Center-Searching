//
//  vaccinationByDistrict.swift
//  VaccineCenters
//
//  Created by Neha Penkalkar on 12/05/21.
//

import UIKit
import Alamofire

class VaccinationByDistrict: UIViewController {
    
    @IBOutlet weak var vaccinationDistrictTV: UITableView!
    
    var dVaccine = [NSDictionary]()
    
    var id = String()
    var date = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.navigationItem.title = "Vaccination Centers"
        
        vaccinationDistrictAPI()
    }
    
    func vaccinationDistrictAPI(){
        
        AF.request("https://cdn-api.co-vin.in/api/v2/appointment/sessions/public/findByDistrict?district_id=\(id)&date=\(date)").responseJSON{(resp) in
            if let  data = resp.value as? NSDictionary {
                
                self.dVaccine = data.value(forKey: "sessions") as! [NSDictionary]
                self.vaccinationDistrictTV.reloadData()
                
                if self.dVaccine.isEmpty{
                    
                    self.vaccinationDistrictTV.isHidden = true
                    let alert = UIAlertController(title: "No Data Found", message: "The district you are looking into has no vaccination slots available.", preferredStyle: .alert)
                    
                    let ok = UIAlertAction(title: "OK", style: .cancel) { alert in
                        self.navigationController?.popViewController(animated: true)
                    }
                    
                    alert.addAction(ok)
                    self.present(alert, animated: true, completion: nil)
                }
            }
            else {
                
                print("Error")
            }
        }
    }
}

//MARK:- TableView From Here
extension VaccinationByDistrict: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        dVaccine.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "VaccinationByDistrictTVC") as! VaccinationByDistrictTVC
        
        let name = dVaccine[indexPath.row].value(forKey: "name") as? String ?? ""
        cell.nameLbl.text = "Center: \(name)"
        
        let id = dVaccine[indexPath.row].value(forKey: "center_id") as? Int ?? 0
        cell.idLbl.text = "Id: \(id)"
        
        cell.viewDetails.tag = indexPath.row
        cell.viewDetails.addTarget(self, action: #selector(viewDetailsPressed(sender:)), for: .touchUpInside)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.1
    }
    
    @objc func viewDetailsPressed(sender: UIButton){
        let vc = storyboard?.instantiateViewController(withIdentifier: "DetailsVC") as! DetailsVC
        let indexPath = IndexPath(row: sender.tag, section: 0)
        
        let address = dVaccine[indexPath.row].value(forKey: "address") as? String ?? "Address Unavailable"
        if address == ""{
            vc.address = "Address Unavailable"
        }else{
            vc.address = "Address: \(address)"
        }
        
        let fromTime = dVaccine[indexPath.row].value(forKey: "from") as? String ?? "Time Unavailable"
        let toTime = dVaccine[indexPath.row].value(forKey: "to") as? String ?? "Time Unavailable"
        if fromTime == "" || toTime == ""{
            vc.from = "Time Unavailable"
        }else{
            vc.from = "Time: \(fromTime) to \(toTime)"
        }
       
        
        let fees = dVaccine[indexPath.row].value(forKey: "fee_type") as? String ?? "Fees Unavailable"
        if fees == "Paid"{
            vc.fees = "Paid"
        }else{
            vc.fees = "Free"
        }
        
        let vaccine = dVaccine[indexPath.row].value(forKey: "vaccine") as? String ?? "Vaccine Name Unavailable"
        if vaccine == ""{
            vc.vaccineName = "Vaccine Name Unavailable"
        }else{
            vc.vaccineName = "Vaccine: \(vaccine)"
        }
        
        let availableSlots = dVaccine[indexPath.row].value(forKey: "slots") as! [String]
        let time = availableSlots.joined(separator: ",")
        if availableSlots.isEmpty{
            vc.slots = "Slots Unavailable"
        }else{
            vc.slots = "Slots: \(time)"
        }
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
