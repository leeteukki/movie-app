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
            
            do{
                
                let apiArray = try JSONSerialization.jsonObject(with: encdata!, options: []) as? NSArray
                
                for obj in apiArray! {
                    self.list.append(obj as! NSDictionary)
                }
                
            } catch {
                
                let alert = UIAlertController(title: "실패", message: "데이터 분석이 실패 했습니다", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "확인", style: "데이터 분석이 성공 했습니다", handler: .cancel))
                self.present(alert, animated: false)
                
            }
            
            self.startPoint += sList
            
        } catch {
            
            let alert = UIAlertController(title: "실패", message: "데이터를 불러오는데 실패 하였습니다", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "확인", style: .cancel))
            self.present(alert, animated: false)
            
        }
    }
}
