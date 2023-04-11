//
//  ViewController.swift
//  ITunes
//
//  Created by Alex Serhiiev on 08.04.2023.
//

import UIKit

class LogInViewController: UIViewController {
    
    enum LoginStatus {
        case signIn
        case signUp
    }
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var nameTextField: UITextField!
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var changeButton: UIButton!
    
    var loginStatus: LoginStatus = .signIn
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    @IBAction func submitPressed(_ sender: Any) {
        switch loginStatus {
        case .signIn:
            signIn()
        case .signUp:
            signUp()
        }
    }
    
    func signUp() {
        guard let name = nameTextField.text, name != "",
              let login = emailTextField.text, login != "",
              let password = passwordTextField.text, password != ""
        else { congigureAlert(title: "Error", message: "All fields must be filled")
               return
             }
        
        if UserService.shared.objectExist(login: login) {
            congigureAlert(title: "Error", message: "User is exist already")
        } else {
            UserService.shared.saveUser(data: .init(name: name,
                                                    login: login,
                                                    password: password))
            congigureAlert(title: "Success", message: "User created")
            changeStatusPressed(changeButton)
        }
    }
    
    func signIn() {
        guard let login = emailTextField.text,
              let password = passwordTextField.text
        else { return }
    
        if let user = UserService.shared.getUser(login: login), user.password == password {
            UserService.shared.saveCurentUser(login: user.login)
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let newViewController = storyBoard.instantiateViewController(withIdentifier: "mainVC")
            self.view.window?.rootViewController = newViewController
            self.view.window?.makeKeyAndVisible()
        } else {
            congigureAlert(title: "Error", message: "User is not found")
        }
    }
    

    @IBAction func changeStatusPressed(_ sender: UIButton) {
        switch loginStatus {
        case .signIn :
            loginStatus = .signUp
            sender.setTitle(Constants.singUpButtonDescription, for: .normal)
            titleLabel.text = Constants.signUpTitle
            nameTextField.isHidden = false
        case .signUp :
            loginStatus = .signIn
            sender.setTitle(Constants.singInButtonDescription, for: .normal)
            titleLabel.text = Constants.signInTitle
            nameTextField.isHidden = true
        }
        nameTextField.text = ""
        emailTextField.text = ""
        passwordTextField.text = ""
    }
    
    func congigureAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
}

struct Constants {
    static let singInButtonDescription: String = "If you dont have an account, sign up"
    static let singUpButtonDescription: String = "If you already have an account, sign in"
    static let signInTitle: String = "Sign In"
    static let signUpTitle: String = "Sign Up"


}
