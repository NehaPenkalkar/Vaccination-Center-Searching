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
    
    
    let color: [UIColor] = [#colorLiteral(red: 0.6774190068, green: 0.8229250312, blue: 0.7641521096, alpha: 1),#colorLiteral(red: 0.9568627477, green: 0.6588235497, blue: 0.5450980663, alpha: 1),#colorLiteral(red: 0.5849013329, green: 0.5724678636, blue: 0.6870082617, alpha: 1),#colorLiteral(red: 0.5146358609, green: 0.6227608323, blue: 0.7774812579, alpha: 1),#colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1),#colorLiteral(red: 0.9542465806, green: 0.4870094061, blue: 0.3273182511, alpha: 1)]
    let imgNames = ["face","mask","washHands","distancing","eatHealthy","stayHome"]
    let lblNames = ["Don't Touch Your Face. 🙅🏻‍♀️","I Wear a Mask to Protect You, You Wear a Mask to Protect Me. 😷","Bury the Germs, Wash Your Hands. 🧤","Maintain the Gap. 🧍🏼‍♂️←→🧍🏻‍♀️","A Healthy Outside Starts From the Inside. 🥗","Stay Home, Stay Healthy, Stay Safe."]
    
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
        
        cell.introView.backgroundColor = color[indexPath.row]
        
        cell.imgView.image = UIImage(named: "\(imgNames[indexPath.row])")
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
