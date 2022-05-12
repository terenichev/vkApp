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
    
    let friendsRequest = FriendsRequests()
    var friendsListFromJSON: [FriendsItem] = []
    
    let groupsRequest = GroupsRequests()
    var groupsListFromJSON: [Group] = []
    
    var vkFriends: [FriendsItem] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        friendsGet()
        groupsGet()
        
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
                
                
                    let friendToRealm = FriendsRequests()
                    friendToRealm.saveFriendsListData(self.friendsListFromJSON)
                    
                
                let groupToRealm = GroupsRequests()
                groupToRealm.saveGroupsListData(self.groupsListFromJSON)
                self.performSegue(withIdentifier: "checkLog", sender: nil)
                
                
                
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
    
}

extension ViewController {
    func friendsGet() {
        var urlForUserIdsComponents = URLComponents()
        urlForUserIdsComponents.scheme = "https"
        urlForUserIdsComponents.host = "api.vk.com"
        urlForUserIdsComponents.path = "/method/friends.get"
        urlForUserIdsComponents.queryItems = [
            URLQueryItem(name: "order", value: "hints"),
            URLQueryItem(name: "fields", value: "photo_50, status"),
            URLQueryItem(name: "access_token", value: "\(Singleton.instance.token!)"),
            URLQueryItem(name: "v", value: "5.131")
        ]

        guard let urlGetIds = urlForUserIdsComponents.url else { return }

        friendsRequest.myFriendsRequest(url: urlGetIds, completion: { [weak self] result in
            switch result {

            case .success(let usersFromJSON):
                self?.friendsListFromJSON = usersFromJSON
            case .failure(let error):
                print("error", error)
            }
        })
    }
    
    func groupsGet() {
        var urlForGroupComponents = URLComponents()
        urlForGroupComponents.scheme = "https"
        urlForGroupComponents.host = "api.vk.com"
        urlForGroupComponents.path = "/method/groups.get"
        urlForGroupComponents.queryItems = [
//            URLQueryItem(name: "order", value: "hints"),
            URLQueryItem(name: "extended", value: "1"),
            URLQueryItem(name: "access_token", value: "\(Singleton.instance.token!)"),
            URLQueryItem(name: "v", value: "5.131")
        ]

        guard let urlGetGroups = urlForGroupComponents.url else { return }
        print(urlGetGroups)

        groupsRequest.myGroupsRequest(url: urlGetGroups, completion: { [weak self] result in
            switch result {

            case .success(let groupsFromJSON):
                self?.groupsListFromJSON = groupsFromJSON
                
            case .failure(let error):
                print("error", error)
            }
        })
    }
}
    


