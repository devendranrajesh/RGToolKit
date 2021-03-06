//
//  UIView+Extension.swift
//  RGToolKit
//
//  Created by Ritesh Gupta on 26/11/16.
//  Copyright © 2016 Ritesh Gupta. All rights reserved.
//

import Foundation
import UIKit

extension UIView: Nibable {
	
	public var nib: UINib {
		return UINib(nibName: typeName, bundle: nil)
	}
	public static var nib: UINib {
		return UINib(nibName: typeName, bundle: nil)
	}
	public static func loadFromNib<T: UIView>() -> T? {
		return Bundle.main.loadNibNamed(typeName, owner: self, options: nil)?.first as? T
	}
}

public extension UIView {
	
	public func sizeToFit(widthPadding: CGFloat = 0, heightPadding: CGFloat = 0) {
		sizeToFit()
		append(width: widthPadding)
		append(height: heightPadding)
	}
	
	public func append(width: CGFloat) {
		var frame = self.frame
		frame.size.width += width
		self.frame = frame
	}
	
	public func append(height: CGFloat) {
		var frame = self.frame
		frame.size.height += height
		self.frame = frame
	}
	
	public func removeSubview(_ condition: ((UIView) -> Bool)) {
		subviews.filter { condition($0) }.first?.removeFromSuperview()
	}
	
	public func add(
		contraints: [Constraint] = [.Top(0, nil), .Bottom(0, nil), .Left(0, nil), .Right(0, nil)],
		subview: UIView,
		viewsDict: [String: UIView],
		completionHandler: Constraint.Handler? = nil
		)
	{
		let subviewName = viewsDict.filter { $0.1 == subview }.first?.0
		guard let name = subviewName else { return }
		
		let constraintMapper: (Constraint) -> (Constraint, NSLayoutConstraint) = {
			let format = $0.visualFormat(viewName: name)
			let constraint = NSLayoutConstraint.constraints(
				withVisualFormat: format,
				options: $0.options,
				metrics: nil,
				views: viewsDict
			)
			self.addConstraints(constraint)
			return ($0, constraint.first!)
		}

		addSubview(subview)
		subview.translatesAutoresizingMaskIntoConstraints = false
		let constraintTupples = contraints.map { constraintMapper($0) }
		completionHandler?(constraintTupples)
	}
}
