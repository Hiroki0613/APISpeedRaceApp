//
//  PhotozouCommunication1.swift
//  APISpeedRaceApp
//
//  Created by 宏輝 on 21/12/2019.
//  Copyright © 2019 宏輝. All rights reserved.
//

import UIKit

class PhotozouCommunicationController: UIViewController,XMLParserDelegate {

   
    
       
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
           
//           if self.photoDataModel.count > 0{
//
//               let lastItem = self.photoDataModel[self.photoDataModel.count - 1]
//
//               switch self.currentElementName{
//
//               case "image_url":
//
//                   lastItem.image_url = string
//
//                   //                print("hirohiroLastItem")
//                   //                print(lastItem)
//                   //                print(PhotozouBoketeApp.PhotoDataModel())
//                   print(lastItem.image_url)
//
//                   //                print(photoDataModel)
//
//               default:break
//               }
//           }
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
    
        
        
}
