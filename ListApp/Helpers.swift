//
//  Helpers.swift
//  ListApp
//
//  Created by Oğuz Kaya on 2.05.2021.
//

import UIKit

fileprivate var aView : UIView?
fileprivate let ai = UIActivityIndicatorView(style: .whiteLarge)
extension UIViewController{
    //MARK: activity indicator
    func showSpinner(){
        aView = UIView(frame: self.view.bounds)
        aView?.backgroundColor = UIColor(white: 0.5, alpha: 0.5)
        ai.center = aView!.center
        aView?.addSubview(ai)
        self.view.addSubview(aView!)
        ai.startAnimating()
    }
    func removeSpinner(){
        ai.stopAnimating()
        aView?.removeFromSuperview()
        aView = nil
    }
    
    //MARK: Alert view
    func simpleAlertView(title:String, message:String, buttontitle:String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        
        alert.addAction(UIAlertAction(title: buttontitle, style: UIAlertAction.Style.cancel, handler: { _ in
            //Cancel Action
        }))
//        alert.addAction(UIAlertAction(title: "Sign out",
//                                      style: UIAlertAction.Style.destructive,
//                                      handler: {(_: UIAlertAction!) in
//                                        //Sign out action
//                                      }))
        self.present(alert, animated: true, completion: nil)
    }
    func logOutAlertView(title:String, message:String, onLogout: @escaping() -> Void ) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.actionSheet)
        
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: { _ in
            //Cancel Action
        }))
        alert.addAction(UIAlertAction(title: "Log out",
                                      style: UIAlertAction.Style.destructive,
                                      handler: {(_: UIAlertAction!) in
                                        //Sign out action
                                        onLogout()
                                      }))
        self.present(alert, animated: true, completion: nil)
    }
    
}

//MARK: Email validation
func isValidEmail(email: String) -> Bool {
    let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
    
    let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
    return emailPred.evaluate(with: email)
}

extension UITextField{
    func donebuttonYap(action:Selector) {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        toolbar.barStyle = .default
        //bar button
        let doneBtn = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: action)
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        toolbar.setItems([flexSpace,doneBtn], animated: true)
        self.inputAccessoryView = toolbar
    }
}

extension UIImageView{
    func loadImageFromWeb(withUrl urlString: String) {
        if urlString != "" {
            guard let imageUrl:URL = URL(string: urlString) else {
                return
            }
            DispatchQueue.global().async { [weak self] in
                if let imageData = try? Data(contentsOf: imageUrl) {
                    if let imageFromWeb = UIImage(data: imageData){
                        DispatchQueue.main.async {
                            self?.image = imageFromWeb
                            self?.alpha = 1.0
                        }
                    }
                }
            }
        } else {
            print("urlString can not be empty!!")
        }
    }
    
    
}
