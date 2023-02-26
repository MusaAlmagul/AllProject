//
//  MyTableViewCell.swift
//  testProject
//
//  Created by Almagul Musabekova on 25.01.2023.
//

import UIKit

 


/*
 final class MyTableViewCell: UITableViewCell {

    static let IDENTIFIER = "MyTableViewCell"
     
    private lazy var itemCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 100, height: 175)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(MyCollectionViewCell.self, forCellWithReuseIdentifier: MyCollectionViewCell.IDENTIFIER)//регестрация метода который переиспользуеться это MyCollectionViewCell
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false//это бегунок линия убрать false
        return collectionView
    }()
     
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        itemCollectionView.dataSource = self
        itemCollectionView.delegate = self
        
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


//MARK: Collection view data source methods
extension MyTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10//на самом деле по дефолту возвращ одну лишь секц
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MyCollectionViewCell.IDENTIFIER, for: indexPath) as! MyCollectionViewCell
        cell.layer.masksToBounds = true//оснговной экран можно сказать если его не добавить   ваши изменение сверху него не будут изменены кпк наклейка
        cell.layer.cornerRadius = 25 //насколько % закруглить
              // cell.setText(with: "\(Int.random(in: 0..<10))")примет как каждый раз при появл клетки пересозdelegate = cell
        return cell
    }
}

//MARK: - Collection view delegate methods
extension MyTableViewCell: UICollectionViewDelegate {//чтобы все клетки были кликабельные в UICollectionViewDelegate методы существует
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! MyCollectionViewCell
        cell.setText(with: "\(Int.random(in: 0..<10))")
    }
}

//MARK: - Setup views and constraints methods

private extension MyTableViewCell {
    
    func setupViews() {
        contentView.addSubview(itemCollectionView)
        
        
    }
    
    func setupConstraints() {
        itemCollectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()//здесь заполняет секцию
        }
    }
}
 */
/*
 import UIKit
 import SnapKit

 final class ViewController: UIViewController {

      private let myItems: [[String]] = [["Pencil","Pencil", "Pencil", "Pencil"],[ "Pencil","Pencil", "Pencil","Pencil"],["Pencil","Pencil", "Pencil"]]
      private let myTitleItems: [String] = ["Title", "Title", "Title"]


      private lazy var myTableView: UITableView = {
          //let tableView = UITableView(frame: .zero, style: .grouped)//баг тайтла чтобы вместе скролилься
          let tableView = UITableView()
          tableView.register(MyTableViewCell.self, forCellReuseIdentifier: MyTableViewCell.IDENTIFIER)
          tableView.allowsSelection = false //при нажатия что то происходит
          tableView.showsVerticalScrollIndicator = false
          return tableView
      }()

      override func viewDidLoad() {
         super.viewDidLoad()
         // Do any additional setup after loading the view.

          view.backgroundColor = .systemBackground//в зависимости от темы

          myTableView.dataSource = self
          myTableView.delegate = self// func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
          //return 50

          setupViews()
          setupConstraints()
     }


 }
 //MARK: - TableView data source methods

 extension ViewController: UITableViewDataSource {

     func numberOfSections(in tableView: UITableView) -> Int {
         return myTitleItems.count//default section
     }

     func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {//для каждого яч разные названия
         return "Title\(section)"
     }
     func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
         guard let view = view as? UITableViewHeaderFooterView else {fatalError()}
         view.textLabel?.font = UIFont.boldSystemFont(ofSize: 30)
         view.textLabel?.textColor = .label
         view.contentConfiguration = .none
     }
 //    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {//метод который меняет хеадер котрый по умолчанию
 //        let view = SectionHeaderView()
 //        view .setupText(on: "\(myTitleItems[section])\(section)")
 //        return view
 //    }
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return myItems[section].count
     }

     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {//сколько будет элементов в таблвью
         let cell = tableView.dequeueReusableCell(withIdentifier: MyTableViewCell.IDENTIFIER, for: indexPath) as! MyTableViewCell
         cell.setText(with: "Pencil\(indexPath.section).\(indexPath.row)")
         cell.backgroundColor = .clear
         return cell
     }
 }
 //MARK: - Delegate table view

 extension ViewController: UITableViewDelegate {
     func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
         return 50//размер ячейки
     }
     func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
         return 30
     }
 //    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
 //        let didSelect = UITableView()
 //        didSelect.delegate = .none
 //        return didSelect
 //    }
 }

 //MARK: - Setup views and constraints methods

 private extension ViewController {

     func setupViews() {
         view.addSubview(myTableView)

     }

     func setupConstraints() {
         myTableView.snp.makeConstraints { make in
             make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
             make.leading.trailing.equalToSuperview().inset(15)
             make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)

         }

     }

 }

 class MyTableViewCell: UITableViewCell {

     static let IDENTIFIER = "MyTableView"
     private lazy var myText: UILabel = {
         let label = UILabel()
         label.font = UIFont.systemFont(ofSize: 30)
         label.text = "TEST"
         label.backgroundColor = .systemBackground
         return label
     }()
    
     private lazy var myImage: UIImageView = {
         let imageView = UIImageView()
         imageView.image = UIImage(systemName: "highlighter")
         imageView.contentMode = .scaleAspectFit
         imageView.backgroundColor = .systemBackground
         return imageView
     }()
     
     override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
         super.init(style: style, reuseIdentifier: reuseIdentifier)
         
         setupViews()
         setupConstraints()
     }
     
     
     required init?(coder: NSCoder) {
         fatalError("init(coder:) has not been implemented")
     }
     
     func setText(with string: String) {//methods for private
         myText.text = string//on the ViewController
     }
     
     func setImage(with image: UIImage) {//methods for private
         myImage.image = image//on the ViewController
     }
 }

 //MARK: Setup views and constraints methods

 private extension MyTableViewCell {
     
     func setupViews() {
         contentView.addSubview(myText)
         contentView.addSubview(myImage)
         
     }
     
     func setupConstraints() {
         myText.snp.makeConstraints { make in
             make.top.leading.bottom.equalToSuperview()
             make.width.equalToSuperview().multipliedBy(0.5)
         }
         
         myImage.snp.makeConstraints { make in
             make.top.trailing.bottom.equalToSuperview()
             make.leading.equalTo(myText.snp.trailing)
         }
     }
 }
 */
