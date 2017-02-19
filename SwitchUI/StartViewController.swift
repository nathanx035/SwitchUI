//
//  StartViewController.swift
//  SwitchUI
//
//  Created by Kurt Jacobs on 2017/02/19.
//  Copyright © 2017 RandomDudes. All rights reserved.
//

import UIKit
import AVFoundation

class StartViewController: UIViewController {

  @IBOutlet weak var heightConstraint: NSLayoutConstraint!
  var player:AVPlayer! = nil
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
  
  func animate(){
    
    if (player == nil){
      player = AVPlayer(url: URL(fileURLWithPath: Bundle.main.path(forResource: "nin_sound", ofType: "mp3")!))
      player.play()
    }
    else{
      player.play()
    }
    
    UIView.animate(withDuration: 0.55, delay: 0.3, usingSpringWithDamping: 0.55, initialSpringVelocity: 0.5, options: .curveLinear, animations: {
      self.view.layoutIfNeeded()
      self.heightConstraint.constant = -40
      self.view.layoutIfNeeded()
    }, completion: nil)
    
  }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
