//
//  Alerts.swift
//  guii
//
//  Created by Consultant on 7/11/22.
//
import UIKit
import Foundation

final class Alerts{
    
    static func sendAlert(view : UIViewController, title: String, message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
        view.present(alert, animated: true, completion: nil)
    }
    
}
