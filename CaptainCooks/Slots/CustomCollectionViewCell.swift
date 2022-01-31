//
//  CustomCollectionViewCell.swift
//  CaptainCooks
//
//  Created by Prokopenko Ihor on 24.01.2022.
//

import UIKit

class CustomCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var tableView: UITableView!
    
    
    func setTableViewDelegate<D: UITableViewDelegate & UITableViewDataSource>(delegate: D, forItem item: Int) {
        tableView.dataSource = delegate
        tableView.delegate = delegate
        tableView.tag = item
        tableView.reloadData()
    }
    
     func shuffleData(slotIndexPath: IndexPath) {
        switch tableView.tag {
        case 0, 5, 10:
            DispatchQueue.main.asyncAfter(deadline: .now() ) {
                self.tableView.scrollToRow(at: slotIndexPath, at: .middle, animated: true)
            }
            
        case 1, 6, 11:
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
                self.tableView.scrollToRow(at: slotIndexPath, at: .middle, animated: true)
            }
            
        case 2, 7, 12:
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                self.tableView.scrollToRow(at: slotIndexPath, at: .middle, animated: true)
            }
            
        case 3, 8, 13:
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) {
                self.tableView.scrollToRow(at: slotIndexPath, at: .middle, animated: true)
            }
            
        case 4, 9, 14:
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                self.tableView.scrollToRow(at: slotIndexPath, at: .middle, animated: true)
            }
        default:
            break
        }
    }
    }
