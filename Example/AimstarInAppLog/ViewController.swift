//
//  ViewController.swift
//  AimstarInAppLog
//

import UIKit

class ViewController: UIViewController {

    private lazy var button = {
        let button = UIButton(type: .system)
        button.setTitle("Send page view event", for: .normal)
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        
        // Additional setup after loading the view.
        // login
        // AimstarInAppLog.shared.updateLoginState(customerId: "test_user_001")
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
    }
}

