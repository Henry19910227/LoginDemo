//
//  FBLoginViewController.swift
//  LoginDemo
//
//  Created by 廖冠翰 on 2022/7/23.
//

import UIKit
import FacebookLogin

class FBLoginViewController: UIViewController {

    @IBOutlet weak var textView: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Add a custom login button to your app
        let loginButton = UIButton(type: .custom)
        loginButton.backgroundColor = .darkGray
        loginButton.frame = CGRect(x: 0, y: 0, width: 180, height: 40)
        loginButton.center = view.center
        loginButton.setTitle("Login", for: .normal)

        // Handle clicks on the button
        loginButton.addTarget(self, action: #selector(loginButtonClicked), for: .touchUpInside)

        view.addSubview(loginButton)
    }
    
    // Once the button is clicked, show the login dialog
    @objc func loginButtonClicked() {
          let loginManager = LoginManager()
          loginManager.logIn(permissions: ["public_profile"], from: self) { result, error in
              if let error = error {
                  print("Encountered Erorr: \(error)")
              } else if let result = result, result.isCancelled {
                  print("Cancelled")
              } else {
                  print("Logged In")
                  self.textView.text = result?.token?.tokenString
                  UIPasteboard.general.string = result?.token?.tokenString
              }
          }
      }
}
