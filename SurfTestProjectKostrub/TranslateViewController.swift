//
//  TranslateViewController.swift
//  SurfTestProjectKostrub
//
//  Created by Artemy Cheprakov on 09/05/2019.
//  Copyright © 2019 vsu. All rights reserved.
//

import UIKit
import Alamofire

class TranslateViewController: UIViewController {
    var strLabel:String = ""
    var strField:String = ""
    var isTranslate: Bool = false
    
    @IBOutlet weak var TextField: UITextField!
    @IBOutlet weak var TextLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first as? UITouch{
            view.endEditing(true)
        }
        super.touchesBegan(touches, with: event)
    }

    @IBAction func TranslateButton(_ sender: Any) {
        if (TextField.text == ""){
            TextLabel.text = "Текста то нету :("
            isTranslate = false
        }
        else{
            if CheckInternet.Connection(){
                isTranslate = true
                strField = TextField.text!
                loadInformation(summary: TextField.text!)
                print("Connected successful")
            }
                
            else{
                self.TextLabel.text = "Ошибка, нет доступа в интернет"
            }
        }
    }
    
    @IBAction func SaveButton(_ sender: Any) {
        if isTranslate {
            addItem(str: strField, translateStr: TextLabel.text!)
            saveData()
            isTranslate = false
        }
    }
    
    func loadInformation(summary:String){
        let YANDEX_DOMAIN: String = "https://translate.yandex.net/api/v1.5/tr.json/translate?"
        let YANDEX_KEY: String = "key="
        let KEY: String = "trnsl.1.1.20190502T210359Z.598f8ad93e4559d5.e9610cce9f7b9bc1bc37fa07ca34cb333ca03284"
        let YANDEX_TEXT: String = "&text="
        let YANDEX_LANG: String = "&lang="
        let LANG: String = "en-ru"
        //"ru-en"
        //"en-ru"
        var fixSummary: String = ""
        for char in summary {
            if char == " "{
                fixSummary+="%20"
            }
            else{
                fixSummary+=String(char)
            }
        }
        //print(fixSummary)
        //print(YANDEX_DOMAIN+YANDEX_KEY+KEY+YANDEX_TEXT+fixSummary+YANDEX_LANG+LANG)
        let url = URL(string: YANDEX_DOMAIN+YANDEX_KEY+KEY+YANDEX_TEXT+fixSummary+YANDEX_LANG+LANG)!
        let session = URLSession.shared
        let task = session.dataTask(with: url) { (data, response, error) in
            guard let content = data else {
                print("No content :(")
                return
            }
            do {
                let decoder = JSONDecoder()
                let TranslateText = try decoder.decode(TaskTranslate.self, from: content)
                self.strLabel = TranslateText.text![0]
            } catch let err {
                print("Err", err)
            }
            DispatchQueue.main.async {
                self.TextLabel.text = self.strLabel
            }
            }.resume()
    }

    
}
