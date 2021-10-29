//
//  ViewController.swift
//  AnimateGalery-testTask
//
//  Created by Артур Карачев on 29.10.2021.
//

import UIKit

class ViewController: UIViewController {

    var imageSet = [UIImage(named: "1")!, UIImage(named: "2")!,UIImage(named: "3")!, UIImage(named: "4")!]
    var rand = Int.random(in: 0 ..< 4) // Random index of image
    var isAnimation: Bool = false
    
    // Start/Stop button
    var toggleButton: GradientButton = {
        let button = GradientButton()
        button.setTitle("Start", for: .normal)
        button.topGradientColor = .red
        button.bottomGradientColor = .orange
        button.cornerRadius = 50
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        return button
    }()
    
    let imageView: UIImageView = {
        let iv = UIImageView()
        return iv
    }()
    
    let infoLabel: UILabel = {
       let label = UILabel()
        label.text = "Нажмите Start, чтобы начать анимацию"
        label.textColor = .white
        label.font = label.font.withSize(24)
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        view.addSubview(imageView)
        view.addSubview(toggleButton)
        view.addSubview(infoLabel)
        setup()
    }
    
    func setup() {
        // Button setup
        toggleButton.frame = CGRect(x: (view.frame.size.width-100)/2, y: (view.frame.size.height-150), width: 100, height: 100)
        // ImageView setup
        imageView.image = imageSet[rand]
        imageView.center = view.center
        // InfoLabel setup
        infoLabel.frame = CGRect(x: 50, y: 50, width: 300, height: 150)
    }
    
    @objc func buttonTapped() {
        isAnimation = !isAnimation
        buttonAnimate()
        labelAnimate()
        ivAnimate()
    }
    
    // MARK: - Image View Animation Configuration
    func ivAnimate() {
        if isAnimation {
            UIImageView.animate(withDuration: 2, animations: {
                self.imageView.frame = CGRect(x: 0, y: 0, width: 300, height: 300)
                self.imageView.center = self.view.center
                self.imageView.image = self.imageSet[self.rand]
            }, completion: {done in
                self.ivShrink()
            })
        }
    }
    
    func ivShrink() {
        UIImageView.animate(withDuration: 2, animations: {
            self.imageView.frame = CGRect(x: 0, y: 0, width: 1, height: 1)
            self.imageView.center = self.view.center
            self.imageView.image = self.imageSet[self.rand]
        }, completion: {done in
            self.ivChangeImage()
        })
    }
    
    func ivChangeImage() {
        self.rand = getRandom(self.rand)
        self.ivAnimate()
    }
    
    func getRandom(_ old: Int) -> Int {
        let new = Int.random(in: 0 ..< 4)
        return old != new ? new : getRandom(old)
    }
    
    // MARK: - Button Animation Configuration
    func buttonAnimate() {
        if isAnimation {
            UIButton.animate(withDuration: 5, animations: {
                self.toggleButton.setTitle("Stop", for: .normal)
                self.toggleButton.topGradientColor = .green
                self.toggleButton.bottomGradientColor = .blue
            })
        } else {
            UIButton.animate(withDuration: 5, animations: {
                self.toggleButton.setTitle("Start", for: .normal)
                self.toggleButton.topGradientColor = .red
                self.toggleButton.bottomGradientColor = .orange
            })
        }
    }
    
    // MARK: - Label Animation Configuration
    func labelAnimate() {
        if isAnimation {
            UILabel.animate(withDuration: 2, animations: {
                self.infoLabel.alpha = 0
            })
        } else {
            UILabel.animate(withDuration: 7, animations: {
                self.infoLabel.alpha = 1
            })
        }
    }
}

