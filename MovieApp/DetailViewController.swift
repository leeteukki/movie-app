//
//  DetailViewController.swift
//  MovieApp
//
//  Created by Lena Lee on 2017. 6. 26..
//  Copyright © 2017년 Lena Lee. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var wv: UIWebView!
    
    var mvo : MovieVO!
    
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        NSLog("linkurl = \(self.mvo?.detail), title= \(self.mvo?.title)")
        
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
}
