//
//  CategoryViewController.swift
//  Idus
//
//  Created by 김희진 on 2021/08/15.
//

import UIKit
import PagingKit

class CategoryViewController: UIViewController {

    var menuViewController: PagingMenuViewController!
    var contentViewController: PagingContentViewController!

    @IBOutlet var upperView: UIView!
    
    
    
    var dataSource = [(menu:String, content: UIViewController)]() {
        didSet{
            menuViewController.reloadData()
            contentViewController.reloadData()
        }
    }
    
    lazy var firstLoad: (() -> Void)? = {[weak self, menuViewController, contentViewController] in

        menuViewController!.reloadData()
        contentViewController!.reloadData()

        self?.firstLoad = nil
    }
    
    fileprivate func makeDataSource() -> [(menu:String, content: UIViewController)]{
        let myMenuArray = ["작품", "클래스"]
        return myMenuArray.map{
            let title = $0

            switch title {
            case "작품":
                let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "CategoryWorkViewController") as! CategoryWorkViewController
                
                return (menu: title, content: vc)

            case "클래스":
                let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "CategoryClassViewController") as! CategoryClassViewController
            
                return (menu: title, content: vc)
           
            default:
                let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "CategoryWorkViewController") as! CategoryWorkViewController
                
                return (menu: title, content: vc)

            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        super.viewDidLoad()
        
        menuViewController.register(nib: UINib(nibName: "MenuCell", bundle: nil), forCellWithReuseIdentifier: "MenuCell")

        menuViewController.registerFocusView(nib: UINib(nibName: "FocusView", bundle: nil))
    
        menuViewController.cellAlignment = .center
        dataSource = makeDataSource()
        
        upperView.layer.addBorder([.bottom], color: UIColor.lightGray, width: 1.0)

        // Do any additional setup after loading the view.
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        firstLoad?()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
          if let vc = segue.destination as? PagingMenuViewController {
              menuViewController = vc
              menuViewController.dataSource = self
              menuViewController.delegate = self
          } else if let vc = segue.destination as? PagingContentViewController {
              contentViewController = vc
              contentViewController.dataSource = self
              contentViewController.delegate = self
          }
    }
    


}



extension CategoryViewController: PagingMenuViewControllerDataSource {
    func numberOfItemsForMenuViewController(viewController: PagingMenuViewController) -> Int {
        return dataSource.count
    }
    
    func menuViewController(viewController: PagingMenuViewController, widthForItemAt index: Int) -> CGFloat {
        return view.frame.size.width/2
    }
    
    func menuViewController(viewController: PagingMenuViewController, cellForItemAt index: Int) -> PagingMenuViewCell {
        let cell = viewController.dequeueReusableCell(withReuseIdentifier: "MenuCell", for: index) as! MenuCell
       
        cell.titleLabel.text = dataSource[index].menu
        return cell
    }
}

extension CategoryViewController: PagingContentViewControllerDataSource {
    func numberOfItemsForContentViewController(viewController: PagingContentViewController) -> Int {
        return dataSource.count
    }
    
    func contentViewController(viewController: PagingContentViewController, viewControllerAt index: Int) -> UIViewController {
        return dataSource[index].content
    }
}

extension CategoryViewController: PagingMenuViewControllerDelegate {
    func menuViewController(viewController: PagingMenuViewController, didSelect page: Int, previousPage: Int) {

        contentViewController.scroll(to: page, animated: true)
    }
}

extension CategoryViewController: PagingContentViewControllerDelegate {
    
    func contentViewController(viewController: PagingContentViewController, didManualScrollOn index: Int, percent: CGFloat) {
        menuViewController.scroll(index: index, percent: percent, animated: false)
    }
    
}

