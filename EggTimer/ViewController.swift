//
//  ViewController.swift
//  EggTimer
//
//  Created by Kittisak Panluea on 21/6/2565 BE.
//

import UIKit

class ViewController: UIViewController {
    
    //    ต่อไปเราจะทำให้มันขึ้นว่า Done เวลาที่เวลามันหมดแล้ว เริ่มแรกก็คือสร้างตัว outlet ของข้อความขึ้นมาก่อน ต่อบรรทัด 49
    @IBOutlet weak var titleLabel: UILabel!
    
    let eggTimes = ["Soft": 3 , "Medium" : 420 , "Hard" : 720]
    
    var secondsRemaining = 60
    
    //    แก้ปัญหากดปุ่มหลาย ๆ ทีแล้วเวลามันแปลกๆด้วยการสร้างตัวแปรซะเลย
    var timer = Timer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(eggTimes)
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func hardnessSelection(_ sender: UIButton) {
        
        //        สั่งให้มันลบหรือยกเลิกการลูปนับเวลาออกจากกัน
        timer.invalidate()
        
        guard let hardness = sender.currentTitle else { return print("Error Title is nil !!") }
        
        secondsRemaining = eggTimes[hardness]!
        
        //        ย้ายคำสั่งนับเวลาถอยหลังมาเก็บไว้ในตัวแปร
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    
    
    @objc func updateTimer() {
        if secondsRemaining > 0 {
            print("\(secondsRemaining) seconds.")
            secondsRemaining -= 1
            
        }
        //      ทีนี้เราก็จะมาเพิ่ม else เข้าไปเมื่อเวลามันหมดแล้วจะให้ทำไงต่อ
        else {
            //            อันดับแรกก็คือสั่งให้มันหยุดเวลาก่อน
            timer.invalidate()
            //            จากนั้นก็สั่งให้มันเปลี่ยนข้อความเป็นคำว่า Done เย่ะ !!!!
            titleLabel.text = "Done"
        }
    }
}

