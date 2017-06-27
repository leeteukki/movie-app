//
//  TheaterListController.swift
//  MovieApp
//
//  Created by Lena Lee on 2017. 6. 27..
//  Copyright © 2017년 Lena Lee. All rights reserved.
//

import UIKit

class TheaterListController: UITableViewController {
    
    var list = [NSDictionary]()
    
    var startPoint = 0
    
    override func viewDidLoad() {
        
        self.callTheaterAPI()
        
    }
    
    func callTheaterAPI() {
     
        let requestURI = "http://swiftapi.rubypaper.co.kr:2029/theater/list"
        let sList = "json"
        
        let urlObj = URL(string: "\(requestURI)?s_page=\(self.startPoint)&s_list=\(sList)&type=\(type)")
        
        do{
            let stringdata = try NSString(contentsOf: urlObj!, encoding: 0x80_000_422)
            
            let encdata = stringdata.data(using: String.Encoding.utf8.rawValue)
            
            
            
        }
        
    }
    
    
}
