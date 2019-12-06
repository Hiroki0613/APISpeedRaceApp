//
//  CommunicationPattern.swift
//  APISpeedRaceApp
//
//  Created by 宏輝 on 06/12/2019.
//  Copyright © 2019 宏輝. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class CommunicationPattern {
    
    
    
    func getGurunaviBigCategoryAPI(){
        
        let urlBigClassificationString = "https://api.gnavi.co.jp/master/CategoryLargeSearchAPI/v3/?keyid=2f4c7acc59914e1efa7bc6eef258308f"
                 
                 let encordeUrlString:String = urlBigClassificationString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
                 
                 Alamofire.request(encordeUrlString, method: .get, parameters: nil, encoding: JSONEncoding.default).responseJSON { (response) in
                     
                     
                     
                     //大業態で現れるコードをvar bigCategoryで取得
                     switch response .result {
                     case .success(let happy):
                         let json:JSON = JSON(response.data as Any)
                         
                     print("大業態への通信成功")
                         
                     case .failure(let error):
                         print(error)
                     }
                 }
    }
    
    
    
    func getGurnaviJapaneseRestaurantsAPI(){
                
        let urlBigClassificationString = "https://api.gnavi.co.jp/RestSearchAPI/v3/?keyid=2f4c7acc59914e1efa7bc6eef258308f&hit_per_page=20&category_l=RSFST01000"
                      
        
        let encordeUrlString:String = urlBigClassificationString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        
        Alamofire.request(encordeUrlString, method: .get, parameters: nil, encoding: JSONEncoding.default).responseJSON(completionHandler: { (secondResponce) in
            
            //print("hirohiro2")
            //print(secondResponce)
            
            switch secondResponce .result {
            case .success(let happy):
                
                for i in 0...10{
                    let json:JSON = JSON(secondResponce.data as Any)
                    let shopName = json["rest"][i]["name"].string
                    let shopImage = json["rest"][i]["image_url"]["shop_image1"].string
                    let shopAddress = json["rest"][i]["address"].string
                    let latitude = json["rest"][i]["latitude"].string
                    let longitude = json["rest"][i]["longitude"].string
                    
                    
                }
                
                self.waitingAPI1.text = "通信完了1"
                self.waitingAPI1.backgroundColor = .systemYellow
                
                
            case .failure(let error):
                print(error)
            }
        })

    }
    
}
