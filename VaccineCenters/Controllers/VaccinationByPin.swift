//
//  vaccinationByPin.swift
//  VaccineCenters
//
//  Created by Neha Penkalkar on 13/05/21.
//

import UIKit
import Alamofire
import Lottie

class VaccinationByPin: UIViewController {
    
    @IBOutlet weak var actInd: AnimationView!
    
    @IBOutlet weak var vaccinationPinTV: UITableView!
    
    var pVaccine = [NSDictionary]()
    
    var id = String()
    var date = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.navigationItem.title = "Vaccination Centers"
        vaccinationPinAPI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        actInd.play()
        actInd.loopMode = .loop
    }
    
    func vaccinationPinAPI(){
        if Connectivity.isConnectedToInternet(){
            AF.request("https://cdn-api.co-vin.in/api/v2/appointment/sessions/public/findByPin?pincode=\(id)&date=\(date)").responseJSON{(resp) in
                if let  data = resp.value as? NSDictionary {
                    
                    self.actInd.pause()
                    self.actInd.isHidden = true
                    
                    self.pVaccine = data.value(forKey: "sessions") as! [NSDictionary]
                    
                    self.vaccinationPinTV.reloadData()
                    
                    if self.pVaccine.isEmpty{
                        
                        self.vaccinationPinTV.isHidden = true
                        let alert = UIAlertController(title: "No Data Found", message: "The area you are looking into has no vaccination centers available for now", preferredStyle: .alert)
                        let ok = UIAlertAction(title: "OK", style: .cancel) { alert in
                            self.navigationController?.popViewController(animated: true)
                        }
                        
                        alert.addAction(ok)
                        self.present(alert, animated: true, completion: nil)
                    }
                }
                else {
                    
                    print("Some Error")
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
extension VaccinationByPin: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        pVaccine.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
        
        let name = pVaccine[indexPath.row].value(forKey: "name") as? String ?? ""
        cell.textLabel?.text = "\(name)"
        
        let id = pVaccine[indexPath.row].value(forKey: "center_id") as? Int ?? 0
        cell.detailTextLabel?.text = "\(id)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.1
    }
}
