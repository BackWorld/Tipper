//
//  TipperBubbleDemoVC.swift
//  Tipper
//
//  Created by zhuxuhong on 2018/3/9.
//  Copyright © 2018年 GuessMe. All rights reserved.
//

import UIKit
import Tipper

class TipperBubbleDemoVC: UIViewController {

// MARK: - IBOutlets
//    @IBOutlet weak var btn: UIButton!

// MARK: - Properties

// MARK: - Initial Method
    private func setupUI() {
        
        
    }
    
    private func initData() {
        
    }
    
    
// MARK: - Lifecycle Method
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
		
		initData()
    }
    
// MARK: - Action & IBOutletAction
	@IBAction func show(_ sender: UIButton) {
		Tipper.bubble(from: sender, message: "This is a TipperBubble, it will stand by the top side of a view will not be disappear never, it should be positioned with a bottom bar button.")
	}

// MARK: - Override Method

// MARK: - Private Method

// MARK: - Public Method

}
