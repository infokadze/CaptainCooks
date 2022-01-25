//
//  SlotsController.swift
//  CaptainCooks
//
//  Created by Prokopenko Ihor on 13.01.2022.
//

import UIKit

class SlotsController : UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var slotsUpDownAutoscroll: Bool?
    
    //rows - коллекции, items - ячейки с имеджами
    var dataModel = generate2DArray(withRows: 15, itemInEachRow: 18)
    
    var betIndex = 0
    let betValues = [25, 50, 75, 100, 150, 300, 500, 1000]
    var winAmount = 0
    
    
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
    
    @IBOutlet weak var minusButton: UIButton!
    @IBOutlet weak var plusButton: UIButton!
    @IBOutlet weak var backButton: UIButton!
    
    
    @IBOutlet weak var slotBox: UIImageView! {
        didSet {
            slotBox.image = UIImage(named: "slotsBox1")
            
        }
    }

    @IBOutlet weak var wheelImageView: UIImageView! {
        didSet {
            wheelImageView.image = UIImage(named: "wheel")
        }
    }
    
    @IBOutlet weak var balanceLabel: UILabel! {
        didSet {
            _ = makeLabelChewyColor(label: balanceLabel, text: "\(UserDefault.coins)", size: 20, color: Constants.goldColor)
        }
    }
    
        //to check
    @IBOutlet weak var currentBetLabel: UILabel! {
        didSet {
            _ = makeLabelChewyColor(label: currentBetLabel, text: "25", size: 20, color: Constants.purpleColor)
        }
    }
    
    @IBOutlet weak var winLabel: UILabel! {
        didSet {
            _ = makeLabelChewyColor(label: winLabel, text: "###", size: 20, color: Constants.goldColor)
        }
    }
    
    private var totalBet: Int = 0 {
        didSet {
            totalBetLabel.text = "\(totalBet)"
        }
    }
    @IBOutlet weak var totalBetLabel: UILabel! {
        didSet {
            _ = makeLabelChewyColor(label: totalBetLabel, text: "0", size: 20, color: Constants.goldColor)
        }
    }
 
    
    @IBAction func plusCoins(_ sender: UIButton) {
        if betIndex < betValues.count - 1 {
            minusButton.isEnabled = true
            betIndex += 1
            currentBetLabel.text = "\(betValues[betIndex])"
            
        } else if betIndex == betValues.count - 1 {
            sender.isEnabled = false
            
            let alert = UIAlertController(title: "Warning!", message: "Your maximum bet ammount is limited to 1000!", preferredStyle: .alert)
            let okButton = UIAlertAction(title: "Okay", style: .cancel, handler: nil)
            alert.addAction(okButton)
            present(alert, animated: true, completion: nil)
        }
    }
    
    @IBAction func minusCoins(_ sender: UIButton) {
        if betIndex > 0 {
            plusButton.isEnabled = true
            betIndex -= 1
            currentBetLabel.text = "\(betValues[betIndex])"
            
        } else {
            sender.isEnabled = false
            let alert = UIAlertController(title: "Sorry!", message: "You can't bet less than 25!", preferredStyle: .alert)
            let okButton = UIAlertAction(title: "Okay", style: .cancel, handler: nil)
            alert.addAction(okButton)
            present(alert, animated: true, completion: nil)
        }
    }
    
    private var balance: Int = UserDefault.coins {
        didSet {
            balanceLabel.text = "\(balance.formattedWithSeparator)"
            UserDefault.coins = balance
        }
    }
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        slotsUpDownAutoscroll = true
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        balanceLabel.text = "\(balance.formattedWithSeparator)"
        
        totalBetLabel.doGlowAnimation(withColor: Constants.goldColor, withEffect: .evenBigger)
        winLabel.doGlowAnimation(withColor: Constants.goldColor, withEffect: .evenBigger)
        balanceLabel.doGlowAnimation(withColor: Constants.goldColor, withEffect: .evenBigger)
        
        
        loadMainLevelAttributes()
    }
    
    
    @IBAction func spinAction(_ sender: UIButton) {
        
        totalBet += betValues[betIndex]
//      totalBetLabel.text = "\(abs((UserDefault.coins - (balance + (betValues[betIndex])))))"
        
        if betValues[betIndex] > UserDefault.coins {
            let alert = UIAlertController(title: "Sorry!", message: "Your bet is bigger than your current balance", preferredStyle: .alert)
            let okButton = UIAlertAction(title: "Okay", style: .cancel, handler: nil)
            alert.addAction(okButton)
            present(alert, animated: true, completion: nil)
        } else {
        
        wheelImageView.startRotating()
            sender.isEnabled = false
            backButton.isEnabled = false
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.92) {
                sender.isEnabled = true
                self.backButton.isEnabled = true
            }
            
        UserDefault.coins -= betValues[betIndex]
        balanceLabel.text = "\(UserDefault.coins.formattedWithSeparator)"
        
        switch self.slotsUpDownAutoscroll {
            
        case true:
            
            for element in 0..<self.dataModel.count {
                let c = self.collectionView.cellForItem(at: IndexPath(row: element, section: 0)) as! CustomCollectionViewCell
                
                c.setTableViewDelegate(delegate: self, forItem: element)
                
                //in order to remove glitch of data model creation
                
                c.tableView.scrollToRow(at: IndexPath(row: 9, section: 0), at: .middle, animated: true)
                self.dataModel = generate2DArray(withRows: 15, itemInEachRow: 18)
                c.shuffleData(slotIndexPath: [0, 17])
                
                
                #warning("!")
                //check win combo with dispatch queau
            }
            
            
            self.slotsUpDownAutoscroll = false
            print("RES17")
            print(self.dataModel[0][17])
            print(self.dataModel[1][17])
            print(self.dataModel[2][17])
            print(self.dataModel[3][17])
            print(self.dataModel[4][17])
            
            print(self.dataModel[5][17])
            print(self.dataModel[6][17])
            print(self.dataModel[7][17])
            print(self.dataModel[8][17])
            print(self.dataModel[9][17])
            
            print(self.dataModel[10][17])
            print(self.dataModel[11][17])
            print(self.dataModel[12][17])
            print(self.dataModel[13][17])
            print(self.dataModel[14][17])
            
        case false:
            
            for element in 0..<self.dataModel.count  {
                let c = self.collectionView.cellForItem(at: IndexPath(row: element, section: 0)) as! CustomCollectionViewCell
                c.setTableViewDelegate(delegate: self, forItem: element)
            
                //in order to remove glitch of data model creation
                
                c.tableView.scrollToRow(at: IndexPath(row: 9, section: 0), at: .middle, animated: true)
                self.dataModel = generate2DArray(withRows: 15, itemInEachRow: 18)
                c.shuffleData(slotIndexPath: [0, 0])
                
                #warning("!")
                //check win combo with dispatch queau
            }
            
            self.slotsUpDownAutoscroll = true
            
            print("RES0")
            print(self.dataModel[0][0])
            print(self.dataModel[1][0])
            print(self.dataModel[2][0])
            print(self.dataModel[3][0])
            print(self.dataModel[4][0])
            
            print(self.dataModel[5][0])
            print(self.dataModel[6][0])
            print(self.dataModel[7][0])
            print(self.dataModel[8][0])
            print(self.dataModel[9][0])
            
            print(self.dataModel[10][0])
            print(self.dataModel[11][0])
            print(self.dataModel[12][0])
            print(self.dataModel[13][0])
            print(self.dataModel[14][0])
            
        default:
            break
        }
    }
}
    
    
    @IBAction func backButtonAction(_ sender: UIButton) {
        let storyBoard = UIStoryboard(name: Constants.storyboardName.mainName, bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: Constants.storyboardID.main) as! InitialViewController
        present(vc, animated: true)
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

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "tcell", for: indexPath) as? CustomTableViewCell {
        
            let imageName = dataModel[tableView.tag][indexPath.item]
            
            switch UserDefault.coins {
            case 0..<12_000:
                cell.imageView?.image = UIImage(named: "\(imageName)(1).png)")
                
            case 12_000..<14_000:
                cell.imageView?.image = UIImage(named: "\(imageName)(2).png)")
                
            case 14_000..<16_000:
                cell.imageView?.image = UIImage(named: "\(imageName)(3).png)")
                
            case 16_000..<18_000:
                cell.imageView?.image = UIImage(named: "\(imageName)(4).png)")
                
            case 18_000... :
                cell.imageView?.image = UIImage(named: "\(imageName)(5).png)")
                
            default:
                break
            }
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

extension SlotsController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = collectionView.frame.height / 3
        let width = collectionView.frame.width / 5
        print(height)
        print(width)

        return CGSize(width: width, height: height)
    }
}

extension SlotsController {
    
    func loadMainLevelAttributes () {
        
        switch UserDefault.coins {
        case 0..<12_000:
            characterImageView.image = UIImage(named: "character1")
            slotsImageView.image = UIImage(named: "slotScreen1")
            slotBox.image = UIImage(named: "slotsBox1")
            
        case 12_000..<14_000:
            characterImageView.image = UIImage(named: "character2")
            slotsImageView.image = UIImage(named: "slotScreen2")
            slotBox.image = UIImage(named: "slotsBox2")
            
        case 14_000..<16_000:
            characterImageView.image = UIImage(named: "character3")
            slotsImageView.image = UIImage(named: "slotScreen3")
            slotBox.image = UIImage(named: "slotsBox3")
        case 16_000..<18_000:
            characterImageView.image = UIImage(named: "character4")
            slotsImageView.image = UIImage(named: "slotScreen4")
            slotBox.image = UIImage(named: "slotsBox4")
        case 18_000...:
            characterImageView.image = UIImage(named: "character5")
            slotsImageView.image = UIImage(named: "slotScreen5")
            slotBox.image = UIImage(named: "slotsBox5")
        default:
            break
        }
        
        
    }
}

    

    
    



