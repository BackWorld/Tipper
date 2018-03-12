//
//  TipperHUDDemoVC.swift
//  Tipper
//
//  Created by zhuxuhong on 2018/3/8.
//  Copyright © 2018年 GuessMe. All rights reserved.
//

import UIKit
import Tipper

class TipperHUDDemoVC: UIViewController {

// MARK: - IBOutlets
    @IBOutlet weak var styleSegmentedControl: UISegmentedControl!

// MARK: - Properties
	fileprivate var delay = 1
	
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
	@IBAction func styleChanged(_ sender: UISegmentedControl) {
		let style = TipperHUD.Style(rawValue: sender.selectedSegmentIndex)!
		
		Tipper.hud(style: style, delay: delay, message: "This is a TipperHUD style \(style), it will disappear automatically after \(delay)s.")
	}
	
	@IBAction func delayChanged(_ sender: UISegmentedControl) {
		let item = sender.titleForSegment(at: sender.selectedSegmentIndex)?.components(separatedBy: "s").first
		delay = Int(item!)!
	}
	
	@IBAction func dismiss(_ sender: Any) {
		Tipper.removeAll()
	}

// MARK: - Override Method

// MARK: - Private Method

// MARK: - Public Method

}
