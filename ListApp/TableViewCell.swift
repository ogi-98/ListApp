//
//  TableViewCell.swift
//  ListApp
//
//  Created by Oğuz Kaya on 2.05.2021.
//

import UIKit

class CustomTableViewCell: UITableViewCell {

    
    @IBOutlet var resim: UIImageView!
    
    @IBOutlet weak var customName: UILabel!
   
    @IBOutlet weak var customCategory: UILabel!
    
    @IBOutlet weak var customFloor: UILabel!
    
    @IBOutlet weak var headerOfSeperator: UILabel!
    lazy var resimHeight: CGFloat = {
        return resim.frame.size.height / 2
    }()
    
    var controller: TableViewControllerBrands!
    var imageUrlString = String()
    var brand: Magaza? = nil
    
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        resim.layer.cornerRadius = resimHeight
        resim.clipsToBounds = true
        
    }
    func loadData( _ magaza:Magaza){

            self.customName.text = magaza.name
            self.customFloor.text = magaza.floor
            self.customCategory.text = magaza.category
            self.brand = magaza
            self.imageUrlString = magaza.imageUrl
            self.resim.loadImageFromWeb(withUrl: imageUrlString)
        
        

        
        
        
    }
    func NameFirstElementCreater(_ magaza:Magaza) {
        self.customName.isHidden = true
        self.customFloor.isHidden = true
        self.customCategory.isHidden = true
        self.brand = magaza
        self.resim.isHidden = true
        let lbl = UILabel(frame: CGRect(x: 0, y: 0, width: self.bounds.width, height: self.bounds.height))
        lbl.center = self.center
        lbl.font = .preferredFont(forTextStyle: .title1)
        lbl.text = String(magaza.name.prefix(1))
        self.addSubview(lbl)
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
