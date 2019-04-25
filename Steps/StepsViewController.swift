//
//  StepsViewController.swift
//  Steps
//
//  Created by jason on 2019/4/23.
//  Copyright © 2019年 jason. All rights reserved.
//

import UIKit

class StepsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, StepUpdateDelegate{
    
    var tableView: UITableView = {
        let tableview = UITableView()
        return tableview
    }()
    
    let cellId = "cellId"
    
    let stepViewModel = StepViewModel()
    
    override func viewWillAppear(_ animated: Bool) {
        stepViewModel.delegate = self
        stepViewModel.fetchData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    fileprivate func setupView(){
        view.addSubview(tableView)
        tableView.backgroundColor = UIColor(red: 0.9333, green: 0.9294, blue: 0.9059, alpha: 1.0)
        tableView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, topPadding: 0, leftPadding: 0, bottomPadding: 0, rightPadding: 0, width: 0, height: 0)
        tableView.register(StepsTableViewCell.self, forCellReuseIdentifier: cellId)
        tableView.delegate = self
        tableView.dataSource = self
       
    }
    
    func finishFetchData() {
        tableView.reloadData()
    }
    
    func failFetchData(error: String) {
        let alert = UIAlertController(title: "Error", message: error, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "I know", style: .default, handler: nil))
        self.present(alert, animated: true)
    }
    
    func fetchPre(){
        stepViewModel.getPrePage()
    }
    
    func fetchNext() {
        stepViewModel.getNextPage()
    }
    
    @objc func handleCancel() {
        dismiss(animated: true, completion: nil)
    }
    
     func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = StepsTableViewHeader()
        header.delegate = self
        header.configure(total: stepViewModel.getTotalSteps())
        return header
    }
    
     func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stepViewModel.getTotalCount()
    }
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! StepsTableViewCell
       
            cell.configure(with: stepViewModel.steps![indexPath.row], max: stepViewModel.maxStep!)
     
       
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 64
    }
}
