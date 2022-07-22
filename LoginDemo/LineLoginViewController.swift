//
//  LineLoginViewController.swift
//  LoginDemo
//
//  Created by 廖冠翰 on 2022/7/27.
//

import UIKit
import LineSDK

class LineLoginViewController: UIViewController {
    @IBOutlet weak var textView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Create Login Button.
        let loginButton = LoginButton()
        loginButton.delegate = self
        
        // Configuration for permissions and presenting.
        loginButton.permissions = [.profile]
        loginButton.presentingViewController = self
        
        // Add button to view and layout it.
        view.addSubview(loginButton)
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        loginButton.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    @IBAction func copyButtonClick(_ sender: Any) {
        UIPasteboard.general.string = textView.text
    }
}

extension LineLoginViewController: LoginButtonDelegate {
    func loginButton(_ button: LoginButton, didSucceedLogin loginResult: LoginResult) {
        print("Login Succeeded. \(loginResult.accessToken.value)")
        textView.text = loginResult.accessToken.value
        UIPasteboard.general.string = loginResult.accessToken.value
    }
    
    func loginButton(_ button: LoginButton, didFailLogin error: LineSDKError) {
        print("Error: \(error)")
    }
    
    func loginButtonDidStartLogin(_ button: LoginButton) {
        print("Login Started.")
    }
}
