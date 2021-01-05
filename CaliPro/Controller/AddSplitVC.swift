//
//  AddSplitVC.swift
//  CaliPro
//
//  Created by Kento Nambara on 2020/12/23.
//  Copyright © 2020 Kento Nambara. All rights reserved.
//

import UIKit

class AddSplitVC: UIViewController {
    @IBOutlet weak var addSplitTableView: UITableView!
    
    let sectionHeaderTitles = [
        "Days of the week",
        "Length per workout"
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.largeTitleDisplayMode = .never
        navigationItem.title = "Add Split"
        
        addSplitTableView.delegate = self
        addSplitTableView.dataSource = self
    }
    
    @IBAction func didChangeSegment(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
             
        }
    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    
    private func prepareSelectDayCell() -> UITableViewCell {
        return addSplitTableView.dequeueReusableCell(withIdentifier: "SelectDaysCell") as! SelectDaysCell
    }
    
    private func prepareWorkoutLengthCell() -> UITableViewCell {
        return addSplitTableView.dequeueReusableCell(withIdentifier: "LengthPerWorkoutCell") as! LengthPerWorkoutCell
    }

}

// MARK:- UITableView DataSource, Delegate

extension AddSplitVC: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionHeaderTitles[section]
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = prepareSelectDayCell()
            return cell
        default:
            let cell = prepareWorkoutLengthCell()
            return cell
        }
    }
    
}
