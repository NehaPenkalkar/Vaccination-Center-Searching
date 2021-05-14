//
//  FindByDistrictVC.swift
//  VaccineCenters
//
//  Created by Neha Penkalkar on 12/05/21.
//

import UIKit

class FindByDistrictVC: UIViewController, UITextFieldDelegate{
    
    @IBOutlet weak var distIdTF: UITextField!
    @IBOutlet weak var dateTF: UITextField!
    
    var text = ""
    
    private var datePicker: UIDatePicker?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        if (distIdTF != nil)
        {
            distIdTF.text = "\(text)"
        }
        
        pickDate()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("Yayyyyyy")
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    
    func pickDate(){
        datePicker = UIDatePicker()
        datePicker?.datePickerMode = .date
        datePicker?.addTarget(self, action: #selector(dateChanged(sender:)), for: .valueChanged)
        dateTF.inputView = datePicker
    }
    
    @objc func dateChanged(sender: UIDatePicker){
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = "dd-MM-yyyy"
        dateTF.text = dateFormat.string(from: sender.date)
        view.endEditing(true)
    }
    
    @IBAction func searchPress(_ sender: UIButton) {
        
        let error = validateFields()
        if error != nil{
            
            showErr(title: error!)
        }else{
            
            let vc = storyboard?.instantiateViewController(withIdentifier: "vaccinationByDistrict") as! VaccinationByDistrict
            vc.id = distIdTF.text!
            vc.date = dateTF.text!
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func showErr(title: String){
        let alert = UIAlertController(title: "\(title)", message: nil, preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(ok)
        present(alert, animated: true, completion: nil)
    }
    
    
    //MARK:- Validate Fields
    func validateFields() -> String? {
        
        if distIdTF.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            dateTF.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""{
            
            return "Please fill in all fields"
        }
        
        //Checks if the date is correct
        let cleanDate = dateTF.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        if validateDate(date: cleanDate) == false{
            
            return "Make sure you've entered date in correct format (dd-mm-yyyy)"
        }
        return nil
    }
    
    func validateDate(date: String) -> Bool{
        let dateRegex = "^(?:(?:31(\\/|-|\\.)(?:0?[13578]|1[02]))\\1|(?:(?:29|30)(\\/|-|\\.)(?:0?[13-9]|1[0-2])\\2))(?:(?:1[6-9]|[2-9]\\d)?\\d{2})$|^(?:29(\\/|-|\\.)0?2\\3(?:(?:(?:1[6-9]|[2-9]\\d)?(?:0[48]|[2468][048]|[13579][26])|(?:(?:16|[2468][048]|[3579][26])00))))$|^(?:0?[1-9]|1\\d|2[0-8])(\\/|-|\\.)(?:(?:0?[1-9])|(?:1[0-2]))\\4(?:(?:1[6-9]|[2-9]\\d)?\\d{2})$"
        let datePredicate = NSPredicate(format: "SELF MATCHES %@", dateRegex)
        let dateValidates = datePredicate.evaluate(with: date) as Bool
        return dateValidates
    }
    
}
