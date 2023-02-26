//
//  MyCollectionViewCell.swift
//  testProject
//
//  Created by Almagul Musabekova on 27.01.2023.
//

import UIKit







//код при создания VC TV and CollectionView с ячейками
//class MyCollectionViewCell: UICollectionViewCell {
//
//
//    private lazy var myLabel: UILabel = {//в нашу клеточку добавление лейбла
//      let label = UILabel()
//        label.font = .systemFont(ofSize: 30)
//        label.text = "\(Int.random(in: 10..<99))"
//        label.textColor = .white
//        label.backgroundColor = .systemBlue
//        label.textAlignment = .center
//        return label
//    }()
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        setupViews()
//        setupsConstrains()
//
//
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//}
////MARK: - Setup views and constrains
//
//private extension MyCollectionViewCell {
//
//    func setupViews() {
//        contentView.addSubview(myLabel)
//    }
//
//    func setupsConstrains() {
//        myLabel.snp.makeConstraints { make in
//            make.edges.equalToSuperview()
//        }
//    }
//}


















/*
 class MyCollectionViewCell: UICollectionViewCell {
     
     static let IDENTIFIER = "MyCollectionViewCell"
     
     private lazy var myLabel: UILabel = {
       let label = UILabel()
         label.font = UIFont.systemFont(ofSize: 30)
         label.textAlignment = .center
         label.textColor = .white
         //label.text = "\(Int.random(in: 0..<10))"
         return label
     }()
    
     override init(frame: CGRect) {
         super.init(frame: frame)
         
         contentView.backgroundColor = .systemBlue
         setupViews()
         setupConstraints()
         
         
     }
     required init?(coder: NSCoder) {
         fatalError("init(coder:) has not been implemented")
     }
     
     func setText(with text: String) {
         myLabel.text = text
     }
 }

 //MARK: - Setup views and constrains

 private extension  MyCollectionViewCell {
     
     func setupViews() {
         contentView.addSubview(myLabel)
         
     }
     
     func setupConstraints() {
         myLabel.snp.makeConstraints { make in
             myLabel.snp.makeConstraints { make in
                 make.edges.equalToSuperview()
             }
         }
     }
 }
 */
