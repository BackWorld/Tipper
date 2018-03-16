//
//  Tipper.swift
//  Tipper
//
//  Created by zhuxuhong on 2017/11/6.
//  Copyright © 2017年 北大方正电子. All rights reserved.
//

import UIKit

extension UIDevice{
	var hasNotch: Bool{
		return UIApplication.shared.statusBarFrame.height == 44
	}
	
	var homeIndicatorHeight: CGFloat{
		return hasNotch ? 34 : 0
	}
}

public struct Tipper {
	public static func toast(message: String,
	                         delay: Int = 1){
		
		TipperToast.removeAll()
		
		let vc = TipperToast.make(with: message, delay: delay)
		
		present(tipper: vc)
	}
	
	public static func hud(style: TipperHUD.Style, 
	                       delay: Int = 1, 
	                       message: String){
		TipperHUD.removeAll()
		
		let vc = TipperHUD.make(with: style, delay: delay, message: message)
		
		present(tipper: vc)
	}
	
	public static func snackBar(position: TipperSnackBar.Position = .top,
	                            style: TipperSnackBar.Style = .default, 
	                            message: String, 
	                            delay: Int = 2, 
	                            action: TipperSnackBar.Action? = nil){
		TipperSnackBar.removeAll()
		
		let vc = TipperSnackBar.make(with: position, style: style, delay: delay, message: message, action: action)
		
		present(tipper: vc)
	}
	
	public static func bubble(from sender: UIView, message: String){
		TipperBubble.removeAll()
		
		let vc = TipperBubble.make(from: sender, message: message)
		
		present(tipper: vc)
	}
	
	public static func alert(title: String?, 
	                         message: String?, 
	                         style: UIAlertControllerStyle = .alert, 
	                         textFields: [((UITextField) -> Void)?]? = nil, 
	                         actions: [UIAlertAction]? = nil, 
	                         completion: (() -> Void)? = nil)
	{
		let vc = UIAlertController(title: title, message: message, preferredStyle: style)
		
		actions?.forEach{ vc.addAction($0) }
		textFields?.forEach{
			vc.addTextField(configurationHandler: $0)
		}
		
		present(tipper: vc)
	}

	public static func removeAll(){
		let viewControllers = topViewControllerOfApplicationKeyWindow()?.childViewControllers
		viewControllers?.forEach{
			vc in
			if vc is TipperViewController{
				vc.view.removeFromSuperview()
				vc.removeFromParentViewController()
			}
		}
	}
}



extension Tipper{
	static let resourcePath = "Frameworks/Tipper.framework"
	
	static func icon(_ named: String) -> UIImage{
		return UIImage(named: "\(Tipper.resourcePath)/\(named)", in: Bundle.main, compatibleWith: nil) ?? UIImage()
	}
	
	fileprivate static func present(tipper vc: UIViewController){
		UIApplication.shared.keyWindow?.endEditing(true)
		
		let holder = topViewControllerOfApplicationKeyWindow()
		holder?.addChildViewController(vc)
		holder?.view.addSubview(vc.view)
		
		vc.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
		vc.view.frame = holder!.view.bounds
	}
	
	internal static func topViewControllerOfApplicationKeyWindow() -> UIViewController? {
		var vc = topViewController(of: UIApplication.shared.keyWindow?.rootViewController)
		while vc?.presentedViewController != nil {
			vc = topViewController(of: vc?.presentedViewController)
		}
		return topViewController(of: vc)
	}
	
	fileprivate static func topViewController(of parentViewController: UIViewController?) -> UIViewController?{
		if let nav = parentViewController as? UINavigationController {
			return nav.topViewController
		}
		if let tab = parentViewController as? UITabBarController {
			return tab.selectedViewController
		}
		return parentViewController
	}
}
