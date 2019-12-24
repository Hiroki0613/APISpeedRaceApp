//
//  MyEditJson.swift
//  APISpeedRaceApp
//
//  Created by 宏輝 on 16/12/2019.
//  Copyright © 2019 宏輝. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

//ここにプロトコルを入れて、通信が終了した後に、reloadされるようにする

class MyEditJsonCommunication{
    
    // MARK: - 自身で作成したJSONを取得
       
       func getMyJson(){
           
           let url = "http://jesuslovesjerusa.lolipop.jp/spreadSheetJSON4.json"
           
           //Alamofireを使ってhttpsリクエスト
           Alamofire.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default).responseJSON { (response) in
               
               //responceをswith文で分岐する
               switch response.result{
               case .success:
                   
                   //swiftyJSONを使って、JSON解析
                   for i in 0...19{
                       let json:JSON = JSON(response .data as Any)
                       let ID_String = json[i]["number"].string
                       let Name_String = json[i]["name"].string
                   }
                   

                   print("MyEditJSON通信完了3")
                   
               case .failure(let error):
                   print(error)
                   
               }
           }
           
       }
       
       
    
}
