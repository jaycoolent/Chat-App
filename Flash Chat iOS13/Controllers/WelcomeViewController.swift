//
//  WelcomeViewController.swift
//  Flash Chat iOS13
//
//  Created by Angela Yu on 21/10/2019.
//  Copyright © 2019 Angela Yu. All rights reserved.
//

import UIKit
import CLTypingLabel

class WelcomeViewController: UIViewController {

    @IBOutlet weak var titleLabel: CLTypingLabel!
    
    // how to hide the nav bar on certain screens. How to unhide the nav bar on other screens.
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.isNavigationBarHidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLabel.text = K.appName
        

//        titleLabel.text = ""
//        var charIndex = 0.0
//        let titleText = "⚡️FlashChat"
//        for text in titleText {
//            print("-")
//            print(0.1 * charIndex)
//            print(text)
//            Timer.scheduledTimer(withTimeInterval: 0.1 * charIndex, repeats: false) { timer in
//                self.titleLabel.text?.append(text)
//            }
//            charIndex += 1
        }
  // Whats happening is, you're looping through this array of fruits. For every item in this array, each of them is going to get printed in the console. Start out by emptying the title label to equal an empty string then we're going to add each letter in the for loop. titleLabel.text.append a character. We use the "Timer" we can use the scheduled timer with TimeInterval for 0.1s, repeats false and only want to run once.
    }
    


