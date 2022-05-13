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

        let session = Singleton.instance
        singletonLabel.text = "token: \(String(describing: session.token)), id:\(String(describing: session.id)) "
    }
    
    @IBAction func loginFromSingletonScreen(_ sender: Any) {
        self.performSegue(withIdentifier: "toFriendsList", sender: nil)
    }
}
