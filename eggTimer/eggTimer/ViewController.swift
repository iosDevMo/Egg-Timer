//
//  ViewController.swift
//  eggTimer
//
//  Created by mohamdan on 20/02/2023.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!
    var audioPlayer: AVAudioPlayer?
    var timer = Timer()
    
    let hardnessTime = ["Soft":3, "Medium":5, "Hard":7]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    @IBAction func hardnessSelected(_ sender: UIButton) {
        timer.invalidate()
        let hardness = sender.currentTitle!
        label.text = hardness
        let totalTime = Float(hardnessTime[hardness]!)
        var counter:Float = 0.0
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: { time in
            if counter < totalTime {
                counter += 1.0
                self.progressBar.progress = (counter / totalTime)
                
            }else{
                self.label.text = "Done!"
                self.progressBar.progress = 0
                time.invalidate()
                self.playSound()
                self.timer = Timer.scheduledTimer(withTimeInterval: 4.0, repeats: false, block: { lblTime in
                    self.label.text = "How do you like your egg ?"
                })
            }
        })
    }
    
    func playSound(){
        guard let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3") else { return }

        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)

            audioPlayer = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)

            guard let player = audioPlayer else { return }

            player.play()

        } catch let error {
            print(error.localizedDescription)
        }

    }
    
}

