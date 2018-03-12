//
//  TipperBubble.swift
//  SHMath
//
//  Created by zhuxuhong on 2017/12/6.
//  Copyright © 2017年 北大方正电子. All rights reserved.
//

import UIKit

public final class TipperBubble: TipperViewController {

// MARK: - IBOutlets
	@IBOutlet weak var bottomCons: NSLayoutConstraint!

// MARK: - Properties
	fileprivate var sender: UIView!

// MARK: - Initial Method
    
// MARK: - Lifecycle Method
    
// MARK: - Action & IBOutletAction

// MARK: - Override Method
	override public func setupUI() {
		wrapper.backgroundColor = .orange
	}
	
	override public func animate(isShowing: Bool) {
		let rect = arrow.frame
		view.addSubview(arrow)
		bottomCons.constant = view.bounds.height - rect.origin.y + 20
	}
	

// MARK: - Private Method
	fileprivate var arrow: UIView{
		let layer = CAShapeLayer()
		let path = UIBezierPath()
		// 计算点
		let rect = sender.convert(sender.bounds, to: view)
		
		let midX = rect.origin.x + rect.width / 2
		
		let off: CGFloat = 10
		let w: CGFloat = 20
		let h: CGFloat = 20 
		let x = midX - w / 2
		let y = rect.maxY - rect.height - h - off
		
		path.move(to: .zero)
		path.addLine(to: CGPoint(x: w / 2, y: h))
		path.addLine(to: CGPoint(x: w, y: 0))
		path.close()
		path.fill()
		
		layer.fillColor = wrapper.backgroundColor?.cgColor
		layer.path = path.cgPath
		
		let v = UIView(frame: CGRect(x: x, y: y, width: w, height: h))
		layer.frame = v.bounds
		v.layer.addSublayer(layer)
		
		return v
	}
	

// MARK: - Public Method
	static func make(from sender: UIView, message: String) -> TipperBubble{
		let vc: TipperBubble = TipperViewController.instanceFromXibWithIndex(3)
		vc.modalPresentationStyle = .overCurrentContext
		
		vc.messageLabel.text = message
		vc.sender = sender
		
		return vc
	}

	static func removeAll() {
		let viewControllers = Tipper.topViewControllerOfApplicationKeyWindow()?.childViewControllers
		viewControllers?.forEach{
			vc in
			if vc is TipperBubble{
				vc.view.removeFromSuperview()
				vc.removeFromParentViewController()
			}
		}
	}
}
