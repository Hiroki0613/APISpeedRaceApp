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
                        
         
                    }
                    //同期処理終了
                }
                //非同期処理終了
                
                //カテゴリーでの検索結果を表示
                DispatchQueue.global().async {
                    DispatchQueue.main.async {
                                                
                    }
                }
    }
    
    
    //次の画面へ遷移
    @IBAction func goNext(_ sender: Any) {
        performSegue(withIdentifier: "next", sender: nil)
    }
    
    

}

