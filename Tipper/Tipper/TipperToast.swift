//
//  TipperToast.swift
//  Tipper
//
//  Created by zhuxuhong on 2017/11/6.
//Copyright © 2017年 北大方正电子. All rights reserved.
//

import UIKit

internal final class TipperToast: TipperViewController {

// MARK: - IBOutlets

// MARK: - Properties

// MARK: - Initial Method

// MARK: - Lifecycle Method
	override func viewDidLayoutSubviews() {
		super.viewDidLayoutSubviews()
		
		wrapper.layer.cornerRadius = wrapper.bounds.height / 2
	}
	
// MARK: - Action & IBOutletAction

// MARK: - Override Method
	override func setupUI() {
		super.setupUI()
		
		messageLabel.alpha = 0
		wrapper.alpha = 0
	}
	
	override func animate(isShowing: Bool) {
		UIView.animate(withDuration: 0.25, delay: 0, options: [.curveEaseInOut], animations: { 
			self.wrapper.alpha = isShowing ? 1 : 0
			self.messageLabel.alpha = isShowing ? 1 : 0
		}) { _ in
			if !isShowing {
				self.dismiss()
			}
			else {
				let time = DispatchTime.now() + DispatchTimeInterval.seconds(self.delay)
				DispatchQueue.main.asyncAfter(deadline: time) {
					self.animate(isShowing: false)
				}
			}
		}
	}
	
// MARK: - Private Method
	
// MARK: - Public Method
	internal static func make(with message: String, delay: Int) -> TipperToast{
		let vc: TipperToast = TipperViewController.instanceFromXibWithIndex(2)
		
		vc.modalPresentationStyle = .overCurrentContext
		vc.delay = delay
		vc.messageLabel.text = message.trimmingCharacters(in: .whitespaces).isEmpty ? "无提示信息" : message
		
		return vc
	}
	
	public static func removeAll() {
        let viewControllers = Tipper.topViewControllerOfApplicationKeyWindow()?.children
		viewControllers?.forEach{
			vc in
			if vc is TipperToast{
				vc.view.removeFromSuperview()
                vc.removeFromParent()
			}
		}
	}
}
