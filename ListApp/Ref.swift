//
//  Ref.swift
//  ListApp
//
//  Created by Oğuz Kaya on 6.05.2021.
//

import Foundation
import Firebase

class Ref {
    let REF_USER = "users"
    let REF_BRANDS = "brands"
    let databaseRoot: DatabaseReference = Database.database().reference()
    var databaseUsers: DatabaseReference{
        return databaseRoot.child(REF_USER)
    }
    func databaseSpecificUser(uid:String) -> DatabaseReference {
        return databaseUsers.child(uid)
    }
    
    var databaseBrands: DatabaseReference{
        return databaseRoot.child(REF_BRANDS)
    }
    func databaseSpecificBrands(uid:String) -> DatabaseReference {
        return databaseBrands.child(uid)
    }
    
}
