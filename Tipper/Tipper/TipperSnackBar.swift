//
//  TipperSnackBar.swift
//  Tipper
//
//  Created by zhuxuhong on 2017/11/6.
//Copyright © 2017年 北大方正电子. All rights reserved.
//

import UIKit

public extension TipperSnackBar{
	enum Position: Int {
		case top = 0, bottom = 1
	}
	
	enum Style: Int {
		case `default`, success, warning, failure
		
		var backgroundColor: UIColor{
			switch self {
			case .success:
				return .green
			case .warning:
				return .orange
			case .failure:
				return .red
			case .default: 
				return UIColor(white: 0.3, alpha: 1)
			}
		}
		
		var icon: UIImage?{
			switch self {
			case .success:
				return Tipper.icon("icon_tipper_success")
			case .warning:
				return Tipper.icon("icon_tipper_warning")
			case .failure:
				return Tipper.icon("icon_tipper_failure")
			case .default: return nil
			}
		}
	}
	
	struct Action {
		public typealias Handler = (() -> Void)
		public var handler: Handler!
		public var title: String?
		public var image: UIImage?
		
		public init(title: String, handler: @escaping Handler) {
			self.title = title
			self.handler = handler
		}
		
		public init(image: UIImage, handler: @escaping Handler) {
			self.image = image
			self.handler = handler
		}
	}
}


public final class TipperTouchFilterView: UIView {
	
	var needsUserInteractionEnableSubviews: [UIView] = []
	
	override public func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
		
		for subview in subviews {			
			return userInteractionEnabledSubview(forView: subview, hitTestPoint: point)
		}
		
		return isUserInteractionEnabled ? self : nil
	}
	
	fileprivate func userInteractionEnabledSubview(forView view: UIView, hitTestPoint point: CGPoint) -> UIView?{
		for subview in view.subviews {
			let rect = view.convert(subview.frame, to: self)
			
			if rect.contains(point) && needsUserInteractionEnableSubviews.contains(subview) {
				return subview
			}
		}
		return nil
	}
}

public final class TipperSnackBar: TipperViewController {	

// MARK: - IBOutlets
    @IBOutlet weak var iconImageView: UIImageView!
	@IBOutlet weak var iconImageViewLeadingCons: NSLayoutConstraint!
	@IBOutlet weak var iconImageViewWidthCons: NSLayoutConstraint!
	
	@IBOutlet weak var actionButton: UIButton!
	@IBOutlet weak var actionButtonTrailingCons: NSLayoutConstraint!
	
	@IBOutlet weak var wrapperTopCons: NSLayoutConstraint!

// MARK: - Properties
	fileprivate var style: Style = .default{
		didSet{
			if style.icon == nil {
				iconImageViewLeadingCons.constant = 0
				iconImageViewWidthCons.constant = 0
			}
			else{
				iconImageView.image = style.icon
			}
			wrapper.backgroundColor = style.backgroundColor
		}
	}
	
	fileprivate var position: Position = .bottom{
		didSet{
			wrapperTopCons.constant = hidingOffsetY
		}
	}
	
	fileprivate var action: Action?{
		didSet{
			if let action = action {
				actionButton.setTitle(action.title, for: .normal)
				actionButton.setImage(action.image, for: .normal)
			}
			else {
				actionButtonTrailingCons.constant = 0
				actionButton.isHidden = true
			}
		}
	}
	
	fileprivate var showingOffsetY: CGFloat{
		let statusBarHeight = UIApplication.shared.statusBarFrame.height
		guard position == .top else {
			return view.bounds.height - wrapper.bounds.height - UIDevice.current.homeIndicatorHeight
		}
		
		var topOffset = statusBarHeight
		if let navBar = parent?.navigationController?.navigationBar {
			topOffset = (navBar.isTranslucent || navBar.isHidden) 
				? navBar.bounds.height + statusBarHeight 
				: 0
		}
		return topOffset
	}
	
	fileprivate var hidingOffsetY: CGFloat{
		return position == .top 
			? -wrapper.bounds.height 
			: view.bounds.height
	}

// MARK: - Initial Method
    
	
// MARK: - Lifecycle Method
    override public func viewDidLoad() {
        super.viewDidLoad()
		
		setupUI()
    }
	
	override public func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		
		animate(isShowing: true)
	}
    
// MARK: - Action & IBOutletAction
	@IBAction func actionButtonClicked(_ sender: UIButton) {
		action?.handler?()
		animate(isShowing: false)
	}

// MARK: - Override Method
	override public func setupUI() {
		super.setupUI()
		
		(view as? TipperTouchFilterView)?.needsUserInteractionEnableSubviews = [actionButton]
	}

// MARK: - Private Method
	override public func animate(isShowing: Bool) {
		wrapperTopCons.constant = isShowing ? showingOffsetY : hidingOffsetY
		
		UIView.animate(withDuration: 0.15, delay: 0, options: [.curveEaseInOut], animations: { 
			self.view.layoutIfNeeded()
		}) { _ in
			if !isShowing {
				self.dismiss()
			}
			else if isShowing && self.action == nil{
				let time = DispatchTime.now() + DispatchTimeInterval.seconds(self.delay)
				DispatchQueue.main.asyncAfter(deadline: time) {
					self.animate(isShowing: false)
				}
			}
		}
	}

// MARK: - Public Method
	static func make(with position: Position, style: Style, delay: Int, message: String, action: Action?) -> TipperSnackBar{
		let vc: TipperSnackBar = TipperViewController.instanceFromXibWithIndex()
		vc.modalPresentationStyle = .overCurrentContext
		
		vc.position = position
		vc.style = style
		vc.delay = delay
		vc.action = action
		vc.messageLabel.text = message
		
		return vc
	}
	
	public static func removeAll() {
		let viewControllers = Tipper.topViewControllerOfApplicationKeyWindow()?.childViewControllers
		viewControllers?.forEach{
			vc in
			if vc is TipperSnackBar{
				vc.view.removeFromSuperview()
				vc.removeFromParentViewController()
			}
		}
	}

}
