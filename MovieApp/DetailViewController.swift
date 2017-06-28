//
//  DetailViewController.swift
//  MovieApp
//
//  Created by Lena Lee on 2017. 6. 26..
//  Copyright © 2017년 Lena Lee. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, UIWebViewDelegate {
    
    @IBOutlet weak var wv: UIWebView!
    
    var mvo : MovieVO!
    
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        
        NSLog("linkurl = \(String(describing: self.mvo?.detail)), title= \(String(describing: self.mvo?.title))")
        
        let navibar = self.navigationItem
        navibar.title = self.mvo?.title
        
        if let url = self.mvo?.detail{
            if let urlObj = URL(string: url) {
                let req = URLRequest(url: urlObj)
                self.wv.loadRequest(req)
                
            } else {
                let  alert = UIAlertController(title: "오류", message: "잘못된 url입니다", preferredStyle: .alert)
                
                let cancelAction = UIAlertAction(title: "확인", style: .cancel) {
                    (_)in
                    
                    _ = self.navigationController?.popViewController(animated: true)
                }
                
                alert.addAction(cancelAction)
                self.present(alert, animated: false, completion: nil)
                
            }
        }
    }
    func webView(_ webView: UIWebView, didFailLoadWithError error: Error) {
        
        self.spinner.stopAnimating()
        
        let alert = UIAlertController(title: "오류", message: "상세페이지를 읽어노는데 실패하였습니다", preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "확인", style: .cancel) {
         (_)in
            _ = self.navigationController?.popViewController(animated: true)
        }
        
        alert.addAction(cancelAction)
        self.present(alert, animated: false, completion: nil)
        
    }
    
    func webViewDidStartLoad(_ webView: UIWebView) {
        self.spinner.startAnimating()
    }
    func webViewDidFinishLoad(_ webView: UIWebView) {
        self.spinner.stopAnimating()
    }
}


