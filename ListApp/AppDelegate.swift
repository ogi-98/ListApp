//
//  AppDelegate.swift
//  ListApp
//
//  Created by Oğuz Kaya on 1.05.2021.
//

import UIKit
import Firebase


@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window : UIWindow?
    

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        self.window = UIWindow(frame: UIScreen.main.bounds)
//        GoToMainScreen()
        FirebaseApp.configure()
        GoToMainScreen()
        return true
    }
    
    func goToInitialScreen() {
        if Api.User.getCurrentUser() {
            GoToListViewScreen()
        }else{
            GoToSignUpScreen()
        }
    }

    func GoToMainScreen(){
        var initialVC : UIViewController
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        initialVC = storyBoard.instantiateViewController(withIdentifier: "Giris")
        self.window?.rootViewController = initialVC
        self.window?.makeKeyAndVisible()
    }
    func GoToSignUpScreen(){
        var initialVC : UIViewController
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        initialVC = storyBoard.instantiateViewController(withIdentifier: "WelcomeMain")
        self.window?.rootViewController = initialVC
        self.window?.makeKeyAndVisible()
    }
    func GoToLoginScreen(){
        var initialVC : UIViewController
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        initialVC = storyBoard.instantiateViewController(withIdentifier: "Login")
        self.window?.rootViewController = initialVC
        self.window?.makeKeyAndVisible()
    }
    func GoToListViewScreen(){
        var initialVC : UIViewController
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        initialVC = storyBoard.instantiateViewController(withIdentifier: "ListView")
        self.window?.rootViewController = initialVC
        self.window?.makeKeyAndVisible()
    }
    
    
    // MARK: UISceneSession Lifecycle

    @available(iOS 13.0, *)
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    @available(iOS 13.0, *)
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

