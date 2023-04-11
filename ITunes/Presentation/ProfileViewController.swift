//
//  ProfileViewController.swift
//  ITunes
//
//  Created by Alex Serhiiev on 08.04.2023.
//

import UIKit

class ProfileViewController: UIViewController {
    
    
    @IBOutlet weak var nameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let login = UserService.shared.getCurentUser() {
            let curentUser = UserService.shared.getUser(login: login)
            nameLabel.text = curentUser?.name
        }
    }
    
    @IBAction func logOutPressed(_ sender: Any) {
        UserService.shared.logOutUser()
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "LogInViewController")
        self.view.window?.rootViewController = newViewController
    }
}
