//
//  ViewController.swift
//  APISpeedRaceApp
//
//  Created by 宏輝 on 02/12/2019.
//  Copyright © 2019 宏輝. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ViewController: UIViewController {
    
    
    @IBOutlet weak var waitingAPI1: UILabel!
    @IBOutlet weak var waitingAPI2: UILabel!
    @IBOutlet weak var waitingAPI3: UILabel!
    
    @IBOutlet weak var goNextButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        //API通信が完了してからボタンを表示
        goNextButton.isHidden = true
    }
    
    
    //API通信を開始
    @IBAction func startCommunication(_ sender: Any) {
        
        //API通信を順番通りに行う
        //大業態のカテゴリー取得
                DispatchQueue.global().async {
                    
                    DispatchQueue.main.async {
                        
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
                    //同期処理終了
                }
                //非同期処理終了
                
                //カテゴリーでの検索結果を表示
                DispatchQueue.global().async {
                    DispatchQueue.main.async {
                        
                        //let urlBigClassificationString = "https://api.gnavi.co.jp/RestSearchAPI/v3/?keyid=2f4c7acc59914e1efa7bc6eef258308f&hit_per_page=20&freeword=\(keyword)&category_l=\(self.bigCategoryCodeString)"
                        
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
                                
                                
                            case .failure(let error):
                                print(error)
                            }
                        })
                        
                    }
                }
    }
    
    
    //次の画面へ遷移
    @IBAction func goNext(_ sender: Any) {
        performSegue(withIdentifier: "next", sender: nil)
    }
    
    

}

