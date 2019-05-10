//
//  Model.swift
//  SurfTestProjectKostrub
//
//  Created by xcode on 07.05.2019.
//  Copyright © 2019 vsu. All rights reserved.
//

import Foundation

var WordList: [[String:Any]] = [["Str": "Apple","TranslateStr":"Яблоко"]]

func addItem (str: String, translateStr:String){
    WordList.append(["Str": str, "TranslateStr":translateStr])
    saveData()
}

func removeItem(at Index: Int){
    WordList.remove(at: Index)
    saveData()
}

func saveData(){
    UserDefaults.standard.set(WordList, forKey: "WordListKey")
    UserDefaults.standard.synchronize()
}

func loadData(){
    if let array = UserDefaults.standard.array(forKey: "WordListKey") as? [[String:Any]]{
        WordList = array
    }else{
        WordList = []
    }
}



