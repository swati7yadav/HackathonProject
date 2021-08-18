//
//  UIVIewControllerExtension.swift
//  HackathonProject
//
//  Created by Swati Yadav on 19/08/21.
//

import UIKit

var vSpinner: UIView?

extension UIViewController {
    
    // MARK: - Spinner display on controller
    // - Parameters:
    //  - onView: to add spinner
    func showSpinner(onView: UIView) {
        let spinnerView = UIView.init(frame: onView.bounds)
        spinnerView.backgroundColor = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
        
        let activityIndicator = UIActivityIndicatorView.init(style: .whiteLarge)
        activityIndicator.startAnimating()
        activityIndicator.center = spinnerView.center
        
        DispatchQueue.main.async {
            spinnerView.addSubview(activityIndicator)
            onView.addSubview(spinnerView)
        }
        
        vSpinner = spinnerView
    }
    
    func removeSpinner() {
        DispatchQueue.main.async {
            vSpinner?.removeFromSuperview()
            vSpinner = nil
        }
    }
    
    
    // MARK: - Alert display on controller
    // - Parameters:
    //  - title: title for alert
    //   - message: alert message
    //   - actions: array of action (default = OK button without action)
    
    func displayAlert(title: String = AppConstants.appName, message: String, actions: [UIAlertAction]? = nil) {
        guard presentedViewController == nil else { return }
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        //no actions found then add OK button
        if let customActions = actions {
            customActions.forEach { action in
                alertController.addAction(action)
            }
        } else {
            let okButton = UIAlertAction(title: "OK", style: .default)
            alertController.addAction(okButton)
        }
        
        present(alertController, animated: true)
    }
}
