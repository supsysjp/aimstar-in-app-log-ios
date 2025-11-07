//
//  ViewController.swift
//  AimstarInAppLog
//

import UIKit
import AimstarInAppLogSDK

class ViewController: UIViewController {

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

        // ログイン状態を変更します
        AimstarInAppLog.shared.updateLoginState(customerId: "user_001")
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
        // 擬似的にページビューイベントを発生させます
        AimstarInAppLog.shared.trackPageView(
            pageUrl: "https://page/pageview",
            pageTitle: self.title,
            referrerUrl: "https://page/home",
            customParams: [
                "is_logged_in": .bool(true),
                "membership_level": .string("gold")
            ]
        )
    }
}
