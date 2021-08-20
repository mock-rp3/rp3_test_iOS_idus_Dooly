//
//  ClassViewController.swift
//  Idus
//
//  Created by 김희진 on 2021/08/15.
//

import UIKit
import PagingKit

class ClassViewController: UIViewController {
    

    var menuViewController: PagingMenuViewController!
    var contentViewController: PagingContentViewController!

    
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
        let myMenuArray = ["온라인", "오프라인"]
        return myMenuArray.map{
            let title = $0

            switch title {
            case "온라인":
                let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "ClassOnlineViewController") as! ClassOnlineViewController
                
                return (menu: title, content: vc)

            case "오프라인":
                let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "ClassOfflineViewController") as! ClassOfflineViewController
            
                return (menu: title, content: vc)
           
            default:
                let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "ClassOnlineViewController") as! ClassOnlineViewController
                
                return (menu: title, content: vc)

            }
        }
    }

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        menuViewController.register(nib: UINib(nibName: "MenuCell", bundle: nil), forCellWithReuseIdentifier: "MenuCell")

        menuViewController.registerFocusView(nib: UINib(nibName: "FocusView", bundle: nil))
    
        menuViewController.cellAlignment = .center
        dataSource = makeDataSource()
    
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



extension ClassViewController: PagingMenuViewControllerDataSource {
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

extension ClassViewController: PagingContentViewControllerDataSource {
    func numberOfItemsForContentViewController(viewController: PagingContentViewController) -> Int {
        return dataSource.count
    }
    
    func contentViewController(viewController: PagingContentViewController, viewControllerAt index: Int) -> UIViewController {
        return dataSource[index].content
    }
}

extension ClassViewController: PagingMenuViewControllerDelegate {
    func menuViewController(viewController: PagingMenuViewController, didSelect page: Int, previousPage: Int) {

        contentViewController.scroll(to: page, animated: true)
    }
}

extension ClassViewController: PagingContentViewControllerDelegate {
    
    func contentViewController(viewController: PagingContentViewController, didManualScrollOn index: Int, percent: CGFloat) {
        menuViewController.scroll(index: index, percent: percent, animated: false)
    }
    
}

