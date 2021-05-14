//
//  SignUpPage.swift
//  ListApp
//
//  Created by Oğuz Kaya on 1.05.2021.
//

import UIKit

class SignUpPage: UIViewController {

    @IBOutlet weak var NicknameTxt: UITextField!
    @IBOutlet weak var EmailTxt: UITextField!
    @IBOutlet weak var PassTxt: UITextField!
    @IBOutlet weak var PassAgainTxt: UITextField!
    @IBOutlet weak var SignUpBttn: UIButton!
    @IBOutlet weak var LoginBttn: UIButton!
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        signUpUI()
        
        
    }
    
    
    
    func signUpUI() {
        NicknameTxt.donebuttonYap(action: #selector(hideKeyboard))
        EmailTxt.donebuttonYap(action: #selector(hideKeyboard))
        PassTxt.donebuttonYap(action: #selector(hideKeyboard))
        PassAgainTxt.donebuttonYap(action: #selector(hideKeyboard))
        
        SignUpBttn.layer.cornerRadius = 10
        SignUpBttn.clipsToBounds = true
        
        let atributedText = NSMutableAttributedString(string: "Already have an account? ", attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 15), NSAttributedString.Key.foregroundColor : UIColor.systemGray])
        if #available(iOS 13.0, *) {
            let atributedSecondText = NSMutableAttributedString(string: "Log-in", attributes: [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 17), NSAttributedString.Key.foregroundColor : UIColor.label])
            atributedText.append(atributedSecondText)
        } else {
            // Fallback on earlier versions
            let atributedSecondText = NSMutableAttributedString(string: "Log In", attributes: [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 17), NSAttributedString.Key.foregroundColor : UIColor.black])
            atributedText.append(atributedSecondText)
        }
        LoginBttn.setAttributedTitle(atributedText, for: .normal)
        
        let ViewDeclineKeyboard = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        self.view.addGestureRecognizer(ViewDeclineKeyboard)
    }
    
    func validateFields() -> String? {
        // Check that all fields are filled in
        if NicknameTxt.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            EmailTxt.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            PassTxt.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            PassAgainTxt.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            let er = "Please fill in all fields"
            return er
        }
        return nil
    }
    
    
    
    @IBAction func SignUpTouch(_ sender: UIButton) {
        hideKeyboard()
        self.showSpinner()
        if validateFields() == nil {
            let nickname = NicknameTxt.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let mail = EmailTxt.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let pass = PassTxt.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let passAgain = PassAgainTxt.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            if isValidEmail(email: mail) {
                print("valid email")
                if pass == passAgain {
                    print("kullanici kayit basliyor")
                    
                    Api.User.userSignUp(mail: mail, pass: pass) {
                        
                        Api.User.saveUserInfo(nickName: nickname) {
                            self.removeSpinner()
                            (UIApplication.shared.delegate as! AppDelegate).GoToListViewScreen()
                            
                            
                        } onError: { er in
                            self.removeSpinner()
                            self.simpleAlertView(title: "Save Eror!", message: er, buttontitle: "Cancel")
                        }

                        
                    } onError: { er in
                        self.removeSpinner()
                        self.simpleAlertView(title: "Eror!", message: er, buttontitle: "Cancel")
                    }

                    
                }else{
                    self.removeSpinner()
                    simpleAlertView(title: "Password!", message: "Passwords don't match", buttontitle: "Cancel")
                }
            }else{
                self.removeSpinner()
                simpleAlertView(title: "Invalid E-mail", message: "Please check your email", buttontitle: "Cancel")
            }
            
        }else{
            self.removeSpinner()
            simpleAlertView(title: "Invalid Fields!", message: validateFields()!, buttontitle: "Cancel")
        }
    }
    
    @IBAction func LoginBttnTouch(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
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


