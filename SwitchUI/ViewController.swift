//
//  ViewController.swift
//  SwitchUI
//
//  Created by Kurt Jacobs on 2017/02/19.
//  Copyright © 2017 RandomDudes. All rights reserved.
//

import UIKit

struct NINConstants{
  static let itemSmallScreen = 100
  static let itemLargeScreen = 160
  static let cvHeightSmall = 120 as CGFloat
  static let cvHeightLarge = 180 as CGFloat
}

class ViewController: UIViewController,UICollectionViewDelegate, UICollectionViewDataSource {
  
  @IBOutlet weak var collectionView: UICollectionView!
  @IBOutlet weak var timeLabel: UILabel!
  
  var timer:Timer! = nil
  var splash:StartViewController! = nil
  
  @IBOutlet weak var collectionViewHeight: NSLayoutConstraint!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    splash = (self.storyboard?.instantiateViewController(withIdentifier: "SplashScreenSw"))! as! StartViewController
    self.addChildViewController(splash)
    self.view.addSubview(splash.view)
    let a = NSLayoutConstraint(item: splash.view, attribute: .centerX, relatedBy: .equal, toItem: self.view, attribute: .centerX, multiplier: 1, constant: 0)
    let b = NSLayoutConstraint(item: splash.view, attribute: .centerY, relatedBy: .equal, toItem: self.view, attribute: .centerY, multiplier: 1, constant: 0)
    let c = NSLayoutConstraint(item: splash.view, attribute: .width, relatedBy: .equal, toItem: self.view, attribute: .width, multiplier: 1, constant: 0)
    let d = NSLayoutConstraint(item: splash.view, attribute: .height, relatedBy: .equal, toItem: self.view, attribute: .height, multiplier: 1, constant: 0)
    self.view.addConstraints([a,b,c,d])
    
    self.currentTime()
    
    self.timer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(currentTime), userInfo: nil, repeats: true)
    
    Timer.scheduledTimer(withTimeInterval: 1, repeats: false) {[weak self] (t:Timer) in
      if let ss = self{
        ss.splash.animate()
      }
    }
    
    Timer.scheduledTimer(withTimeInterval: 3, repeats: false) {[weak self] (t:Timer) in
      if let ss = self{
        ss.splash.view.removeFromSuperview()
        ss.splash.removeFromParentViewController()
      }
    }
    
    let scr = UIScreen.main.bounds
    if (scr.height <= 320)
    {
      self.collectionViewHeight.constant = NINConstants.cvHeightSmall
      let layout = self.collectionView.collectionViewLayout as! UICollectionViewFlowLayout
      layout.itemSize = CGSize(width: NINConstants.itemSmallScreen, height: NINConstants.itemSmallScreen)
      self.collectionView.collectionViewLayout = layout
    }
    else{
      self.collectionViewHeight.constant = NINConstants.cvHeightLarge
      let layout = self.collectionView.collectionViewLayout as! UICollectionViewFlowLayout
      layout.itemSize = CGSize(width: NINConstants.itemLargeScreen, height: NINConstants.itemLargeScreen)
      self.collectionView.collectionViewLayout = layout
    }
  }
  
  func currentTime() -> Void{
    let crnt = NSDate()
    let cal = Calendar.current
    let h = cal.component(.hour, from: crnt as Date)
    let m = cal.component(.minute, from: crnt as Date)
    var hs = "\(h)"
    var ms = "\(m)"
    if h < 10{
      hs = "0\(h)"
    }
    if m < 10{
      ms = "0\(m)"
    }
    
    self.timeLabel.text = "\(hs):\(ms)"
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = self.collectionView.dequeueReusableCell(withReuseIdentifier: "game_cell", for: indexPath) as! GameCollectionViewCell
    cell.backgroundColor = UIColor.red
    if (indexPath.row == 0)
    {
      cell.imageView.image = UIImage(named: "botw")
    }
    else if (indexPath.row == 1){cell.imageView.image = UIImage(named: "1-2")}
    else if (indexPath.row == 2){cell.imageView.image = UIImage(named: "arms")}
    else if (indexPath.row == 3){cell.imageView.image = UIImage(named: "mk8")}
    else{cell.imageView.image = UIImage(named: "empty")}
    return cell
  }
  
  func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 1
  }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 7
  }


}

