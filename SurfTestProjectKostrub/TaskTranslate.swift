//
//  TaskTranslate.swift
//  SurfTestProjectKostrub
//
//  Created by xcode on 08.05.2019.
//  Copyright © 2019 vsu. All rights reserved.
//

import Foundation

class TaskTranslate: Decodable{
    let code:Int
    let lang: String?
    var text:[String]?
    
    init() {
        code = 0
        lang = ""
        text = []
    }
    
    init (Task:TaskTranslate){
        self.code = Task.code
        self.lang = Task.lang
        for ks in Task.text!{
            self.text = []
            self.text?.append(ks)
        }
    }
}
