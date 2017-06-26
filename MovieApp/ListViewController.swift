//
//  ListViewController.swift
//  MovieApp
//
//  Created by Lena Lee on 2017. 6. 18..
//  Copyright © 2017년 Lena Lee. All rights reserved.
//

import UIKit


class ListViewController: UITableViewController {
    
    
    var page = 1
    
    lazy var list : [MovieVO] = {
        
        var datalist = [MovieVO]()
        

        
        return datalist
    }()
    
    @IBOutlet weak var moreBtn: UIButton!
    @IBAction func more(_ sender: AnyObject) {
        
        self.page += 1
        
        self.callMovieAPI()
        
        self.tableView.reloadData()
    
    }

    override func viewDidLoad( ) {
        
      
        self.callMovieAPI( )
    }
    
       func callMovieAPI() {
        
        
        let url = "http://115.68.183.178:2029/hoppin/movies?version=1&page=\(self.page)&count=10&genreId=&order=releasedateasc"
        let apiURI : URL! = URL(string: url)
        let apidata = try! Data(contentsOf: apiURI)
        
        let log = NSString(data: apidata, encoding: String.Encoding.utf8.rawValue) ?? "데이터가 없습니다"
        NSLog("API Result=\( log )")
        
   
        do {
            let apiDictionary = try JSONSerialization.jsonObject(with: apidata, options: []) as! NSDictionary
            
           
            let hoppin = apiDictionary["hoppin"] as! NSDictionary
            let movies = hoppin["movies"] as! NSDictionary
            let movie = movies["movie"] as! NSArray
            
           
            for row in movie {
                
                let r = row as! NSDictionary
               
                let mvo = MovieVO( )
                
                mvo.title       = r["title"] as? String
                mvo.description = r["genreNames"] as? String
                mvo.thumbnail   = r["thumbnailImage"] as? String
                mvo.detail      = r["linkUrl"] as? String
                mvo.rating      = ((r["ratingAverage"] as! NSString).doubleValue)
                
                
                self.list.append(mvo)
            }
            
            let totalCount = (hoppin["totalCount"] as? NSString)!.integerValue
            
            
            if (self.list.count >= totalCount) {
                self.moreBtn.isHidden = true
            }
            
        } catch {
            NSLog("Parse Error!!")
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.list.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = self.list[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListCell") as! MovieCell
        
        cell.title?.text = row.title
        cell.desc?.text = row.description
        cell.opendate?.text = row.openrate
        cell.rating?.text = "\(row.rating!)"
      
        let url: URL! = URL(string: row.thumbnail!)
       
        let imageData = try! Data(contentsOf: url)
       
        cell.thumbnail.image = UIImage(data:imageData)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        NSLog("선택된 행은 \(indexPath.row) 번째 행입니다")
    }
}
