//
//  ViewController.swift
//  Choizi
//
//  Created by Abdul Diallo on 9/15/20.
//  Copyright © 2020 Abdul Diallo. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func presentAlert(of type : AlertType) {
        let alert = UIAlertController.init(title: "Alert",
                                           message: "\(type.description) is not yet activated",
                                           preferredStyle: .alert)
        let action = UIAlertAction.init(title: "Ok", style: .default) { action in
            alert.dismiss(animated: true, completion: nil)
        }
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
    
}

//MARK: - enum of alert

enum AlertType {
    
    case Boost
    case Superlike
    var description : String {
        switch self {
        case .Boost:
            return "Boosting"
        case .Superlike:
            return "Superliking"
        }
    }
}
