//
//  ViewController.swift
//  EggTimer
//
//  Created by Kittisak Panluea on 21/6/2565 BE.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    //    ต่อไปเราจะทำให้มันขึ้นว่า Done เวลาที่เวลามันหมดแล้ว เริ่มแรกก็คือสร้างตัว outlet ของข้อความขึ้นมาก่อน ต่อบรรทัด 49
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!
    
    let eggTimes = ["Soft": 3 , "Medium" : 4 , "Hard" : 7]
    
    var totalTime = 0
    var secondsPassed = 0
    
    var player = AVAudioPlayer()
    
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
        
//        ตั้งให้ตัว progressbar กลับไปเป็น 0 ก่อนเวลากดปุ่มไข่
        progressBar.progress = 0
        
        titleLabel.text = sender.currentTitle!
        
        guard let hardness = sender.currentTitle else { return print("Error Title is nil !!") }
        
        totalTime = eggTimes[hardness]!
        
        
        //        ย้ายคำสั่งนับเวลาถอยหลังมาเก็บไว้ในตัวแปร
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
        
    }
    
    
    @objc func updateTimer() {
        if secondsPassed < totalTime {
            secondsPassed += 1
//            แสดงหลอด progress bar แหละ
            progressBar.progress = Float(secondsPassed) / Float(totalTime)
            
        }
        //      ทีนี้เราก็จะมาเพิ่ม else เข้าไปเมื่อเวลามันหมดแล้วจะให้ทำไงต่อ
        else {
            //            อันดับแรกก็คือสั่งให้มันหยุดเวลาก่อน
            timer.invalidate()
            //            จากนั้นก็สั่งให้มันเปลี่ยนข้อความเป็นคำว่า Done เย่ะ !!!!
            titleLabel.text = "Done"
            
            let path = Bundle.main.path(forResource: "alarm_sound", ofType: "mp3")!
            let url = URL(fileURLWithPath: path);
            
            do {
                player = try AVAudioPlayer(contentsOf: url)
                player.play()
            } catch let error {
                print(error.localizedDescription)
            }
        }
    }
}

