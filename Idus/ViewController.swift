//
//  ViewController.swift
//  Idus
//
//  Created by 김희진 on 2021/08/14.
//

import UIKit
import PagingKit

class ViewController: UIViewController{
    
    @IBOutlet var pushAgreeView: UIView!
    @IBOutlet var searchBar: UIImageView!
    
    var menuViewController: PagingMenuViewController!
    var contentViewController: PagingContentViewController!

    let focusView = UnderlineFocusView()

    static var viewController: (UIColor) -> UIViewController = { (color) in
           let vc = UIViewController()
            vc.view.backgroundColor = color
            return vc
        }

    
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
        let myMenuArray = ["투데이", "실시간", "NEW"]
        return myMenuArray.map{
            let title = $0

            switch title {
            case "투데이":
                let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "TodayViewController") as! TodayViewController

                return (menu: title, content: vc)

            case "실시간":
                let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "CurrentViewController") as! CurrentViewController
                return (menu: title, content: vc)

            case "NEW":
                let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "NewViewController") as! NewViewController
                return (menu: title, content: vc)

            default:
                let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "TodayViewController") as! TodayViewController
                return (menu: title, content: vc)

            }
        }
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
            menuViewController.register(nib: UINib(nibName: "MenuCell", bundle: nil), forCellWithReuseIdentifier: "MenuCell")

            menuViewController.registerFocusView(nib: UINib(nibName: "FocusView", bundle: nil))
//            menuViewController.registerFocusView(view: focusView)
        
            menuViewController.cellAlignment = .center
            
            dataSource = makeDataSource()
        
//            if UserDefaults.standard.value(forKey: "jwt") == nil {
//                pushAgreeView.isHidden = false
//                tabBarController?.tabBar.isHidden = true
//            }

        
        
        let tapSearching = UITapGestureRecognizer(target: self, action: #selector(self.tapSearch(_:)))
            searchBar.isUserInteractionEnabled = true
            searchBar.addGestureRecognizer(tapSearching)
                
    }

    @objc func tapSearch(_ sender: UITapGestureRecognizer) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "SearchViewController") as! SearchViewController

        let navigationController = self.navigationController

        tabBarController?.tabBar.isHidden = true
        self.navigationController?.navigationBar.tintColor = .orange
        vc.navigationItem.leftBarButtonItem = UIBarButtonItem( image: UIImage(systemName: "arrow.left"), style: .plain ,target: vc, action: #selector(vc.closeView))

        navigationController?.isNavigationBarHidden = false
        
        let transition = CATransition()
        transition.duration = 0.4
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        transition.type = CATransitionType.moveIn
        transition.subtype = CATransitionSubtype.fromTop
        navigationController?.view.layer.add(transition, forKey: nil)
        navigationController?.pushViewController(vc, animated: false)

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
    
    
    
    @IBAction func okAction(_ sender: Any) {
        pushAgreeView.isHidden = true
        tabBarController?.tabBar.isHidden = false
    }
    

}


extension ViewController: PagingMenuViewControllerDataSource {
    func numberOfItemsForMenuViewController(viewController: PagingMenuViewController) -> Int {
        return dataSource.count
    }
    
    func menuViewController(viewController: PagingMenuViewController, widthForItemAt index: Int) -> CGFloat {
        return view.frame.size.width/3
    }
    
    func menuViewController(viewController: PagingMenuViewController, cellForItemAt index: Int) -> PagingMenuViewCell {
        let cell = viewController.dequeueReusableCell(withReuseIdentifier: "MenuCell", for: index) as! MenuCell
       
        cell.titleLabel.text = dataSource[index].menu
        return cell
    }
}

extension ViewController: PagingContentViewControllerDataSource {
    func numberOfItemsForContentViewController(viewController: PagingContentViewController) -> Int {
        return dataSource.count
    }
    
    func contentViewController(viewController: PagingContentViewController, viewControllerAt index: Int) -> UIViewController {
        return dataSource[index].content
    }
}

extension ViewController: PagingMenuViewControllerDelegate {
    func menuViewController(viewController: PagingMenuViewController, didSelect page: Int, previousPage: Int) {

        contentViewController.scroll(to: page, animated: true)
    }
}

extension ViewController: PagingContentViewControllerDelegate {
    
    func contentViewController(viewController: PagingContentViewController, didManualScrollOn index: Int, percent: CGFloat) {
        menuViewController.scroll(index: index, percent: percent, animated: false)
        adjustfocusViewWidth(index: index, percent: percent)
    }
    
    func adjustfocusViewWidth(index: Int, percent: CGFloat) {
        let adjucentIdx = percent < 0 ? index - 1 : index + 1
        guard let currentCell = menuViewController.cellForItem(at: index) as? TitleLabelMenuViewCell,
            let adjucentCell = menuViewController.cellForItem(at: adjucentIdx) as? TitleLabelMenuViewCell else {
            return
        }
        focusView.underlineWidth = adjucentCell.calcIntermediateLabelSize(with: currentCell, percent: percent)
    }
    
    func setFocusViewWidth(index: Int) {
        guard let cell = menuViewController.cellForItem(at: index) as? TitleLabelMenuViewCell else {
            return
        }
        focusView.underlineWidth = cell.labelWidth
    }
}

