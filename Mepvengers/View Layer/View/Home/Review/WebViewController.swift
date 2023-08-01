import UIKit
import WebKit

class WebViewController: UIViewController, WKNavigationDelegate, WKUIDelegate {

    var webViewUrl = ""
     var backButton = MButton(name: "Back", titleText: "< 뒤로가기")
     private lazy var webViewKit: WKWebView = {
         let webView = WKWebView(frame: .zero)
         webView.allowsBackForwardNavigationGestures = true
         return webView
     }()
     
     private lazy var backButtonContainerView: UIView = {
         let containerView = UIView()
         containerView.backgroundColor = .white
         containerView.addSubview(backButton)
         return containerView
     }()

     override func viewDidLoad() {
         super.viewDidLoad()
         
         view.addSubview(webViewKit)
         view.addSubview(backButtonContainerView)
         webViewKit.navigationDelegate = self
         webViewKit.uiDelegate = self
     
         if let url = URL(string: webViewUrl) {
             let request = URLRequest(url: url)
             webViewKit.load(request)
         }
         
         navigationController?.hidesBarsOnSwipe = false
         navigationController?.isNavigationBarHidden = true
         setupLayout()
         NavigationLayout()
         
         backButton.addTarget(self, action: #selector(goBack), for: .touchUpInside)
     }


    func setupLayout() {
        backButtonContainerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            backButtonContainerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            backButtonContainerView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            backButtonContainerView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            backButtonContainerView.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        backButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            backButton.topAnchor.constraint(equalTo: backButtonContainerView.topAnchor),
            backButton.leadingAnchor.constraint(equalTo: backButtonContainerView.leadingAnchor),
            backButton.widthAnchor.constraint(equalToConstant: 110)

        ])
        
        webViewKit.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            webViewKit.topAnchor.constraint(equalTo: backButtonContainerView.bottomAnchor),
            webViewKit.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            webViewKit.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            webViewKit.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
        ])
    }

    func NavigationLayout(){

        
        let backItem = UIBarButtonItem()
        backItem.title = "뒤로 가기"
        backItem.tintColor = .black
        self.navigationItem.backBarButtonItem = backItem
    }
    
    @objc func goBack() {
        if webViewKit.canGoBack {
            webViewKit.goBack()
        } else {
            navigationController?.isNavigationBarHidden = false
            navigationController?.popViewController(animated: true)
        }
    }
}
