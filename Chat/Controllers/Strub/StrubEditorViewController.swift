//
//  StrubEditorViewController.swift
//  Chat
//
//  Created by Alexandr Yakovlev on 14.12.2021.
//

import UIKit

class StrubEditorViewController: UIViewController {
    
    let trackView = UIView()
    let slider = UISlider()
//    let recLabel = UILabel(text:"Rec")
    let recSegmentedControl = UISegmentedControl(first: "Stop Rec", second: "Start Rec")
    
    var sliderRecorder: ValueRecorder<Float>? = nil
    var colorRecorder: ValueRecorder<UIColor>? = nil
    
    var sliderPlayer: ValuePlayer<Float>? = nil
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.09766673297, green: 0.09766673297, blue: 0.09766673297, alpha: 1)
        setupConstraints()
        
//        recLabel.textColor = .white
        trackView.applyGradients(cornerRadius: 20)
        
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
        var nav = self.navigationController?.navigationBar
        nav?.barStyle = UIBarStyle.black
        nav?.tintColor = .white
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
            MainService.shared.saveToJSON()
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
        trackView.translatesAutoresizingMaskIntoConstraints = false
        slider.translatesAutoresizingMaskIntoConstraints = false
        recSegmentedControl.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(slider)
        view.addSubview(recSegmentedControl)
        view.addSubview(trackView)
        
        NSLayoutConstraint.activate([
            trackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            trackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            trackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            trackView.heightAnchor.constraint(equalToConstant: 150)
        ])
        
        NSLayoutConstraint.activate([
            recSegmentedControl.topAnchor.constraint(equalTo: view.topAnchor, constant: 480),
            recSegmentedControl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20)
        ])
        
        NSLayoutConstraint.activate([
            slider.topAnchor.constraint(equalTo: view.topAnchor, constant: 480),
            slider.leadingAnchor.constraint(equalTo: recSegmentedControl.trailingAnchor, constant: 20),
            slider.widthAnchor.constraint(equalToConstant: 100),
            slider.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
        
    }
}
//// MARK: - SwiftUI
//import SwiftUI
//
//struct StrubEditorVCProvider: PreviewProvider {
//    static var previews: some View {
//        ContainerView().edgesIgnoringSafeArea(.all)
//    }
//
//    struct ContainerView: UIViewControllerRepresentable {
//
//
//        let tabBarVC = MainTabBarController()
//
//        func makeUIViewController(context: UIViewControllerRepresentableContext<StrubEditorVCProvider.ContainerView>) ->  MainTabBarController {
//            return tabBarVC
//        }
//
//        func updateUIViewController(_ uiViewController: StrubEditorVCProvider.ContainerView.UIViewControllerType, context: UIViewControllerRepresentableContext<StrubEditorVCProvider.ContainerView>) {
//
//        }
//    }
//}
