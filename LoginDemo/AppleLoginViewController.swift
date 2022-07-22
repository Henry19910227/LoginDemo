//AppleLoginViewController.swift
//
// Created by Developer on 2022/7/29.
// Copyright © 2022 Developer_Team, Inc. All rights reserved.
//


import UIKit
import AuthenticationServices

class AppleLoginViewController: UIViewController, ASAuthorizationControllerDelegate, ASAuthorizationControllerPresentationContextProviding {
    
    @IBOutlet weak var textView: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        let authorizationButton = ASAuthorizationAppleIDButton()
        authorizationButton.frame = CGRect(x: 0, y: 0, width: 80, height: 35)
        authorizationButton.center = CGPoint(x: UIScreen.main.bounds.size.width * 0.5, y: UIScreen.main.bounds.size.height * 0.5)
        authorizationButton.addTarget(self, action: #selector(handleAuthorizationAppleIDButtonPress), for: .touchUpInside)
        view.addSubview(authorizationButton)
    }
    
    @objc
    func handleAuthorizationAppleIDButtonPress() {
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let request = appleIDProvider.createRequest()
        request.requestedScopes = [.fullName, .email]
        
        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        authorizationController.delegate = self
        authorizationController.presentationContextProvider = self
        authorizationController.performRequests()
    }
    
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return self.view.window!
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        // Handle error.
    }

    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        switch authorization.credential {
        case let appleIDCredential as ASAuthorizationAppleIDCredential:
            let code = String(data: appleIDCredential.authorizationCode ?? Data(), encoding: .utf8)
            textView.text = code
            UIPasteboard.general.string = code
            print(code ?? "")
            print("UserID:\(appleIDCredential.user)")
        default:
            break
        }
    }
    
    @IBAction func copyButtonClick(_ sender: Any) {
        UIPasteboard.general.string = textView.text
    }
    
}
