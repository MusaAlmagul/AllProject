//
//  ViewController.swift
//  testProject
//
//  Created by Almagul Musabekova on 21.01.2023.
//

import UIKit
import SnapKit
 
//HW 9
class ViewController: UIViewController {
    
    private lazy var sightTableView: UITableView = {
        let tableView = UITableView()
        tableView.register(SightTableViewCell.self, forCellReuseIdentifier: SightTableViewCell.IDENTIFIER)
        tableView.backgroundColor = .clear
        tableView.showsVerticalScrollIndicator = false
        tableView.separatorStyle = .singleLine
        tableView.allowsSelection = false
        
        return tableView
    }()
    
    private lazy var myCollectionView: UICollectionView = {
        
        
        return myCollectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        view.backgroundColor = .systemBackground
        sightTableView.dataSource = self
       // sightTableView.delegate = self
        setupViews()
        setupConstraints()
        
    }
}


//MARK: - Table view data source and delegate

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        DateBase.sightList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SightTableViewCell.IDENTIFIER, for: indexPath) as! SightTableViewCell
        cell.configure(with: DateBase.sightList[indexPath.row])
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return view.frame.size.height * 0.075
    }
    
}
    
    
    //MARK: - Setup View and constrains
    
    extension ViewController {
      
        func setupViews() {
            view.addSubview(sightTableView)
    
        }
    
        func setupConstraints() {
            sightTableView.snp.makeConstraints { make in
                make.top.equalTo(view.safeAreaLayoutGuide.snp.top)//bottom.equalToSuperview()
                make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
                make.leading.trailing.equalToSuperview().inset(5)
            }
        }
    }











////код при создания VC TV and CollectionView с ячейками c лейблами
//final class ViewController: UIViewController {
//
//    private lazy var myCollectionView: UICollectionView = {
//       let layout = UICollectionViewFlowLayout()
//        layout.scrollDirection = .vertical
//        let height = view.frame.size.height * 0.07
//        layout.itemSize = CGSize(width: height * 2, height: height)//меняет размер самой ячейки
//        let colecctionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
//        colecctionView.register(MyCollectionViewCell.self, forCellWithReuseIdentifier: "IDENTIFIER")
//        colecctionView.backgroundColor = .clear
//        return colecctionView
//    }()
//
//     override func viewDidLoad() {
//        super.viewDidLoad()
//        // Do any additional setup after loading the view.
//
//         view.backgroundColor = .systemBackground//в зависимости от темы
//         myCollectionView.dataSource = self
//         setupViews()
//         setupConstraints()
//    }
//
//
//}
////MARK: - Collection View data source methods
//
//extension ViewController: UICollectionViewDataSource {
////    func numberOfSections(in collectionView: UICollectionView) -> Int {
////        return 10
////    }
//
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return 44
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "IDENTIFIER", for: indexPath) as! MyCollectionViewCell
//        cell.layer.masksToBounds = true
//        cell.layer.cornerRadius = 10
//        cell.backgroundColor = .systemOrange
//        return cell
//    }
//}
//
//
////MARK: - Setup views and constraints methods
//
//private extension ViewController {
//
//    func setupViews() {
//        view.addSubview(myCollectionView)
//
//    }
//
//    func setupConstraints() {
//        myCollectionView.snp.makeConstraints { make in
//            make.edges.equalToSuperview()//заполняет все пространство
//        }
//    }
//
//}
//
//
//
//
//
//
//
//





















/*Проект когда создавали с colectionView с рандомными числами
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
         //view.contentConfiguration = .none
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
         
         cell.backgroundColor = .clear
         return cell
     }
 }
 //MARK: - Delegate table view

 extension ViewController: UITableViewDelegate {
     func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
         return 220//размер ячейки поиграть с этим методом
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
 */

//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 ключь гит хаб

// - 10.01.2023 урок обьясняеть от и до как с ячейками работать

/* 1 начало проекта
 
 final class TestViewController: UIViewController {
     
     private lazy var myLabel: UILabel = {
        let label = UILabel()
         label.font = UIFont.boldSystemFont(ofSize: 55)
         label.textColor = UIColor(named: "MyColor")
         label.text = "I am Fly"
        return label
     }()

    private lazy var myImage: UIImageView = {
         let imageView = UIImageView()
         imageView.image = UIImage(named: "planeta")
         return imageView
     }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
       
        view.backgroundColor = .white
        setupViews()
        setupConstraints()
        
    }


}

//MARK: - Setup views and constraints methods

private extension TestViewController {
    
    func setupViews() {
        view.addSubview(myImage)
        view.addSubview(myLabel)
      
        
    }
    
    func setupConstraints() {
        myLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(myImage.snp.top).offset(-30)
        }
        
        myImage.snp.makeConstraints { make in
           make.center.equalToSuperview()
            make.width.height.equalTo(300)
            
        }
    }
}
 
 2 урок по проекту когда view по горизонтально
 func setupConstraints() {
     redView.snp.makeConstraints { make in
         make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
         make.leading.trailing.equalToSuperview()
         make.height.equalTo(view.safeAreaLayoutGuide.snp.height).dividedBy(3)//.multipliedBy(0.33)1variant
     }
     
     greenView.snp.makeConstraints { make in
         make.top.equalTo(redView.snp.bottom)
         make.leading.trailing.equalToSuperview()
         make.height.equalTo(view.safeAreaLayoutGuide.snp.height).dividedBy(3)
}
     }
     
     yellowView.snp.makeConstraints { make in
         make.top.equalTo(greenView.snp.bottom)
         make.leading.trailing.equalToSuperview()
         make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).dividedBy(3)//.multipliedBy(0.33)
     }
 }
 
 //3 урок по вертикали
 final class TestViewController: UIViewController {
     
     private lazy var redView: UIView = {
         let view = UIView()
         view.backgroundColor = .systemRed
         return view
     }()
     
     private lazy var greenView: UIView = {
         let view = UIView()
         view.backgroundColor = .systemGreen
         return view
     }()
     
     private lazy var yellowView: UIView = {
        let view = UIView()
         view.backgroundColor = .systemYellow
         return view
     }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
       
        view.backgroundColor = .systemBlue
        setupViews()
        setupConstraints()
    }


}

 func setupConstraints() {
     redView.snp.makeConstraints { make in
         make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
         make.leading.equalToSuperview()
         make.width.equalTo(view.safeAreaLayoutGuide.snp.width).dividedBy(3)//.multipliedBy(0.33)1variant
         make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
     }
     
     greenView.snp.makeConstraints { make in
         make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
         make.leading.equalTo(redView.snp.trailing)
         make.width.equalTo(view.safeAreaLayoutGuide.snp.width).dividedBy(3)
         make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
     }
     
     yellowView.snp.makeConstraints { make in
         make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
         make.leading.equalTo(greenView.snp.trailing)
         make.trailing.equalToSuperview()
         make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        
     }
 }
 
 ***Вариант когда вьюшки на 3 части поделены
 
 func setupConstraints() {
     redView.snp.makeConstraints { make in
         make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
         make.leading.equalToSuperview()
         make.height.equalTo(view.safeAreaLayoutGuide.snp.height).dividedBy(2)
         make.width.equalTo(view.safeAreaLayoutGuide.snp.width).dividedBy(2)
     }
     greenView.snp.makeConstraints { make in
         make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
         make.trailing.equalToSuperview()
         make.leading.equalTo(redView.snp.trailing)
         make.bottom.equalTo(yellowView.snp.top)
     }
     yellowView.snp.makeConstraints { make in
         make.top.equalTo(redView.snp.bottom)
         make.leading.trailing.equalToSuperview()
         make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
     }
 }
 
*** 4вариант на 3 части поделено и по середки квадрат
 //MARK: - Setup views and constraints methods

 private extension TestViewController {
     
     func setupViews() {
         view.addSubview(beggerView)
         beggerView.addSubview(redView)
         beggerView.addSubview(greenView)
         view.addSubview(yellowView)

         
     }
     
     func setupConstraints() {
         
         beggerView.snp.makeConstraints { make in
             make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
             make.leading.trailing.equalToSuperview()
             make.height.equalTo(view.safeAreaLayoutGuide.snp.height).dividedBy(2)
         }
         redView.snp.makeConstraints { make in
             make.edges.equalToSuperview()
         }
         greenView.snp.makeConstraints { make in
             make.center.equalToSuperview()
             make.size.equalToSuperview().dividedBy(2)
         }
         yellowView.snp.makeConstraints { make in
             make.top.equalTo(beggerView.snp.bottom)
             make.leading.trailing.equalToSuperview()
             make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
         }
     }
      
 ****hw 7
 
 final class TestViewController: UIViewController {
     
     private lazy var myLabel: UILabel = {
        let label = UILabel()
         label.text = "I am Rich"
         label.textColor = .white
         label.textAligment = .center
         label.font = UIFont.systemFont(ofSize: 40)
         return label
     }()

    private lazy var myImage: UIImageView = {
      let imageView = UIImageView()
      imageView.image = UIImage(named: "planeta")
      return imageView
  }()
 
 private lazy var myAccountLabel: UILabel = {
      label.text = "Account money: ????$"
      label.textAligment = .center
      label.font = UIFont.systemFont(ofSize: 20)
      let label = UILabel()
      return label
  }()
 
 private lazy var changeButton: UIButton = {
   let button = UIButton()
   return button
 
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
       
        view.backgroundColor = UIColor(red: 13/25, green:71/255, blue:21/255, alpha: 1)
        setupViews()
        setupConstraints()
    }
}

//MARK: - Setup views and constraints methods

private extension TestViewController {
    
    func setupViews() {
        
        view.addSubview(myLabel)
        view.addSubview(myImage)
        view.addSubview(myAccountLabel)
        view.addSubview(changeButton)
      }
    
    func setupConstraints() {
             myLabel.snp.makeConstraints { make in
             make.buttom.equalTo(myImage.snp.top)
             make.centerX.equalToSuperview()
             myImage.snp.makeConstraints { make in
    //        make.top.leading.tralling.bottom.equalToSuperview()
              make.edges.equalToSuperview()
              make.center.equalToSuperview()
              make.size.equalTo(view.snp.width).multipliedBy(0.8)
        }
    }
}
 
 */
