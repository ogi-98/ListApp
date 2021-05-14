//
//  ViewController.swift
//  ListApp
//
//  Created by Oğuz Kaya on 1.05.2021.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var Logo: UIImageView!
    @IBOutlet weak var ustPerde: UIView!
    @IBOutlet weak var altPerde: UIView!
    @IBOutlet weak var UstPerdeYukseklik: NSLayoutConstraint!
    @IBOutlet weak var AltPerdeYukseklik: NSLayoutConstraint!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        print("opened")
  
    }

    override func viewDidAppear(_ animated: Bool) {
//        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
//            self.Animasyon()
//
//        }
        Animasyon()
    }
    
    func Animasyon(){
        UIView.animate(withDuration: 1.0, delay: 0.0, options: .curveEaseInOut) {
            self.UstPerdeYukseklik.constant = 0.0
            self.AltPerdeYukseklik.constant = 0.0
            self.view.layoutIfNeeded()
        } completion: { (finish) in
            print("Bitti")
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                (UIApplication.shared.delegate as! AppDelegate).goToInitialScreen()
            }
            
        }

    }
    
    

}

