//
//  HapplinessViewController.swift
//  Happiness
//
//  Created by Yu Liu on 25/09/2015.
//  Copyright © 2015 Yu Liu. All rights reserved.
//

import UIKit

class HapplinessViewController: UIViewController {

    var happiness: Int = 50 {//0~100
        didSet{
            happiness = min(max(happiness,0),100)
            print("happiness: \(happiness)")
            updateUI();
        }
    }

    func updateUI()
    {
        
    }
}
