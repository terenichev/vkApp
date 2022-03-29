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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tapGR = UITapGestureRecognizer(target: self, action: #selector(hideScreen))
        view.addGestureRecognizer(tapGR)
        
        
        UIView.animate(withDuration: 2,
                       delay: 0,
                       options: [.repeat],
                       animations: {
            self.firstCircle.alpha = 0.1
        })
        
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
        if loginTextField.text == "" && passwordTextField.text == "" {
            performSegue(withIdentifier: "checkLog", sender: self)
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
    }
    
}
    


