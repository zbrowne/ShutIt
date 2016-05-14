//
//  ViewController.swift
//  Shut It
//
//  Created by Zachary Browne on 5/14/16.
//  Copyright © 2016 zbrowne. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    @IBOutlet weak var pushBotton: PushButtonView!
    var audioPlayer: AVAudioPlayer?
    
    // Add sounds to this array and make sure that the names of the sounds match the names in the "Audio" file
    // TODO: make this array reflect names in audiofile instead of requiring hardcoding
    var sounds = ["testing01","testing02","testing03"]
    
    // TODO: Make animation work when app reopens
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.animateButton()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func animateButton() {
        let scaleAnimation = CABasicAnimation(keyPath: "transform.scale")
        
        scaleAnimation.duration = 0.5
        scaleAnimation.repeatCount = .infinity
        scaleAnimation.autoreverses = true
        scaleAnimation.fromValue = 1.1;
        scaleAnimation.toValue = 0.9;
        
        pushBotton.layer.addAnimation(scaleAnimation, forKey: "scale")
    }
    
    // tap gesture handler
    @IBAction func handleTap(recognizer: UITapGestureRecognizer) {
        NSLog("Tap Registered")
        self.playAudio()
    }
    
    // TODO: handle null case for audioPlayer effectively
    func playAudio() {
        
        let randomSoundFile = Int(arc4random_uniform(UInt32(sounds.count)))
        if let url: NSURL = NSBundle.mainBundle().URLForResource(sounds[randomSoundFile], withExtension: "m4a") {
        
        do
        {
            audioPlayer = try AVAudioPlayer(contentsOfURL: url, fileTypeHint: nil)
            NSLog("Playing " + sounds[randomSoundFile])
        }
        catch let error as NSError { NSLog(error.description) }
        
        audioPlayer!.numberOfLoops = 0
        audioPlayer!.prepareToPlay()
        audioPlayer!.play()
        }
    }
}

