//
//  IntroVC.swift
//  VaccineCenters
//
//  Created by Neha Penkalkar on 13/05/21.
//

import UIKit

class IntroVC: UIViewController {
    
    @IBOutlet weak var introCV: UICollectionView!
    @IBOutlet weak var pageCtrl: UIPageControl!
    
    @IBOutlet weak var nextBtn: UIButton!
    @IBOutlet weak var skipBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        nextBtn.isHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
}


extension IntroVC: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "IntroCVC", for: indexPath) as! IntroCVC
        
        //let color: [UIColor] = [.red,.orange,.yellow,.green,.blue]
        // cell.introAnimeView.backgroundColor = color[indexPath.row]
        
        let imgNames = ["face","mask","washHands","distancing","eatHealthy","stayHome"]
        cell.imgView.image = UIImage(named: "\(imgNames[indexPath.row])")
        
        let lblNames = ["Don't Touch Your Face. 🙅🏻‍♀️","I Wear a Mask to Protect You, You Wear a Mask to Protect Me. 😷","Bury the Germs, Wash Your Hands. 🧤","Maintain the Gap. 🧍🏼‍♂️←→🧍🏻‍♀️","A Healthy Outside Starts From the Inside. 🥗","Stay Home, Stay Healthy, Stay Safe."]
        cell.introLbl.text = "\(lblNames[indexPath.row])"
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width, height: collectionView.frame.size.height)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        print("Scroll Finish \(scrollView.contentOffset.x) CVW -> \(scrollView.frame.size.width) ")
        
        
        
        if scrollView.contentOffset.x/scrollView.frame.size.width == 0{
            
            print("wohoo")
            nextBtn.isHidden = true
            skipBtn.isHidden = false
        }else if scrollView.contentOffset.x/scrollView.frame.size.width == 5 {
            
            nextBtn.isHidden = false
            skipBtn.isHidden = true
        }else{
            
            nextBtn.isHidden = true
            skipBtn.isHidden = true
        }
        
        pageCtrl.currentPage = Int(scrollView.contentOffset.x/scrollView.frame.size.width)
    }
    
}
