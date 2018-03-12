//
//  TipperToastDemoVC.swift
//  Tipper
//
//  Created by zhuxuhong on 2018/3/9.
//  Copyright © 2018年 GuessMe. All rights reserved.
//

import UIKit
import Tipper

class TipperToastDemoVC: UIViewController {

// MARK: - IBOutlets
	@IBOutlet weak var delaySegmentedControl: UISegmentedControl!


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
	@IBAction func delayChanged(_ sender: UISegmentedControl) {
		let item = sender.titleForSegment(at: sender.selectedSegmentIndex)?.components(separatedBy: "s").first
		let seconds = Int(item!)!
		Tipper.toast(message: "This is a TipperToast with long text but less than three lines, it will disappear automatically after \(seconds)s.", delay: seconds)
	}
	
	@IBAction func dismiss(_ sender: Any) {
		Tipper.removeAll()
	}

// MARK: - Override Method

// MARK: - Private Method

// MARK: - Public Method

}
