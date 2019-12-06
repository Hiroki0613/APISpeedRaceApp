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

class CommunicationPattern:ViewController,XMLParserDelegate {
    
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
                         
                     print("大業態への通信成功")
                         
                     case .failure(let error):
                         print(error)
                     }
                 }
    }
    
    
    //ぐるなびAPIのレストラン一覧を取得
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
                
//                self.waitingAPI1.text = "通信完了1"
//                self.waitingAPI1.backgroundColor = .systemYellow
               print("通信完了1")
                
                
            case .failure(let error):
                print(error)
            }
        })

    }
    
    
    // MARK: - フォト蔵API
      
    //フォト蔵のAPI取得のためのXMLParser
    var parser = XMLParser()
    //RSSのパース中の現在の要素名
    var currentElementName:String!
    //パース解析が終了したことを示すコード
    var parseDoneSign = false

    
    //urlはアラートビューで検索できるように設定
    func parserPrepare(searchWord:String){
        
        print(searchWord)
        
        //urlをstring型で記載
        //現時点では、trainで検索
        let urlString: String = "https://api.photozou.jp/rest/search_public?type=photo&keyword=\(searchWord)"
        //日本語でURLを入力すると文字がおかしくなる問題を解消
        let encodeUrlString: String = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        //url型に変換
        let photozouurl:URL = URL(string: encodeUrlString)!
        
        //xmlパースするものをurlとして指定する
        self.parser = XMLParser(contentsOf: photozouurl)!
        
        //parserのdelegeteをselfに
        self.parser.delegate = self
        
        print("hirohiro_parseStart")
        
        //パース(つまり解析)がスタート
        self.parser.parse()
        
    }
    
    //解析_要素の開始時
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        //最初にcurrentElementNameを消去して、パースしたものを受け入れる準備をする
        currentElementName = nil
        
        //"photo"のひとかたまりを配列として初期化する
        //photoLists = [,,,] の一つの配列が用意される。次にitemが来たら同じように配列に２つ目の[,,,]を追加する。この繰り返し。
        if elementName == "photo"{
            
            //            print("hirohiro_parseAgain")
            
//            self.photoDataModel.append(PhotoDataModel())
//
            
        }else{
            //itemの中のtitle,urlなどが[]の中に入ってくる。[title,url,A,B]つまり詳細が入ってくる。
            currentElementName = elementName
        }
        
        //        print("hirohiro")
        //        print(currentElementName)
    }
    
    
    //解析_要素内の値取得
    //didStartElementで読み込んだimage_urlなどの情報をふるい分けする
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        
//        if self.photoDataModel.count > 0{
//
//            let lastItem = self.photoDataModel[self.photoDataModel.count - 1]
//
//            switch self.currentElementName{
//
//            case "image_url":
//
//                lastItem.image_url = string
//
//                //                print("hirohiroLastItem")
//                //                print(lastItem)
//                //                print(PhotozouBoketeApp.PhotoDataModel())
//                print(lastItem.image_url)
//
//                //                print(photoDataModel)
//
//            default:break
//            }
//        }
    }
    
    
    //解析_要素の終了時
    //xml解析が終わった後に、currentElementNameをnilに戻す。
    //上書きすることも可能だが、そのままにしておくとメモリ上よろしくないため。
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        
        self.currentElementName = nil
    }
    
    //解析_終了時
    func parserDidEndDocument(_ parser: XMLParser) {
        parseDoneSign = true
    }
    
    
    
    
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
                

                print("通信完了3")
                
            case .failure(let error):
                print(error)
                
            }
        }
        
    }
    
    
}
