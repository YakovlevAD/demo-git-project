//
//  StrubEditorViewController.swift
//  Chat
//
//  Created by Alexandr Yakovlev on 14.12.2021.
//

import UIKit

class StrubEditorViewController: UIViewController {
    
    let gradientView = GradientView(from: .topTrailing, to: .bottomLeading, startColor: #colorLiteral(red: 0.8309458494, green: 0.7057176232, blue: 0.9536159635, alpha: 1), endColor: #colorLiteral(red: 0.5460671782, green: 0.7545514107, blue: 0.9380497336, alpha: 1))
    let slider = UISlider()
    let recLabel = UILabel(text:"Rec")
    let recSegmentedControl = UISegmentedControl(first: "Stop", second: "Start")
    
    var sliderRecorder: ValueRecorder<Float>? = nil
    var colorRecorder: ValueRecorder<UIColor>? = nil
    
    var sliderPlayer: ValuePlayer<Float>? = nil
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBlue
        setupConstraints()
        
        sliderRecorder = ValueRecorder{ [weak self] in
            UIScreen.main.brightness = CGFloat(self?.slider.value ?? 0 )
            return self?.slider.value ?? 0
        }
        
        colorRecorder = ValueRecorder {
            return UIColor()
        }
        
        recSegmentedControl.addTarget(
            self,
            action: #selector(onSegValueChanged),
            for: .valueChanged
        )
        
        slider.addTarget(
            self,
            action: #selector(onSlValueChanged),
            for: .valueChanged)
    }
    
    @objc
    func onSlValueChanged() {
        UIScreen.main.brightness = CGFloat(slider.value)
    }
    
    @objc
    func onSegValueChanged() {
        if recSegmentedControl.selectedSegmentIndex == 0 {
            guard let values = sliderRecorder?.stopRecording() else {
                return
            }
            
            sliderPlayer = ValuePlayer(values: values) { [weak self] value in
                UIScreen.main.brightness = CGFloat(value)
            }
            
            sliderPlayer?.play()
        } else {
            sliderRecorder?.startRecording()
        }
    }
}
// MARK: - Setup constraints
extension StrubEditorViewController {
    private func setupConstraints() {
        gradientView.translatesAutoresizingMaskIntoConstraints = false
        slider.translatesAutoresizingMaskIntoConstraints = false
        gradientView.layer.cornerRadius = gradientView.frame.width / 2
        gradientView.backgroundColor = .white
        let recStackView = UIStackView(arrangedSubviews: [recLabel, recSegmentedControl], axis: .vertical, spacing: 12)
        recStackView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(gradientView)
        view.addSubview(slider)
        view.addSubview(recStackView)
        
        NSLayoutConstraint.activate([
            gradientView.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            gradientView.leadingAnchor.constraint(equalTo: view.centerXAnchor, constant: -150),
            gradientView.heightAnchor.constraint(equalToConstant: 7),
            gradientView.widthAnchor.constraint(equalToConstant: 300)
        ])
        
        NSLayoutConstraint.activate([
            slider.topAnchor.constraint(equalTo: view.topAnchor, constant: 300),
            slider.widthAnchor.constraint(equalToConstant: 100),
            slider.centerXAnchor.constraint(equalTo: view.centerXAnchor)
            //slider.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            //slider.heightAnchor.constraint(equalToConstant: 100),
            //slider.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50)
        ])
        
        NSLayoutConstraint.activate([
            recStackView.topAnchor.constraint(equalTo: gradientView.bottomAnchor, constant: 20),
            recStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            recStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }
}
// MARK: - SwiftUI
import SwiftUI

struct StrubEditorVCProvider: PreviewProvider {
    static var previews: some View {
        ContainerView().edgesIgnoringSafeArea(.all)
    }

    struct ContainerView: UIViewControllerRepresentable {


        let tabBarVC = MainTabBarController()

        func makeUIViewController(context: UIViewControllerRepresentableContext<StrubEditorVCProvider.ContainerView>) ->  MainTabBarController {
            return tabBarVC
        }

        func updateUIViewController(_ uiViewController: StrubEditorVCProvider.ContainerView.UIViewControllerType, context: UIViewControllerRepresentableContext<StrubEditorVCProvider.ContainerView>) {

        }
    }
}
