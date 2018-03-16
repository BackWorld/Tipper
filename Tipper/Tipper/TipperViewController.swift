//
//  TipperViewController.swift
//  Tipper
//
//  Created by zhuxuhong on 2017/11/6.
//  Copyright © 2017年 北大方正电子. All rights reserved.
//

import UIKit


public class TipperViewController: UIViewController {
	
// MARK: - IBOutlets
	@IBOutlet weak var messageLabel: UILabel!
	@IBOutlet weak var wrapper: UIView!
	
// MARK: - Properties
	var delay: Int = 1
	
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
	
// MARK: - Override Method
	
// MARK: - Private Method
	
	
// MARK: - Public Method
	public func setupUI() {
		wrapper.backgroundColor = TipperSnackBar.Style.default.backgroundColor
	}
	
	public func animate(isShowing: Bool){
		
	}
	
	public func dismiss(){
		view.removeFromSuperview()
		removeFromParentViewController()
	}
}


extension TipperViewController{
	static func instanceFromXibWithIndex<T: TipperViewController>(_ index: Int = 0) -> T{
		
		guard
			let nibs = Bundle.main.loadNibNamed("\(Tipper.resourcePath)/Tipper", owner: nil, options: nil),
			index < nibs.count, 
			let vc = nibs[index] as? T else{
				fatalError("\(String(describing: T.self)) 加载失败")
		}
		return vc
	}
}
