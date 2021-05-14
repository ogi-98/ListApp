//
//  DetailsViewController.swift
//  ListApp
//
//  Created by Oğuz Kaya on 6.05.2021.
//

import UIKit

class DetailsViewController: UIViewController {
    
    @IBOutlet var Resim: UIImageView!
    @IBOutlet weak var nameTitle: UILabel!
    @IBOutlet weak var floorTitle: UILabel!
    @IBOutlet weak var infoTitle: UILabel!
    @IBOutlet weak var DetailText: UITextView!
    @IBOutlet weak var detailLogo: UIImageView!
    @IBOutlet weak var DeatilcontainerView: UIView!
    
    var detailImage: UIImage!
    var detailName:String!
    var detailFloor:String!
    var detailInfo:String!
    var brandTelNumber: String? = nil
    var brandWebPage: String? = nil
    var brand: Magaza? = nil
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let brands = brand else { return }
        ConfigureView(brand: brands)
        // Do any additional setup after loading the view.
    }
    
    func ConfigureView(brand:Magaza) {
        self.nameTitle.text = brand.name
        let floorText = "Floor: " + brand.floor
        self.floorTitle.text = floorText
        let categoryText = "Category: " + brand.category
        self.infoTitle.text = categoryText
        self.DetailText.text = brand.detailText
        self.brandTelNumber = brand.phoneNumber
        self.brandWebPage = brand.webSite
        self.Resim.loadImageFromWeb(withUrl: brand.detailImageUrl)
        self.detailLogo.loadImageFromWeb(withUrl: brand.imageUrl)
        self.DeatilcontainerView.layer.cornerRadius = 10
        self.DeatilcontainerView.clipsToBounds = true
        
        

    }
    
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    @IBAction func phonePress(_ sender: UIButton) {
        guard let phoneNumber = brandTelNumber else { return }
        guard let url = URL(string: "tel://" + phoneNumber),
              UIApplication.shared.canOpenURL(url) else { return }
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
    @IBAction func webPress(_ sender: UIButton) {
        if brandWebPage != "" && brandWebPage != nil {
            if let url = URL(string: "https://" + brandWebPage!) {
                UIApplication.shared.open(url)
            }
        } else {
            print("empty url")
        }
    }
    
}
