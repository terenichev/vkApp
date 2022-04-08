//
//  SingletonViewController.swift
//  vkApp
//
//  Created by Денис Тереничев on 08.04.2022.
//

import UIKit

class SingletonViewController: UIViewController {

    @IBOutlet weak var singletonLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        let session = Session.instance
        singletonLabel.text = "token: \(session.token), id:\(session.userId) "
        
    }
    
    @IBAction func loginFromSingletonScreen(_ sender: Any) {
        self.performSegue(withIdentifier: "toFriendsList", sender: nil)
        
    }
    
   
}
