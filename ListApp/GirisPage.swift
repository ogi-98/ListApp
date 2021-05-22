//
//  GirisPage.swift
//  ListApp
//
//  Created by Oğuz Kaya on 1.05.2021.
//

import UIKit
import Firebase

class GirisPage: UIViewController {

    @IBOutlet weak var EmailTxt: UITextField!
    @IBOutlet weak var PassTxt: UITextField!
    @IBOutlet weak var LoginBttn: UIButton!
    @IBOutlet weak var EnterNoLogin: UIButton!
    @IBOutlet weak var DescLbl: UILabel!
    @IBOutlet weak var SignUpBttn: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        PageUI()
    }
    
    func PageUI(){
        EmailTxt.donebuttonYap(action: #selector(hideKeyboard))
        PassTxt.donebuttonYap(action: #selector(hideKeyboard))
        
        DescLbl.text = "Welcome! \nEnter your information"
        LoginBttn.layer.cornerRadius = 10
        LoginBttn.clipsToBounds = true
        
        let atributedText = NSMutableAttributedString(string: "Don't have an account?  ", attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 15), NSAttributedString.Key.foregroundColor : UIColor.systemGray])
        if #available(iOS 13.0, *) {
            let atributedSecondText = NSMutableAttributedString(string: "Sign-up", attributes: [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 17), NSAttributedString.Key.foregroundColor : UIColor.label])
            atributedText.append(atributedSecondText)
        } else {
            // Fallback on earlier versions
            let atributedSecondText = NSMutableAttributedString(string: "Sign Up", attributes: [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 17), NSAttributedString.Key.foregroundColor : UIColor.black])
            atributedText.append(atributedSecondText)
        }
        SignUpBttn.setAttributedTitle(atributedText, for: .normal)
        
        let atributedText2 = NSMutableAttributedString(string: "Use the application  ", attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 12), NSAttributedString.Key.foregroundColor : UIColor.systemGray])
        if #available(iOS 13.0, *) {
            let atributedSecondText2 = NSMutableAttributedString(string: "Anonymously", attributes: [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 14), NSAttributedString.Key.foregroundColor : UIColor.label])
            atributedText2.append(atributedSecondText2)
        } else {
            // Fallback on earlier versions
            let atributedSecondText2 = NSMutableAttributedString(string: "Anonymously", attributes: [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 14), NSAttributedString.Key.foregroundColor : UIColor.black])
            atributedText2.append(atributedSecondText2)
        }
        EnterNoLogin.setAttributedTitle(atributedText2, for: .normal)
        
        let ViewDeclineKeyboard = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        self.view.addGestureRecognizer(ViewDeclineKeyboard)
    }
    
    
    
    func validateFields() -> String? {
        // Check that all fields are filled in
        if  EmailTxt.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            PassTxt.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            let er = "Please fill in all fields"
            return er
        }
        return nil
    }

    @IBAction func LoginBttnTouch(_ sender: UIButton) {
        
        hideKeyboard()
        self.showSpinner()
        if validateFields() == nil {
            let mail = EmailTxt.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let pass = PassTxt.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            if isValidEmail(email: mail) {
                print("valid email")

                print("kullanici giris basliyor")
                Api.User.userSignIn(mail: mail, pass: pass) {
                    self.removeSpinner()
                    (UIApplication.shared.delegate as! AppDelegate).GoToListViewScreen()
                } onError: { (error) in
                    self.removeSpinner()
                    self.simpleAlertView(title: "SignIn Error!", message: error, buttontitle: "Cancel")
                }

            }else{
                self.removeSpinner()
                simpleAlertView(title: "Invalid E-mail!", message: "Please check your email", buttontitle: "Cancel")
            }
            
        }else{
            self.removeSpinner()
            simpleAlertView(title: "Invalid Fields!", message: validateFields()!, buttontitle: "Cancel")
        }
        
    }
    @IBAction func EnterNoLoginTouch(_ sender: UIButton) {
        (UIApplication.shared.delegate as! AppDelegate).GoToListViewScreen()
    }
    
    @IBAction func SignUpBttnTouch(_ sender: UIButton) {
    }
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    @objc func hideKeyboard() {
        view.endEditing(true)
    }

}
