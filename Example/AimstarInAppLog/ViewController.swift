//
//  ViewController.swift
//  AimstarInAppLog
//

import UIKit
import AimstarInAppLogSDK

class ViewController: UIViewController {
    
    private var isLoggedIn:Bool = false
    
    private lazy var button = {
        let button = UIButton(type: .system)
        button.setTitle("Send page view event", for: .normal)
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "HomeScreen"
        setupViews()
        
        // Additional setup after loading the view.
        // login
        AimstarInAppLog.shared.updateLoginState(customerId: "test_user_001")
        isLoggedIn = true
    }
    
    private func setupViews() {
        button.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(button)
        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    @objc private func buttonTapped() {
        // Send page view event logic here
        print("Page view event sent")
        
        AimstarInAppLog.shared.trackPageView(
            pageUrl: "https://page/pageview",
            pageTitle: self.title,
            referrerUrl: "https://page/home",
            customParams: [
                "is_logged_in": .bool(isLoggedIn),
                "membership_level": isLoggedIn ? .string("gold") : .string("guest")
            ]
        )
    }
}

