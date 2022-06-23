//
//  AuthViewController.swift
//  vkApp
//
//  Created by Денис Тереничев on 13.04.2022.
//

import UIKit
import WebKit

final class LoginController: UIViewController {
    @IBOutlet weak var webView: WKWebView!
    let defaults = UserDefaults.standard
    
    override func loadView() {
        super.loadView()
        view = webView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        Singleton.instance.id = defaults.object(forKey: "id") as? Int
        Singleton.instance.token = defaults.object(forKey: "token") as? String
        configureWebView()
        loadAuth()
    }
}

// MARK: - WKNavigationDelegate
extension LoginController: WKNavigationDelegate {
    func webView(_ webView: WKWebView,
                 decidePolicyFor navigationResponse: WKNavigationResponse,
                 decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        guard
            let url = navigationResponse.response.url,
            url.path == "/blank.html",
            let fragment = url.fragment

        else {
            decisionHandler(.allow)
            return
        }
        
        let params = fragment
            .components(separatedBy: "&")
            .map { $0.components(separatedBy: "=")}
            .reduce([String: String]()) { result, param in
                var dict = result
                let key = param[0]
                let value = param[1]
                dict[key] = value
                return dict
            }
        if Singleton.instance.token != nil {
            print("old token = ", Singleton.instance.token!)
            decisionHandler(.cancel)
            performSegue(withIdentifier: "ToTabBarScene", sender: nil)
        }else {
            if let token = params["access_token"], let id = params["user_id"] {
                defaults.set(id, forKey: "id")
                defaults.set(token, forKey: "token")
                Singleton.instance.id = defaults.object(forKey: "id") as? Int
                Singleton.instance.token = defaults.object(forKey: "token") as? String
                
                print("new token = ", token)
                decisionHandler(.cancel)
                performSegue(withIdentifier: "ToTabBarScene", sender: nil)
            }
        }
    }
}

// MARK: - Private
private extension LoginController {
    func configureWebView() {
        navigationController?.navigationBar.isHidden = true
        webView.navigationDelegate = self
    }

    func loadAuth() {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "oauth.vk.com"
        urlComponents.path = "/authorize"
        urlComponents.queryItems = [
            URLQueryItem(name: "client_id", value: "8139604"),
            URLQueryItem(name: "display", value: "mobile"),
            URLQueryItem(name: "redirect_uri", value: "https://oauth.vk.com/blank.html"),
            URLQueryItem(name: "scope", value: "offline, friends, photos, groups, wall"),
            URLQueryItem(name: "response_type", value: "token"),
            URLQueryItem(name: "revoke", value: "0")
        ]

        guard let url = urlComponents.url else { return }
        let request = URLRequest(url: url)
        webView.load(request)
    }
}
