//
//  UIHUD.swift
//  limelog
//
//  Created by Hector Lliguichuzca on 7/1/21.
//

import Foundation
import UIKit



protocol Loadable {
    
    func showLoadingView()
    func hideLoadingView()
}




final class LoadingView: UIView{

    private let activityIndicatorView = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.medium)
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        backgroundColor = UIColor.black.withAlphaComponent(0.7)
        layer.cornerRadius = 5
        
        activityIndicatorView.color = .white
    
        if activityIndicatorView.superview == nil{
            addSubview(activityIndicatorView)
            
            activityIndicatorView.translatesAutoresizingMaskIntoConstraints = false
                       activityIndicatorView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
                       activityIndicatorView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
                       activityIndicatorView.startAnimating()
            
        }
    }
    
    public func animate(){
        activityIndicatorView.startAnimating()
    }
    
 
    
}

//MARK:- HUD LOADING VIEW

extension Loadable where Self: UIViewController{
    
    func showLoadingView() {
        let loadingView = LoadingView()
        view.addSubview(loadingView)
        
        loadingView.translatesAutoresizingMaskIntoConstraints = false
        loadingView.widthAnchor.constraint(equalToConstant: 60).isActive = true
        loadingView.heightAnchor.constraint(equalToConstant: 60).isActive = true
        loadingView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        loadingView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        loadingView.animate()
        
        loadingView.tag = constant.loadingViewTag
    }
    
    func hideLoadingView() {
        view.subviews.forEach { subview in
            if subview.tag == constant.loadingViewTag {
                subview.removeFromSuperview()
            }
        }
    }
}



