//
//  ViewController.swift
//  AppExntesions
//
//  Created by Mani on 24/01/25.
//

import UIKit
import ActivityKit

class ViewController: UIViewController {

    
    private lazy var horizontalStackView: UIStackView = {
        var stackView = UIStackView(arrangedSubviews: [startButton, endButton])
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 30
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    private lazy var startButton: UIButton = {
        var action = UIAction(title: "Start", handler: { [weak self] _ in
            if let self {
                self.startLiveActivity()
            }
        })
        var button = UIButton(primaryAction: action)
        button.backgroundColor = .red
        button.tintColor = .white
        return button
    }()
    
    private lazy var endButton: UIButton = {
        var action = UIAction(title: "End", handler: { [weak self] _ in
            if let self {
                self.startLiveActivity()
            }
        })
        var button = UIButton(primaryAction: action)
        button.tintColor = .white
        button.backgroundColor = .red
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(horizontalStackView)
        addConstraints()
    }

    
    func addConstraints() {
        
        NSLayoutConstraint.activate([
            horizontalStackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            horizontalStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            horizontalStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            horizontalStackView.heightAnchor.constraint(equalToConstant: 50)
            
        ])
    }

    func startLiveActivity() {
        do{
            if #available(iOS 16.1, *) {
                let liveActivityAttributes = AppWidgetAttributes(name: "start")
                let liveActivityContentState = AppWidgetAttributes.ContentState(emoji: "test")
                if #available(iOS 16.2, *) {
                    
                    let liveActivity = try Activity<AppWidgetAttributes>.request(attributes: liveActivityAttributes, content: ActivityContent(state: liveActivityContentState, staleDate: nil))
                } else {
                    // Fallback on earlier versions
                }
                
            }else{
                print("Dynamic Island and live activies not supported")
            }
        } catch (let error) {
            print("there is some error", error)
        }
        
    }
    
    
}

