//
//  SlotsController.swift
//  CaptainCooks
//
//  Created by Prokopenko Ihor on 13.01.2022.
//

import UIKit

class SlotsController : UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    private var levelPassed: [Bool] = [false, false, false, false]

    private var isComplete: [Bool] = [false, false, false, false]
    
    private var slotsUpDownAutoscroll: Bool?
        
    //rows - коллекции, items - ячейки с имеджами
    var dataModel = generate2DArray(withRows: 15, itemInEachRow: 18)
    
    private var betIndex = 0
    
    private var betValues: [Int] = [Int]() {
        didSet {
            switch UserDefault.coinsEarned {
            case ..<5_000:
                betValues = [25, 50, 75, 100]
            case 5_000..<10_000:
                betValues = [25, 50, 75, 100, 150]
            case 10_000..<15_000:
                betValues = [25, 50, 75, 100, 150, 300]
            case 15_000..<20_000:
                betValues = [25, 50, 75, 100, 150, 300, 500]
            case 20_000... :
                betValues = [25, 50, 75, 100, 150, 300, 500, 1000]
            default:
                ()
            }
        }
    }
    
    private var winAmount = UserDefault.coinsEarned
    
    @IBOutlet weak var slotsImageView: UIImageView!
    @IBOutlet weak var characterImageView: UIImageView!
    @IBOutlet weak var minusButton: UIButton!
    @IBOutlet weak var plusButton: UIButton!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var slotBox: UIImageView!
    
    
    @IBOutlet weak var wheelImageView: UIImageView! {
        didSet {
            wheelImageView.image = UIImage(named: "wheel")
        }
    }
    
    @IBOutlet weak var balanceLabel: UILabel! {
        didSet {
            _ = makeLabelChewyColor(label: balanceLabel, text: "\(UserDefault.totalCoins)", size: 20, color: Constants.goldColor)
        }
    }
    
    @IBOutlet weak var currentBetLabel: UILabel! {
        didSet {
            _ = makeLabelChewyColor(label: currentBetLabel, text: "25", size: 20, color: Constants.purpleColor)
        }
    }
    
    private var winRound: Int = UserDefault.coinsEarned {
        didSet {
            winLabel.text = "\(winRound.formattedWithSeparator)"
            wonCoinsLabelPerSpin.text = "+\((winAmount - betValues[betIndex]).formattedWithSeparator)"
        }
    }
    
    @IBOutlet weak var winLabel: UILabel! {
        didSet {
            _ = makeLabelChewyColor(label: winLabel, text: "0", size: 20, color: Constants.goldColor)
        }
    }

    @IBOutlet weak var wonCoinsLabelPerSpin: UILabel! {
        didSet {
            _ = makeLabelChewyColor(label: wonCoinsLabelPerSpin, text: "0", size: 23, color: Constants.goldColor)
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
            playSoundOneTimer(playerClassInstance: .sharedAudioOneTimerObject, sound: .plusOrMinus)
            
            minusButton.isEnabled = true
            betIndex += 1
            currentBetLabel.text = "\(betValues[betIndex])"
            
        } else if betIndex == betValues.count - 1 {
            playSoundOneTimer(playerClassInstance: .sharedAudioOneTimerObject, sound: .plusOrMinus)
            sender.isEnabled = false
            
            let alert = UIAlertController(title: "Warning!", message: "You reached your maximum bet ammount! Earn more to unlock next level and higher bet opportunity", preferredStyle: .alert)
            let okButton = UIAlertAction(title: "Okay", style: .cancel, handler: { action in
                self.playSoundOneTimer(playerClassInstance: .sharedAudioOneTimerObject, sound: .click)
             })
            alert.addAction(okButton)
            present(alert, animated: true, completion: nil)
        }
    }
    
    @IBAction func minusCoins(_ sender: UIButton) {
        if betIndex > 0 {
            
            playSoundOneTimer(playerClassInstance: .sharedAudioOneTimerObject, sound: .plusOrMinus)
            
            plusButton.isEnabled = true
            betIndex -= 1
            currentBetLabel.text = "\(betValues[betIndex])"
            
        } else {
            playSoundOneTimer(playerClassInstance: .sharedAudioOneTimerObject, sound: .plusOrMinus)
            sender.isEnabled = false
            let alert = UIAlertController(title: "Sorry!", message: "You can't bet less than 25!", preferredStyle: .alert)
            let okButton = UIAlertAction(title: "Okay", style: .destructive, handler: { action in
                self.playSoundOneTimer(playerClassInstance: .sharedAudioOneTimerObject, sound: .click)
             })
            alert.addAction(okButton)
            present(alert, animated: true, completion: nil)
        }
    }
    
    private var balance: Int = UserDefault.totalCoins {
        didSet {
            balanceLabel.text = "\(balance.formattedWithSeparator)"
            UserDefault.totalCoins = balance
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        slotsUpDownAutoscroll = true
        betValues = [Int]()
        winLabel.text = "\(UserDefault.coinsEarned)"

        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        setLevelPasses()
        setIsCompleteBoolValues()
        loadMainLevelVisualAttributes()
        
        balanceLabel.text = "\(balance.formattedWithSeparator)"
        wonCoinsLabelPerSpin.alpha = 0
        
        
        totalBetLabel.doGlowAnimation(withColor: Constants.goldColor, withEffect: .evenBigger)
        winLabel.doGlowAnimation(withColor: Constants.goldColor, withEffect: .evenBigger)
        balanceLabel.doGlowAnimation(withColor: Constants.goldColor, withEffect: .evenBigger)
    }
    
    func updateBank(multiplyBy: Int) {
        //adding another bet value is due to "-" coins bet operations done by each spin
        playSoundOneTimer(playerClassInstance: .sharedAudioOneTimerObject, sound: .coins)
        
        winAmount = (betValues[betIndex] * multiplyBy + betValues[betIndex])
        
        UserDefault.totalCoins += winAmount
        winRound += (winAmount - betValues[betIndex])
        UserDefault.coinsEarned += (winAmount - betValues[betIndex])
        
        //animation of won amount
        wonCoinsLabelPerSpin.fadeIn(duration: 0.3, delay: 0) { complete in
            self.wonCoinsLabelPerSpin.fadeOut(duration: 2, delay: 0)
        }
        
        balanceLabel.text = "\(UserDefault.totalCoins.formattedWithSeparator)"
    }
    
    @IBAction func spinAction(_ sender: UIButton) {
        _ = Vibro.medium
        playSoundOneTimer(playerClassInstance: .sharedAudioOneTimerObject, sound: .spin)
        
        totalBet += betValues[betIndex]
        UserDefault.totalCoins -= betValues[betIndex]
        balanceLabel.text = "\(UserDefault.totalCoins.formattedWithSeparator)"
        
        if betValues[betIndex] > UserDefault.totalCoins {
            let alert = UIAlertController(title: "Sorry!", message: "Your bet is bigger than your current balance", preferredStyle: .alert)
            let okButton = UIAlertAction(title: "Okay", style: .destructive, handler: { action in
                self.playSoundOneTimer(playerClassInstance: .sharedAudioOneTimerObject, sound: .click)
             })
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
                
                slotsUpDownAutoscroll = false
                checkWinComboFor17(isWin: true)
                
                setLevelPasses()
                isLevelFinished()
                
            case false:
                
                for element in 0..<self.dataModel.count  {
                    let c = self.collectionView.cellForItem(at: IndexPath(row: element, section: 0)) as! CustomCollectionViewCell
                    c.setTableViewDelegate(delegate: self, forItem: element)
                    
                    //in order to remove glitch of data model creation
                    c.tableView.scrollToRow(at: IndexPath(row: 9, section: 0), at: .middle, animated: true)
                    self.dataModel = generate2DArray(withRows: 15, itemInEachRow: 18)
                    c.shuffleData(slotIndexPath: [0, 0])
                }
                
                slotsUpDownAutoscroll = true
                checkWinComboFor0(isWin: true)

                setLevelPasses()
                isLevelFinished()
                
            default:
                ()
            }
        }
    }
    
    @IBAction func backButtonAction(_ sender: UIButton) {
        
        playSoundOneTimer(playerClassInstance: .sharedAudioOneTimerObject, sound: .click)
        
        let storyBoard = UIStoryboard(name: Constants.storyboardName.mainName, bundle: nil)
        let _ = storyBoard.instantiateViewController(withIdentifier: Constants.storyboardID.main) as! InitialViewController
        
        self.dismiss(animated: true, completion: nil)
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
        //  число тейбл вьюх внутри ячейки коллекции (15(принтов относительно ячейки коллекций) == 18(по тегам))
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "tcell", for: indexPath) as? CustomTableViewCell {
            
            let imageName = dataModel[tableView.tag][indexPath.item]
            
            switch UserDefault.levelNumberPicked {
                
            case 1:
                cell.photoImageView?.image = UIImage(named: "\(imageName)(1).png)")
                
            case 2:
                cell.photoImageView?.image = UIImage(named: "\(imageName)(2).png)")
                
            case 3:
                cell.photoImageView?.image = UIImage(named: "\(imageName)(3).png)")
                
            case 4:
                cell.photoImageView?.image = UIImage(named: "\(imageName)(4).png)")
                
            case 5:
                cell.photoImageView?.image = UIImage(named: "\(imageName)(5).png)")
                
            default:
                ()
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
        singleArray += singleArray
        color2DArray.append(singleArray)
    }
    return color2DArray
}

extension SlotsController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = collectionView.frame.height / 3
        let width = collectionView.frame.width / 5
        return CGSize(width: width, height: height)
    }
}

extension SlotsController {
    
   private func loadMainLevelVisualAttributes () {
        
        switch UserDefault.levelNumberPicked {
            
        case 1:
            characterImageView.image = UIImage(named: "character1")
            slotsImageView.image = UIImage(named: "slotScreen1")
            slotBox.image = UIImage(named: "slotsBox1")
            
        case 2:
            characterImageView.image = UIImage(named: "character2")
            slotsImageView.image = UIImage(named: "slotScreen2")
            slotBox.image = UIImage(named: "slotsBox2")
            
        case 3:
            characterImageView.image = UIImage(named: "character3")
            slotsImageView.image = UIImage(named: "slotScreen3")
            slotBox.image = UIImage(named: "slotsBox3")
            
        case 4:
            characterImageView.image = UIImage(named: "character4")
            slotsImageView.image = UIImage(named: "slotScreen4")
            slotBox.image = UIImage(named: "slotsBox4")
            
        case 5:
            characterImageView.image = UIImage(named: "character5")
            slotsImageView.image = UIImage(named: "slotScreen5")
            slotBox.image = UIImage(named: "slotsBox5")
            
        default:
            ()
        }
    }
    
    
    private func isLevelFinished() {
        
        if 0...UserDefault.coinsEarned ~= 5_000 && levelPassed[0] == true && isComplete[0] == false {
            
            isComplete[0] = true
            
            NotificationCenter.default.post(name: Notification.Name(rawValue: "updateToSecondLevel"), object: nil)
            
            let storyBoard = UIStoryboard(name: Constants.storyboardName.bonusName, bundle: Bundle.main)
            let vc = storyBoard.instantiateViewController(withIdentifier: Constants.storyboardID.popUpID) as! PopUpVC
            
            if let presented = self.presentedViewController {
                presented.removeFromParent()
            }
            
            present(vc, animated: true)
            vc.updateToSecondLevel()
            
        }
        
        else if 0...UserDefault.coinsEarned ~= 10_000 && levelPassed[1] == true && isComplete[1] == false {
            
            isComplete[0] = true
            
            NotificationCenter.default.post(name: Notification.Name(rawValue: "updateToThirdLevel"), object: nil)
            
            let storyBoard = UIStoryboard(name: Constants.storyboardName.bonusName, bundle: Bundle.main)
            let vc = storyBoard.instantiateViewController(withIdentifier: Constants.storyboardID.popUpID) as! PopUpVC
            
            if let presented = self.presentedViewController {
                presented.removeFromParent()
            }
            
            present(vc, animated: true)
            vc.updateToThirdLevel()
            
        }
        
        else if 0...UserDefault.coinsEarned ~= 15_000 && levelPassed[2] == true && isComplete[2] == false {

            isComplete[2] = true
            
            NotificationCenter.default.post(name: Notification.Name(rawValue: "updateToForthLevel"), object: nil)
            
            let storyBoard = UIStoryboard(name: Constants.storyboardName.bonusName, bundle: Bundle.main)
            let vc = storyBoard.instantiateViewController(withIdentifier: Constants.storyboardID.popUpID) as! PopUpVC
            
            if let presented = self.presentedViewController {
                presented.removeFromParent()
            }
            
            present(vc, animated: true)
            vc.updateToForthLevel()
            
        }
        
        else if 0...UserDefault.coinsEarned ~= 20_000 && levelPassed[3] == true && isComplete[3] == false {

            isComplete[3] = false
            
            NotificationCenter.default.post(name: Notification.Name(rawValue: "updateToFifthLevel"), object: nil)
            
            let storyBoard = UIStoryboard(name: Constants.storyboardName.bonusName, bundle: Bundle.main)
            let vc = storyBoard.instantiateViewController(withIdentifier: Constants.storyboardID.popUpID) as! PopUpVC
            
            if let presented = self.presentedViewController {
                presented.removeFromParent()
            }
            
            present(vc, animated: true)
            vc.updateToFifthLevel()
            
        }        
    }
    
    private func setLevelPasses() {
        switch UserDefault.coinsEarned {
        case 5_000..<10_000:
            levelPassed[0] = true
        case 10_000..<15_000:
            levelPassed[1] = true
        case 15_000..<20_000:
            levelPassed[2] = true
        case 20_000...:
            levelPassed[3] = true
        default:
            ()
        }
    }
    
    private func setIsCompleteBoolValues() {
        switch UserDefault.coinsEarned {
        case 5_000..<10_000:
            isComplete[0] = true
        case 10_000..<15_000:
            isComplete[1] = true
        case 15_000..<20_000:
            isComplete[2] = true
        case 20_000...:
            isComplete[3] = true
        default:
            ()
        }
    }
}
