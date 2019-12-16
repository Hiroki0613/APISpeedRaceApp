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

class ViewController:UIViewController,successApiLabelChangeDelegate,resultDelegate {
    
   
    
    //CommunicationPatternのぐるなびAPIで取得した配列をViewControllerに持ってくる
    var nameArrayViewController = [String]()
    var addressArrayViewController = [String]()
    var imageArrayViewController = [String]()
    var latitudeArrayViewController = [String]()
    var longitudeArrayViewController = [String]()
    
    
    
    var communicationPattern = CommunicationPattern()
    
    
    //DispatchSemaphoreを使い、コードが順に制御されるようにする
    let semaphore = DispatchSemaphore(value: 0)
    /*
     参考資料
     DispatchSemaphoreで非同期処理の完了を待つ
     https://scior.hatenablog.com/entry/2019/09/11/231626
     */
    
    
    
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
        
        
        communicationPattern.delegate = self
        communicationPattern.resultDelegate = self
    }
    
    func resultString() {
        waitingAPI1.text = "ぐるなびAPI通信完了２"
              waitingAPI1.backgroundColor = .systemYellow
              
              
              nameArrayViewController = communicationPattern.nameArray
              addressArrayViewController = communicationPattern.imageArray
              imageArrayViewController = communicationPattern.imageArray
              latitudeArrayViewController = communicationPattern.latitudeArray
              longitudeArrayViewController = communicationPattern.longitudeArray
              
              
//              print("hirohiro")
              print(nameArrayViewController)
              
    }
    
    
    
    //プロトコルが発動する時に動くメソッド
    //ここでをラベルのプロパティを変更する。
    func changeLabelProperty() {
        waitingAPI1.text = "通信完了"
        waitingAPI1.text = communicationPattern.resultString()
        waitingAPI1.backgroundColor = .systemYellow


        nameArrayViewController = communicationPattern.nameArray
        addressArrayViewController = communicationPattern.imageArray
        imageArrayViewController = communicationPattern.imageArray
        latitudeArrayViewController = communicationPattern.latitudeArray
        longitudeArrayViewController = communicationPattern.longitudeArray


        print("hirohiro")
        print(nameArrayViewController)

       }
    
    
    //API通信を開始
    @IBAction func startCommunication(_ sender: Any) {
   
        self.communicationPattern.getGurunaviBigCategoryAPI()
        
        //ここでプロトコル発動（発動場所を変更）
//        communicationPattern.changeLabel()
        
        /*
        //API通信を順番通りに行う
                DispatchQueue.global().async {
                    
                    DispatchQueue.main.async {
         
                        doSomething(completion:{
                            self.communicationPattern.getGurunaviBigCategoryAPI()
                            semaphore.signal()
                        })
                        self.semaphore.wait()
                        
                        doSomething(completion:{
                            self.communicationPattern.getGurnaviJapaneseRestaurantsAPI()
                            
                            //これだとエラーが出ても通信完了と出てしまう。
                            self.waitingAPI1.text = "通信完了1"
                            self.waitingAPI1.backgroundColor = .systemYellow
                            semaphore.signal()
                        })
                        self.semaphore.wait()
                        
                        doSomething(completion:{
                            self.communicationPattern.getMyJson()
                            self.waitingAPI3.text = "通信完了3"
                            self.waitingAPI3.backgroundColor = .systemYellow
                            semaphore.signal()
                        })
                        self.semaphore.wait()
                        
                        
                        
                        
                    }
                    //同期処理終了
                }
                //非同期処理終了
                
        
        
        
        
                //カテゴリーでの検索結果を表示
//                DispatchQueue.global().async {
//                    DispatchQueue.main.async {
//
//                        self.communicationPattern.getGurnaviJapaneseRestaurantsAPI()
//
//                        //これだとエラーが出ても通信完了と出てしまう。
//                        self.waitingAPI1.text = "通信完了1"
//                        self.waitingAPI1.backgroundColor = .systemYellow
//                    }
//
//                    //ここに２つ目のAPIを中に入れる
//
//                    DispatchQueue.global().async{
//                        DispatchQueue.main.async{
//
//                            self.communicationPattern.getMyJson()
//                            self.waitingAPI3.text = "通信完了3"
//                            self.waitingAPI3.backgroundColor = .systemYellow
//
//                        }
//                    }
//
//                }
 
         */
    }
    
    
    //次の画面へ遷移
    @IBAction func goNext(_ sender: Any) {
        performSegue(withIdentifier: "next", sender: nil)
    }
    

}

