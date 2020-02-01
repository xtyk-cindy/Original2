//
//  SpeechViewController.swift
//  Original2
//
//  Created by 張丹 on 2020/01/18.
//  Copyright © 2020 張丹. All rights reserved.
//

import UIKit
import RealmSwift
import AVFoundation

class SpeechViewController: UIViewController, UIScrollViewDelegate {
    
    var speechSynthesizer : AVSpeechSynthesizer!
    
    var mochimonoList: [String] = []
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let realm = try! Realm()

        // Realmに保存されてるDog型のオブジェクトを全て取得
        let toDo = realm.objects(TodoModel.self)
        
        print(toDo[0].mochimonoteiji)
        
        var toDoCount = toDo.count
        
        mochimonoList.append(toDo[0].mochimonoteiji!)
        mochimonoList.append(toDo[1].mochimonoteiji!)
        mochimonoList.append(toDo[2].mochimonoteiji!)
        mochimonoList.append(toDo[3].mochimonoteiji!)
        
        let str:String = mochimonoList.joined()


        print(mochimonoList)
        
        self.speechSynthesizer = AVSpeechSynthesizer()
          
        let utterance = AVSpeechUtterance(string: str)
        let utterance2 = AVSpeechUtterance(string: "こんにちは")

        utterance.voice = AVSpeechSynthesisVoice(language: "jp-JP")
        utterance.rate = 0.5;
        utterance.pitchMultiplier = 0.5;
        utterance.preUtteranceDelay = 0.2;
        self.speechSynthesizer.speak(utterance)
        self.speechSynthesizer.speak(utterance2)
        
        

  
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
