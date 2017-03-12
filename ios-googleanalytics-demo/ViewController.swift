//
//  ViewController.swift
//  ios-googleanalytics-demo
//
//  Created by k_motoyama on 2017/03/13.
//  Copyright © 2017年 k_moto. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var button: UIButton!
    
    var tracker: GAITracker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tracker = GAI.sharedInstance().defaultTracker!
        tracker.set(kGAIScreenName, value: "メインスクリーン")
        tracker.send(GAIDictionaryBuilder.createScreenView().build() as [NSObject: AnyObject])
        tracker.set(kGAIScreenName, value: nil)
        
        button.addTarget(self, action: #selector(ViewController.onClick(sender:)), for: .touchDown)

    }

    internal func onClick(sender: UIButton){
        
        let build = GAIDictionaryBuilder.createEvent(withCategory: "ボタン",action: "ボタン押下",label: "メインボタン",value: 1).build() as [NSObject : AnyObject]
        tracker?.send(build)
        
        
    }


}

