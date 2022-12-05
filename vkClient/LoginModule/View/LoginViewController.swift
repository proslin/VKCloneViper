//
//  LoginViewController.swift
//  vkClient
//
//  Created by Lina Prosvetova on 22.11.2022.
//

import UIKit
import WebKit

class LoginViewController: UIViewController {
    var output: LoginViewControllerIOutput?
    
    private lazy var webView: WKWebView = {
        let webView = WKWebView()
        webView.navigationDelegate = self
        webView.translatesAutoresizingMaskIntoConstraints = false
        return webView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        layoutViews()
        output?.viewIsReady()

    }
    
    private func layoutViews() {
        view.addSubview(webView)
        
        NSLayoutConstraint.activate([
            webView.topAnchor.constraint(equalTo: view.topAnchor),
            webView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            webView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            webView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

}

extension LoginViewController: LoginViewControllerInput {
    func loadURLRequest(_ request: URLRequest?) {
        guard let request = request else { return }
        webView.load(request)
    }
}

// MARK: WKNavigationDelegate
extension LoginViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse:
                 WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        guard let url = navigationResponse.response.url, url.path == "/blank.html", let fragment = url.fragment else {
            decisionHandler(.allow)
            return
        }
        let params = fragment
            .components(separatedBy: "&")
            .map { $0.components(separatedBy: "=") } .reduce([String: String]()) { result, param in
                var dict = result
                let key = param[0]
                let value = param[1]
                dict[key] = value
                return dict
            }
        let token = params["access_token"]
        guard token != nil else { return }
        Session.shared.token = token ?? " "
        output?.authPageLoaded(vc: self)
        decisionHandler(.cancel)        
    }
    
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        self.presentAlertVC(title: "Ошибка", message: error.localizedDescription)
    }
}



