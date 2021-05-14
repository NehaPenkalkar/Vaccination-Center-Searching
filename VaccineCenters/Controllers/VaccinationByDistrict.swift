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
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
        
        let name = dVaccine[indexPath.row].value(forKey: "name") as? String ?? ""
        cell.textLabel?.text = "\(name)"
        
        let id = dVaccine[indexPath.row].value(forKey: "center_id") as? Int ?? 0
        cell.detailTextLabel?.text = "\(id)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.1
    }
}
