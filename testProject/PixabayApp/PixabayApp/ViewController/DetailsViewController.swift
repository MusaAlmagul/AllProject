//
//  DetsilsViewController.swift
//  PixabayApp
//
//  Created by Almagul Musabekova on 25.02.2023.
//

import UIKit

class DetailsViewController: UIViewController {

    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        //imageView.backgroundColor = .systemGray
        return imageView
    }()
    private lazy var closeButton: UIButton = {
       let button = UIButton()
        button.setTitle("Close", for: .normal)
        button.addTarget(self, action: #selector(buttonIsTupped), for: .touchUpInside)//action button
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 28)//size button
//        button.layer.borderColor = .init(red: 0, green: 0, blue: 0, alpha: 1)
//        button.layer.borderWidth = 0.5
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //view.backgroundColor = .systemCyan
        view.backgroundColor = .init(red: 0, green: 0, blue: 0, alpha: 0.8)//backgroundColor прозрачным кроме imageView
        
        setupsViews()
        setupConstrains()
    }
    
    func configure(with urlString: String) {
        guard let url = URL(string: urlString) else { return }
        DispatchQueue.main.async {
            self.imageView.kf.setImage(with: url)
        }
        
    }
    
    @objc func buttonIsTupped() {
        dismiss(animated: true)
    }
}

//MARK: - Setup View and constrains methods

private extension DetailsViewController {
    
    func setupsViews() {
        view.addSubview(imageView)
        view.addSubview(closeButton)
    }
    
    func setupConstrains() {
        imageView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.size.equalTo(view.frame.size.width)
        }
        closeButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.5)
            make.bottom.equalToSuperview().inset(30)
        }
    }
}

