//
//  ViewController.swift
//  EasyBrowser
//
//  Created by Shuvaethy Neill on 2022-12-6.
//

import UIKit
import WebKit

class ViewController: UIViewController, WKNavigationDelegate{
    
    var webView: WKWebView!
    var progressView: UIProgressView!
    
    // keep track of allowed domains
    var websites = ["apple.com", "hackingwithswift.com", "google.com"]
    
    // method to load page in WebKit framework
    override func loadView() {
        webView = WKWebView()
        webView.navigationDelegate = self
        view = webView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
            
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Open", style: .plain, target: self, action: #selector(openTapped))
        
        let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let refresh = UIBarButtonItem(barButtonSystemItem: .refresh, target: webView, action: #selector(webView.reload))
        let back = UIBarButtonItem(title: "<", style: .plain, target: webView, action: #selector(webView.goBack))
        let forward = UIBarButtonItem(title: ">", style: .plain, target: webView, action: #selector(webView.goForward))
        
        progressView = UIProgressView(progressViewStyle: .default)
        progressView.sizeToFit()
        
        // wrap progressView in BarButtonItem
        let progressButton = UIBarButtonItem(customView: progressView)
        
        toolbarItems = [back, forward, progressButton, spacer, refresh]
        
        // show toolbar
        navigationController?.isToolbarHidden = false
        
        // key-value observing (KVO) - watch the estimatedProgress property
        webView.addObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress), options: .new, context: nil)
        
        // convert string url to URLRequest for WKWebView to load
        let url = URL(string: "https://" + websites[0])!
        webView.load(URLRequest(url: url))
        // allow swiping back and forward
        webView.allowsBackForwardNavigationGestures = true
    }
    
    @objc func openTapped() {
        let alertController = UIAlertController(title: "Open page...", message: nil, preferredStyle: .actionSheet)
        
        // each addAction call allows an extra button on the action sheet
        for site in websites {
            alertController.addAction(UIAlertAction(title: site, style: .default, handler: openPage))
        }
        
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        alertController.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(alertController, animated: true)
    }

    // method to set URL and load the webView
    func openPage(action: UIAlertAction) {
        guard let actionTitle = action.title else { return }
        guard let url = URL(string: "https://" + actionTitle) else { return }
        webView.load(URLRequest(url: url))
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        // set title of view controller to webView's title when page loading has finished
        title = webView.title
    }
    
    // must implement if you have registered an observer using KVO
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if(keyPath == "estimatedProgress") {
            //eestimatedProgress is a float so we must cast to Float to match progress property type
            progressView.progress = Float(webView.estimatedProgress)
        }
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        let url = navigationAction.request.url
        
        //unwrap - not all urls have hosts
        if let host = url?.host {
            for site in websites {
                if host.contains(site) {
                    // allow loading if website was found
                    decisionHandler(.allow)
                    return
                }
            }
        }
        
        let urlString = url?.absoluteString ?? "Unknown"

        // filter out "about:blank" to avoid unnecessary alerts
        if urlString != "about:blank" {
            let ac = UIAlertController(title: "Blocked!", message: "Website \"\(urlString)\" is not part of authorized websites.", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(ac, animated: true)
        }
        
        decisionHandler(.cancel)
    }

}

