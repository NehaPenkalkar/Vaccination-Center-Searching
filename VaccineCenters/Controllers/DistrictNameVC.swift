//
//  DistrictNameVC.swift
//  VaccineCenters
//
//  Created by Neha Penkalkar on 12/05/21.
//

import UIKit
import Alamofire
import Lottie

class DistrictNameVC: UIViewController {
    
    @IBOutlet weak var actInd: AnimationView!
    
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
    
    override func viewWillAppear(_ animated: Bool) {
        actInd.play()
        actInd.loopMode = .loop
    }
    
    func districtAPI(){
        
        if Connectivity.isConnectedToInternet(){
            
            AF.request("https://cdn-api.co-vin.in/api/v2/admin/location/districts/\(stateId)").responseJSON{(resp) in
                if let  data = resp.value as? NSDictionary {
                    
                    self.actInd.pause()
                    self.actInd.isHidden = true
                    
                    self.district = data.value(forKey: "districts") as! [NSDictionary]
                    self.districtDisplayTV.reloadData()
                }
                else {
                    
                    print("Error")
                }
            }
        }else{
            
            self.actInd.pause()
            self.actInd.isHidden = true
            showErr(title: "No Internet Connection!!", message: "Please Check Your Internet Connection and Try Again")
        }
        
    }
    
    func showErr(title: String, message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "Ok", style: .cancel) { alert in
            
            self.navigationController?.popViewController(animated: true)
        }
        alert.addAction(ok)
        present(alert, animated: true, completion: nil)
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
        
        let name = district[indexPath.row].value(forKey: "district_name") as? String ?? ""
        vc.name = "\(name)"
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.1
    }
}
