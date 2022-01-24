//
//  SlotsController.swift
//  CaptainCooks
//
//  Created by Prokopenko Ihor on 13.01.2022.
//

import UIKit

class SlotsController : UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    @IBOutlet weak var slotsImageView: UIImageView! {
        didSet {
            slotsImageView.image = UIImage(named: "slotScreen1")
        }
    }
    
    @IBOutlet weak var characterImageView: UIImageView! {
        didSet {
            characterImageView.image = UIImage(named: "character1")
            characterImageView.layer.zPosition = 5
        }
    }
    
    @IBOutlet weak var slotBox: UIImageView! {
        didSet {
            slotBox.image = UIImage(named: "slotsBox")
            
        }
    }
    
    @IBOutlet weak var wheelImageView: UIImageView! {
        didSet {
            wheelImageView.image = UIImage(named: "wheel")
        }
    }
    
    
    @IBOutlet weak var totalBetLabel: UILabel!
       
    
    @IBAction func backButton(_ sender: UIButton) {
        
    }
    
    
    @IBAction func plusCoins(_ sender: UIButton) {
        
    }
    
    @IBAction func minusCoins(_ sender: UIButton) {
     
    }
    
    @IBOutlet weak var balanceLabel: UILabel! {
        didSet {
            balanceLabel.text = "\(UserDefault.coins.formattedWithSeparator)"
        }
    }
    
    
    
    @IBAction func backButtonAction(_ sender: UIButton) {
        let storyBoard = UIStoryboard(name: Constants.storyboardName.mainName, bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: Constants.storyboardID.main) as! InitialViewController
        present(vc, animated: true)
        
    }
    
    @IBAction func spinAction(_ sender: UIButton) {
        wheelImageView.startRotating()
        
        switch self.slotsUpDownAutoscroll {
            
        case true:
            
            for element in 0..<self.dataModel.count {
                let c = self.collectionView.cellForItem(at: IndexPath(row: element, section: 0)) as! CustomCollectionViewCell
                
                c.setTableViewDelegate(delegate: self, forItem: element)
                
                //in order to remove glitch of data model creation
                
                c.tableView.scrollToRow(at: IndexPath(row: 9, section: 0), at: .middle, animated: true)
                self.dataModel = generate2DArray(withRows: 15, itemInEachRow: 18)
                c.shuffleData(slotIndexPath: [0, 17])
            }
            
            
            self.slotsUpDownAutoscroll = false
            print("RES17")
            print(self.dataModel[0][17])
            print(self.dataModel[1][17])
            print(self.dataModel[2][17])
            print(self.dataModel[3][17])
            print(self.dataModel[4][17])
            
            
        case false:
            
            for element in 0..<self.dataModel.count  {
                let c = self.collectionView.cellForItem(at: IndexPath(row: element, section: 0)) as! CustomCollectionViewCell
                c.setTableViewDelegate(delegate: self, forItem: element)
            
                //in order to remove glitch of data model creation
                
                c.tableView.scrollToRow(at: IndexPath(row: 9, section: 0), at: .middle, animated: true)
                self.dataModel = generate2DArray(withRows: 15, itemInEachRow: 18)
                c.shuffleData(slotIndexPath: [0, 0])
            }
            
            self.slotsUpDownAutoscroll = true
            
            print("RES0")
            print(self.dataModel[0][0])
            print(self.dataModel[1][0])
            print(self.dataModel[2][0])
            print(self.dataModel[3][0])
            print(self.dataModel[4][0])
            
        default:
            break
        }
        
    }
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var slotsUpDownAutoscroll: Bool?
    
    //rows - коллекции, items - ячейки с имеджами
    var dataModel = generate2DArray(withRows: 15, itemInEachRow: 18)

    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        slotsUpDownAutoscroll = true
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ccell", for: indexPath)
        return cell
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataModel.count
//        число коллекшн вьюх на экране (15)
    }
    
    //extra methods
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if let collectionViewCell = cell as? CustomCollectionViewCell {
            collectionViewCell.setTableViewDelegate(delegate: self, forItem: indexPath.item)
        }
    }
}

extension SlotsController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataModel[tableView.tag].count
        //returns "itemInEachRow" of data model
        //  число тейбл вьюх внутри ячейки коллекции (15(принтов относительно ячейки коллекций) == 18(по тегам))
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        print("tableView tag is \(tableView.tag)")
//        print("indexpath is \(indexPath)")
        
        
// experimenting
//        let nums = Int.random(in: 0...17, excluding: indexPath.item)
//        tableView.scrollToRow(at: [0, nums], at: .middle, animated: true)
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "tcell", for: indexPath) as? CustomTableViewCell {
        
            let imageName = dataModel[tableView.tag][indexPath.item]
//            print(" \(dataModel[tableView.tag][indexPath.item]) this is")
            
            cell.imageView?.image = UIImage(named: "\(imageName).png)")
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.frame.height
    }
}
    func generate2DArray(withRows: Int, itemInEachRow: Int) -> [[Int]] {
        let numberOfRows = withRows
        let numberOfItemsInEachRow = itemInEachRow
        var color2DArray = [[Int]]()

        for _ in 1...numberOfRows {
            var singleArray = [Int]()
            for _ in 1...numberOfItemsInEachRow {
                singleArray.append(Int(arc4random_uniform(9) + 1))
            }
            color2DArray.append(singleArray)
        }
        return color2DArray
    }

extension Int {
    static func random(in range: ClosedRange<Int>, excluding x: Int) -> Int {
        if range.contains(x) {
            let r = Int.random(in: Range(uncheckedBounds: (range.lowerBound, range.upperBound)))
            return r == x ? range.upperBound : r
        } else {
            return Int.random(in: range)
        }
    }
}

    
extension SlotsController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = collectionView.frame.height / 3
        let width = collectionView.frame.width / 5
        print(height)
        print(width)

        return CGSize(width: width, height: height)
    }
}
    
    



