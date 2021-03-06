//
//  ViewController.swift
//  vkApp
//
//  Created by Денис Тереничев on 10.02.2022.
//

import UIKit

class ViewController: UIViewController{
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var logoImageView: UIImageView!
    
    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var goButton: UIButton!
    @IBOutlet weak var forgetPasswordButton: UIButton!
    
    @IBOutlet weak var firstCircle: UIImageView!
    @IBOutlet weak var secondCircle: UIImageView!
    @IBOutlet weak var thirdCircle: UIImageView!
    
<<<<<<< HEAD
    override func viewDidLoad() {
        super.viewDidLoad()
=======
    let request = Request()
    var usersIds:[Int] = []
    var myUsers: User?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var urlForUserIdsComponents = URLComponents()
        urlForUserIdsComponents.scheme = "https"
        urlForUserIdsComponents.host = "api.vk.com"
        urlForUserIdsComponents.path = "/method/friends.get"
        urlForUserIdsComponents.queryItems = [
            URLQueryItem(name: "count", value: "5"),
            URLQueryItem(name: "order", value: "hints"),
//            URLQueryItem(name: "fields", value: "photo_200_orig"),
            URLQueryItem(name: "access_token", value: "\(Singleton.instance.token!)"),
            URLQueryItem(name: "v", value: "5.131")
        ]
>>>>>>> parent of 05ddf24 (hw 3 in process)

        firstCircle.isHidden = true
        secondCircle.isHidden = true
        thirdCircle.isHidden = true
        
        let tapGR = UITapGestureRecognizer(target: self, action: #selector(hideScreen))
        view.addGestureRecognizer(tapGR)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        NotificationCenter.default.addObserver(self, selector: #selector(willShowKeyboard), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(willHideKeyboard), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func willShowKeyboard(_ notification: Notification){
        print(#function)
        
        guard let info = notification.userInfo as NSDictionary?,
              let keyboardSize = info.value(forKey: UIResponder.keyboardFrameEndUserInfoKey) as? NSValue else {return}
        
        let keyboardHeight = keyboardSize.cgRectValue.size.height
        
        scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardHeight, right: 0)
    }
    
    @objc func willHideKeyboard(_ notification: Notification){
        print(#function)
        
        guard let info = notification.userInfo as NSDictionary?,
              let keyboardSize = info.value(forKey: UIResponder.keyboardFrameEndUserInfoKey) as? NSValue else {return}
        
        let keyboardHeight = keyboardSize.cgRectValue.size.height
        
        scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: -keyboardHeight, right: 0)
    }

    
    @objc func hideScreen(){
        view.endEditing(true)
    }
    
    
    @IBAction func tryTologin(_ sender: Any) {
        
<<<<<<< HEAD
=======
        
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "api.vk.com"
        urlComponents.path = "/method/users.get"
        urlComponents.queryItems = [
            URLQueryItem(name: "user_ids", value: "\(usersIds)"),
            URLQueryItem(name: "fields", value: "status , photo_max_orig"),
            URLQueryItem(name: "access_token", value: "\(Singleton.instance.token!)"),
            URLQueryItem(name: "v", value: "5.131")
        ]

        guard let urlGetUsers = urlComponents.url else { return }
        print("urlGetUsers:",urlGetUsers)
        request.usersInfoRequest(url: urlGetUsers) { result in
            switch result {
            case .success(let users):

                self.myUsers = users
                print("myUsers:",self.myUsers)
            case .failure(let error):
                print("error", error)
            }
        }
        
//        print(myUsers)
        

            
>>>>>>> parent of 05ddf24 (hw 3 in process)
        if passwordTextField.text == "" {
            firstCircle.isHidden = false
            secondCircle.isHidden = false
            thirdCircle.isHidden = false
            
            
            UIView.animate(withDuration: 1,
                           delay: 0,
                           options: .curveEaseIn) {
                self.loginTextField.layer.position.x += 500
                self.passwordTextField.layer.position.x -= 500
                self.goButton.layer.position.y += 500
                self.forgetPasswordButton.layer.position.y += 500
                
            } completion: { _ in
                UIView.animate(withDuration: 3,
                               delay: 0,
                               options: .curveEaseOut) {
                    self.logoImageView.layer.position.y += 200
                }
                
                UIView.animate(withDuration: 2,
                               delay: 0,
                               options: [.repeat],
                               animations: {
                    self.firstCircle.alpha = 0.1
                }) { _ in
                    
                }
                
                UIView.animate(withDuration: 2,
                               delay: 0.66,
                               options: [.repeat],
                               animations: {
                    self.secondCircle.alpha = 0.1
                })
                
                UIView.animate(withDuration: 2,
                               delay: 1.33,
                               options: [.repeat],
                               animations: {
                    self.thirdCircle.alpha = 0.1
                })
                
<<<<<<< HEAD
                DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1), execute: {
                            self.performSegue(withIdentifier: "checkLog", sender: nil)
=======
                DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(3), execute: {
                    
                    self.performSegue(withIdentifier: "VKfriend", sender: self)
//                            self.performSegue(withIdentifier: "checkLog", sender: nil)
>>>>>>> parent of 05ddf24 (hw 3 in process)
                    
                })
                
            }
        } else {
            
            let wrongPasswordAlert = UIAlertController(title: "Error", message: "Введите верный логин и пароль", preferredStyle: .alert)
            let alertOk = UIAlertAction(title: "Ok", style: .default, handler: {_ in
                self.loginTextField.text = ""
                self.passwordTextField.text = ""
            })
            wrongPasswordAlert.addAction(alertOk)
            
            present(wrongPasswordAlert, animated: true, completion: nil)
            
        }
        
        }
    
    @IBAction func logOutActionExit(unwindSegue: UIStoryboardSegue){
        print("exit")
        self.loadView()
    }
<<<<<<< HEAD
=======
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "VKfriend",
           let destinationVC = segue.destination as? FriendsViewController {

            print("ALOOOOOO")
            destinationVC.users = myUsers
            
        }
    }
    
>>>>>>> parent of 05ddf24 (hw 3 in process)
}


    


