//
//  HomeVC.swift
//  AdminApp
//
//  Created by Ahmed Zaghloul on 12/8/18.
//  Copyright © 2018 Ahmed Zaghloul. All rights reserved.
//

import UIKit

class HomeVC: BaseViewController{

    @IBOutlet weak var tableView:UITableView!
    @IBOutlet weak var sideView:UIView!
    @IBOutlet weak var topBarView:UIView!
    
    var contents :[Content] = []
    var page = 0
    var maxPages = 1
    var isLoading = false

    override func viewDidLoad() {
        super.viewDidLoad()
        DispatchQueue.main.async {
            self.sideView.dropShadow(scale: true, WithDirection: .right)
            
        }
        DispatchQueue.main.async {
            self.addSideExtensionView()
        }
        
    }
    
    override func getData() {
        super.getData()
        self.isLoading = true
        RequestsManager.defaultManager.getMachinesForPage(page: page) { (failed,maxPages, contents) in
            print(failed)
            if !failed{
                self.maxPages = maxPages!
                self.contents += contents!
            }else{
                DispatchQueue.main.async {
                    self.errorView.isHidden = false
                }
            }
            self.endLoadingAnimation()
        }
    }
    
    override func beginLoadingAnimation() {
        super.beginLoadingAnimation()
    }
    
    override func endLoadingAnimation() {
        DispatchQueue.main.async {
            self.isLoading = false
            self.tableView.reloadData()
            self.activityIndicator.stopAnimating()
        }
    }
    
    @IBAction func sideExtensionButtonTapped(){
        DispatchQueue.main.async {
            self.addSideExtensionView()
        }
    }
    
    func addSideExtensionView() {
        let sideExtensionVC = SideExtensionVC()
        self.addChild(sideExtensionVC)
        self.view.addSubview(sideExtensionVC.view)
        sideExtensionVC.didMove(toParent: self)
        
        let height = view.frame.height
        let width  = view.frame.width  * 0.25
        sideExtensionVC.view.frame = CGRect(x: sideExtensionVC.partialViewXPosition, y: 0, width: width, height: height)
    }
}

// TableView Works
extension HomeVC :UITableViewDelegate,UITableViewDataSource {
//    func numberOfSections(in tableView: UITableView) -> Int {
//        return 2
//    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contents.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HomeCell", for: indexPath) as! HomeCell
        
        cell.content = contents[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.frame.height / 11.0
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if ((scrollView.contentOffset.y + scrollView.frame.size.height)  >= scrollView.contentSize.height + 50 )
        {
            if !self.isLoading && page < maxPages{
                self.page += 1
                getData()
            }
        }
    }
}
