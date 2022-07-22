//
//  GoogleLoginViewController.swift
//  LoginDemo
//
//  Created by 廖冠翰 on 2022/7/23.
//

import UIKit
import GoogleSignIn
class GoogleLoginViewController: UIViewController {

    @IBOutlet weak var textView: UITextView!
    let signConfig = GIDConfiguration(clientID:"376527343165-tu7fr7epqgqc1c1mf2gbqppsn056alf8.apps.googleusercontent.com")
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func loginClick(_ sender: Any) {
        GIDSignIn.sharedInstance.signIn(with:signConfig, presenting: self) { [unowned self] user, error in
            guard error == nil else { return }
            guard let user = user else { return }

            user.authentication.do { authentication, error in
                guard error == nil else { return }
                guard let authentication = authentication else { return }
                print(authentication.idToken ?? "")
                self.textView.text = authentication.idToken
                UIPasteboard.general.string = authentication.idToken
            }
        }
    }
    @IBAction func copyButtonClick(_ sender: Any) {
        UIPasteboard.general.string = textView.text
    }
}
