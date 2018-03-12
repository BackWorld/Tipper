//
//  TipperHUD.swift
//  Tipper
//
//  Created by zhuxuhong on 2017/11/6.
//Copyright © 2017年 北大方正电子. All rights reserved.
//

import UIKit

public extension TipperHUD{
	enum Style: Int {
		case loading = 0, success = 1, warning = 2, failure = 3
		
		var icon: UIImage?{
			switch self {
			case .success:
				return UIImage.tipperIcon(named: "icon_tipper_success")
			case .warning:
				return UIImage.tipperIcon(named: "icon_tipper_warning")
			case .failure:
				return UIImage.tipperIcon(named: "icon_tipper_failure")
			case .loading: return nil
			}
		}
	}
}

public final class TipperHUD: TipperViewController {
	
// MARK: - IBOutlets
    @IBOutlet weak var iconImageView: UIImageView!
	@IBOutlet weak var indicatorView: UIActivityIndicatorView!


// MARK: - Properties
	fileprivate var style: Style = .loading{
		didSet{
			iconImageView.isHidden = style == .loading
			iconImageView.image = style.icon
			indicatorView.isHidden = !iconImageView.isHidden
		}
	}
	

// MARK: - Initial Method
	
// MARK: - Lifecycle Method
    
// MARK: - Action & IBOutletAction

// MARK: - Override Method
	override public func setupUI() {
		super.setupUI()
		
		wrapper.layer.cornerRadius = 10
		wrapper.alpha = 0
	}

	override public func animate(isShowing: Bool) {
		UIView.animate(withDuration: 0.25, delay: 0, options: [.curveEaseInOut], animations: { 
			self.wrapper.alpha = isShowing ? 1 : 0
		}) { _ in
			if !isShowing {
				self.dismiss()
			}
			else if isShowing && self.style != .loading {
				let time = DispatchTime.now() + DispatchTimeInterval.seconds(self.delay)
				DispatchQueue.main.asyncAfter(deadline: time) {
					self.animate(isShowing: false)
				}
			}
		}
	}
// MARK: - Private Method
	
// MARK: - Public Method
	static func make(with style: Style, delay: Int, message: String) -> TipperHUD{
		
		let vc: TipperHUD = TipperViewController.instanceFromXibWithIndex(1)
		
		vc.modalPresentationStyle = .overCurrentContext
		vc.style = style
		vc.delay = delay
		vc.messageLabel.text = message
		
		return vc
	}
	
	static func removeAll() {
		let viewControllers = Tipper.topViewControllerOfApplicationKeyWindow()?.childViewControllers
		viewControllers?.forEach{
			vc in
			if vc is TipperHUD{
				vc.view.removeFromSuperview()
				vc.removeFromParentViewController()
			}
		}
	}
}
