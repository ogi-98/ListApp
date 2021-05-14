//
//  Brands.swift
//  ListApp
//
//  Created by Oğuz Kaya on 7.05.2021.
//

import Foundation
import Firebase

class Brands {
    
    func getBrands(onSuccess:@escaping(Magaza) -> Void, onError:@escaping(_ errMessage: String) -> Void){
        Api.Database.databaseBrands.observe(.childAdded) { (snapshot) in
            if let dict = snapshot.value as? Dictionary<String,Any> {
                if let brands = Magaza.transformMagaza(dict: dict,keyId: snapshot.key) {
                    onSuccess(brands)
                }
            }
        }
        
    }
    
}
