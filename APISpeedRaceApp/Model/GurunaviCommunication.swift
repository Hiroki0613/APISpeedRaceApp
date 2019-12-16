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


//プロトコルで、API通信時に"通信成功"、ラベルの色を黄色と出来るようにする
protocol successApiLabelChangeDelegate {
    
    //ここのfuncによりラベルのプロパティを変更する
    func changeLabelProperty()
}

//通信を11回した時に、通信を終了させるdelegate
protocol resultDelegate {
    //ここのfuncによりラベルのプロパティを変更する
    func resultString()
}



class GurunaviCommunication//:UIViewController,XMLParserDelegate
{
    
    
    //ぐるなびAPIで格納しているものを持ってくる
    var nameArray = [String]()
    var addressArray = [String]()
    var imageArray = [String]()
    var latitudeArray = [String]()
    var longitudeArray = [String]()
    
    
    
    var delegate:successApiLabelChangeDelegate? = nil
    var resultDelegate:resultDelegate? = nil
    
    
    func changeLabel(){
        print("Labelのプロパティを経行します")
        
        //delegateがnilで無いときに、tableViewをreloadする
        if let dg = self.delegate {
            dg.changeLabelProperty()
        } else {
            print("何もしません")
        }

    }
    
    
    
    // MARK: - ぐるなびAPI
      
    //ぐるなびAPIの大カテゴリーを取得
    func getGurunaviBigCategoryAPI(){
        
        let urlBigClassificationString = "https://api.gnavi.co.jp/master/CategoryLargeSearchAPI/v3/?keyid=2f4c7acc59914e1efa7bc6eef258308f"
                 
                 let encordeUrlString:String = urlBigClassificationString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
                 
                 Alamofire.request(encordeUrlString, method: .get, parameters: nil, encoding: JSONEncoding.default).responseJSON { (response) in
                     
                     
                     
                     //大業態で現れるコードをvar bigCategoryで取得
                     switch response .result {
                     case .success(let happy):
                         let json:JSON = JSON(response.data as Any)
                         
                         self.getGurnaviJapaneseRestaurantsAPI()
                         
                     print("大業態への通信成功")
                         
                     case .failure(let error):
                         print(error)
                     }
                 }
    }
    
    
    //ぐるなびAPIのレストラン一覧を取得
    func getGurnaviJapaneseRestaurantsAPI() -> String{
        
                
        let urlBigClassificationString = "https://api.gnavi.co.jp/RestSearchAPI/v3/?keyid=2f4c7acc59914e1efa7bc6eef258308f&hit_per_page=20&category_l=RSFST01000"
                      
        
        let encordeUrlString:String = urlBigClassificationString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        
        Alamofire.request(encordeUrlString, method: .get, parameters: nil, encoding: JSONEncoding.default).responseJSON(completionHandler: { (secondResponce) in
            
            //print("hirohiro2")
            //print(secondResponce)
            
            switch secondResponce .result {
            case .success(let happy):
                
                                    
                let json:JSON = JSON(secondResponce.data as Any)
                
                //カウントを宣言　11回目の通信で通信を止めるため
                var count = 0
                
                for i in 0...10{
                    
                    count = count + 1
//                    let json:JSON = JSON(secondResponce.data as Any)
                    let shopName = json["rest"][i]["name"].string
                    let shopImage = json["rest"][i]["image_url"]["shop_image1"].string
                    let shopAddress = json["rest"][i]["address"].string
                    let latitude = json["rest"][i]["latitude"].string
                    let longitude = json["rest"][i]["longitude"].string
                    
                    self.nameArray.append(shopName!)
                    self.imageArray.append(shopImage!)
                    self.addressArray.append(shopAddress!)
                    self.latitudeArray.append(latitude!)
                    self.longitudeArray.append(longitude!)
                    
                    print("hirohiro\(count)")
                    
                    //11回目のカウントがきたら、delegateを発動
                    if count == 11{

                        if let dg = self.resultDelegate {
                            print()
                            dg.resultString()
                            } else {
                            print("何もしません")
                        }
                        
                        return
                    }

                    
                }
                
                //ここでプロトコル発動
//                communicationPattern.changeLabel()
                self.changeLabel()
                
//                self.waitingAPI1.text = "通信完了1"
//                self.waitingAPI1.backgroundColor = .systemYellow

               print("通信完了1")
                
                
            case .failure(let error):
                print(error)
            }
        })
        
        return "ぐるなびAPI通信完了です"

    }
 
    
    func resultString()->String{
        return "ぐるなびAPI通信完了"
    }
    
    
    
    
    
   
    
    
    
   
}
