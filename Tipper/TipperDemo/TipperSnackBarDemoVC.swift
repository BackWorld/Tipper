//
//  TipperSnackBarDemoVC.swift
//  Tipper
//
//  Created by zhuxuhong on 2018/3/9.
//  Copyright © 2018年 GuessMe. All rights reserved.
//

import UIKit
import Tipper

class TipperSnackBarDemoVC: UIViewController {

// MARK: - IBOutlets
	fileprivate var action: TipperSnackBar.Action? = nil
	
	fileprivate var position: TipperSnackBar.Position = .top
	
	fileprivate var delay = 1

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
	@IBAction func actionEnableToggled(_ sender: UISwitch) {
		if sender.isOn {
			action = TipperSnackBar.Action(title: "Action", handler: {
				let alert = UIAlertController(title: "you clicked the TipperSnackBar action button.", message: nil, preferredStyle: .alert)
				alert.addAction(UIAlertAction(title: "OK", style: .default, handler: {
					_ in
					Tipper.removeAll()
				}))
				UIApplication.shared.keyWindow?.rootViewController?.present(alert, animated: true, completion: nil)
			})
		}
		else{
			action = nil
		}
	}
	
	@IBAction func positionChanged(_ sender: UISegmentedControl) {
		position = TipperSnackBar.Position(rawValue: sender.selectedSegmentIndex)!
	}
	
	@IBAction func styleChanged(_ sender: UISegmentedControl) {
		let style = TipperSnackBar.Style(rawValue: sender.selectedSegmentIndex)!
		
		Tipper.snackBar(position: position, style: style, message: "This is a TipperSnackBar style \(style)", delay: delay, action: action)
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
