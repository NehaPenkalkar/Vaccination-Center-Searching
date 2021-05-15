//
//  StateNameVC.swift
//  VaccineCenters
//
//  Created by Neha Penkalkar on 12/05/21.
//

import UIKit
import Alamofire
import Lottie

class StateNameVC: UIViewController {
    
    @IBOutlet weak var actInd: AnimationView!
    
    var state = [NSDictionary]()
    
    @IBOutlet weak var stateDisplayTV: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        stateAPI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        actInd.play()
        actInd.loopMode = .loop
    }
    
    
    func stateAPI(){
        
        if Connectivity.isConnectedToInternet(){
            AF.request("https://cdn-api.co-vin.in/api/v2/admin/location/states").responseJSON{(resp) in
                if let  data = resp.value as? NSDictionary {
                    
                    self.actInd.pause()
                    self.actInd.isHidden = true
                    
                    self.state = data.value(forKey: "states") as! [NSDictionary]
                    self.stateDisplayTV.reloadData()
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
extension StateNameVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        state.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
        
        let name = state[indexPath.row].value(forKey: "state_name") as? String ?? ""
        cell.textLabel?.text = "\(name)"
        
        let id = state[indexPath.row].value(forKey: "state_id") as? Int ?? 0
        cell.detailTextLabel?.text = "\(id)"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "DistrictNameVC") as! DistrictNameVC
        let id = state[indexPath.row].value(forKey: "state_id") as? Int ?? 0
        vc.stateId = id
        
        let title = state[indexPath.row].value(forKey: "state_name") as? String ?? ""
        vc.navTitle = "\(title)"
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.1
    }
}
