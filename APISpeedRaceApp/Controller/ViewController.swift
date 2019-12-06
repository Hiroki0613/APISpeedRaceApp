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

class ViewController:CommunicationPattern {
    
    var communicationPattern = CommunicationPattern()
    
    
    @IBOutlet weak var waitingAPI1: UILabel!
    @IBOutlet weak var waitingAPI2: UILabel!
    @IBOutlet weak var waitingAPI3: UILabel!
    
    @IBOutlet weak var goNextButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        //API通信が完了してからボタンを表示
        goNextButton.isHidden = true
        
        //ラベルのコーナーを丸くする
        waitingAPI1.layer.cornerRadius = 20
        waitingAPI1.layer.masksToBounds = true
        waitingAPI2.layer.cornerRadius = 20
        waitingAPI2.layer.masksToBounds = true
        waitingAPI3.layer.cornerRadius = 20
        waitingAPI3.layer.masksToBounds = true
        
    }
    
    
    //API通信を開始
    @IBAction func startCommunication(_ sender: Any) {
        
        //API通信を順番通りに行う
        //大業態のカテゴリー取得
                DispatchQueue.global().async {
                    
                    DispatchQueue.main.async {
         
                        self.communicationPattern.getGurunaviBigCategoryAPI()
                    }
                    //同期処理終了
                }
                //非同期処理終了
                
                //カテゴリーでの検索結果を表示
                DispatchQueue.global().async {
                    DispatchQueue.main.async {
                      
                        self.communicationPattern.getGurnaviJapaneseRestaurantsAPI()
                        
                        //これだとエラーが出ても通信完了と出てしまう。
                        self.waitingAPI1.text = "通信完了1"
                        self.waitingAPI1.backgroundColor = .systemYellow
                    }
                    
                    //ここに２つ目のAPIを中に入れる
                    
                    DispatchQueue.global().async{
                        DispatchQueue.main.async{
                            
                            self.communicationPattern.getMyJson()
                            self.waitingAPI3.text = "通信完了3"
                            self.waitingAPI3.backgroundColor = .systemYellow
                            
                        }
                    }
                    
                }
    }
    
    
    //次の画面へ遷移
    @IBAction func goNext(_ sender: Any) {
        performSegue(withIdentifier: "next", sender: nil)
    }
    
    

}

