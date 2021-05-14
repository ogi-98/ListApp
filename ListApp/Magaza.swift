//
//  Magaza.swift
//  ListApp
//
//  Created by Oğuz Kaya on 2.05.2021.
//

import Foundation

class Magaza {
    var name: String
    var category: String
    var floor: String
    var imageUrl: String
    var detailImageUrl: String
    var detailText: String
    var phoneNumber: String
    var webSite: String
    var id: String
    
    init(name: String, category: String, floor: String, imageUrl:String, detailImageUrl:String, detailText: String, phoneNumber: String, webSite: String, id:String ) {
        self.name = name
        self.category = category
        self.floor = floor
        self.imageUrl = imageUrl
        self.detailImageUrl = detailImageUrl
        self.detailText = detailText
        self.phoneNumber = phoneNumber
        self.webSite = webSite
        self.id = id
    }
    static func transformMagaza(dict: [String:Any], keyId:String) -> Magaza? {
        guard let name = dict["name"] as? String,
              let category = dict["category"] as? String,
              let floor = dict["floor"] as? String,
              let imageUrl = dict["imageUrl"] as? String,
              let detailImageUrl = dict["detailImageUrl"] as? String,
              let detailText = dict["detailText"] as? String,
              let phoneNumber = dict["phoneNumber"] as? String,
              let webSite = dict["webSite"] as? String else { return nil }
        
        let magaza = Magaza(name: name, category: category, floor: floor, imageUrl: imageUrl, detailImageUrl: detailImageUrl, detailText: detailText, phoneNumber: phoneNumber, webSite: webSite, id: keyId)
        return magaza
    }
    
    
}
