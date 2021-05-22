//
//  UserApi.swift
//  ListApp
//
//  Created by Oğuz Kaya on 6.05.2021.
//

import Foundation
import Firebase

class UserApi {
    
    func getCurrentUser() -> Bool{
        if Auth.auth().currentUser == nil  {
            return false
        }else{
            return true
        }
    }
    
    func userSignUp(mail:String,pass:String, onSucces: @escaping() -> Void , onError: @escaping(_ errMessage: String) -> Void) {
        
        Auth.auth().createUser(withEmail: mail, password: pass) { (user, error) in
            if error == nil{
                onSucces()
            }else{
                onError(error?.localizedDescription ?? "Sign-up error!")
            }
        }
    }
    func logOut(onSucces: @escaping() -> Void , onError: @escaping(_ errMessage: String) -> Void) {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
        } catch let signOutError as NSError {
            onError(signOutError.localizedDescription)
            return
        }
        onSucces()
    }
    func userSignIn(mail:String,pass:String, onSucces: @escaping() -> Void , onError: @escaping(_ errMessage: String) -> Void) {
        Auth.auth().signIn(withEmail: mail, password: pass) { (user, error) in
            if error == nil{
                onSucces()
            }else{
                onError(error?.localizedDescription ?? "Sign-in error!")
            }
        }
    }
    func saveUserInfo(nickName:String, onSuccess : @escaping() -> Void, onError : @escaping( _ errMessage: String) -> Void ) {
        let user = Auth.auth().currentUser
        let infos = ["nickname":nickName,"email":user?.email as Any, "uid":user?.uid as Any] as [String:Any]
        
        Api.Database.databaseSpecificUser(uid: user!.uid).updateChildValues(infos){ (err,referans) in
            if err != nil {
                onError(err?.localizedDescription ?? "Error User Sign-up")
            }else{
                onSuccess()
            }
            
        }
    }
    
    
}
