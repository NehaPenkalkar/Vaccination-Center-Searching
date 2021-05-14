//
//  DistrictNameVC.swift
//  VaccineCenters
//
//  Created by Neha Penkalkar on 12/05/21.
//

import UIKit
import Alamofire

class DistrictNameVC: UIViewController {
    
    @IBOutlet weak var districtDisplayTV: UITableView!
    
    var stateId = Int()
    
    var district = [NSDictionary]()
    
    var navTitle = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.navigationItem.title = "\(navTitle)"
        districtAPI()
    }
    
    func districtAPI(){
        
        AF.request("https://cdn-api.co-vin.in/api/v2/admin/location/districts/\(stateId)").responseJSON{(resp) in
            if let  data = resp.value as? NSDictionary {
                
                self.district = data.value(forKey: "districts") as! [NSDictionary]
                self.districtDisplayTV.reloadData()
            }
            else {
                
                print("Error")
            }
        }
    }
}


//MARK:- TableView From Here
extension DistrictNameVC: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        district.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
        
        let name = district[indexPath.row].value(forKey: "district_name") as? String ?? ""
        cell.textLabel?.text = "\(name)"
        
        let id = district[indexPath.row].value(forKey: "district_id") as? Int ?? 0
        cell.detailTextLabel?.text = "\(id)"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "FindByDistrictVC") as! FindByDistrictVC
        let id = district[indexPath.row].value(forKey: "district_id") as? Int ?? 0
        vc.text = "\(id)"
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.1
    }
}
