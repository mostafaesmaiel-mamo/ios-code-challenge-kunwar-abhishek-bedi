//
//  LoaderView.swift
//  ContactsApp
//
//  Created by kbedi on 11/06/2021.
//
import UIKit

class LoaderView: UIActivityIndicatorView {
	override init(style: UIActivityIndicatorView.Style = .large) {
		super.init(style: style)
		self.style = style
		self.translatesAutoresizingMaskIntoConstraints = false
		self.color = .systemBlue
	}
	
	required init(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	func showOn(_ parentView: UIView) {
		parentView.addSubview(self)
		self.centerXAnchor.constraint(equalTo: parentView.centerXAnchor).isActive = true
		self.centerYAnchor.constraint(equalTo: parentView.centerYAnchor).isActive = true
		
		self.startAnimating()
	}
	
	func hide() {
		self.removeFromSuperview()
	}
}
