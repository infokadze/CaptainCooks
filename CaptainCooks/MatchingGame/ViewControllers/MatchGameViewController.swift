//
//  ViewController.swift
//  CardMatchGame
//
//  Created by LiewSyetChau on 8/12/21.
//

import UIKit

final class MatchGameViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    //MARK: - outlets
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var getButton: UIButton! 
    @IBOutlet weak var textLabel: UILabel!
    
    let cardModel = CardModel()
    var cardArray = [Card]()

    var firstFlippedCardIndex: IndexPath?
    var secondFlippedCardIndex: IndexPath?
    
    var soundPlayer = SoundManager()
    
    //MARK: - @objc + helpers
    @IBAction func goToMainScreen(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "MainVC")
        self.present(controller, animated: true, completion: nil)
        self.view.window?.rootViewController?.dismiss(animated: false) {
        }
        
    }
    
    private func setButtonImage(button: UIButton, result: Int) {
        let buttonForImage = button
        switch result {
        case 0:
            UIView.animate(withDuration: 0.6) {
                buttonForImage.setImage(UIImage(named: "gotItImage"), for: .normal)
            }
        default:
            UIView.animate(withDuration: 0.6) {
            buttonForImage.setImage(UIImage(named: "getImage"), for: .normal)
        }
    }
}
    
    private func setLabelText(label: UILabel, result: Int) {
        let labelText = label
        switch result {
        case 0:
            UIView.animate(withDuration: 0.6) {
            labelText.text = "Better luck next time!"
            }
        default:
            UIView.animate(withDuration: 0.6) {
            labelText.text = "You earn \(result) coins! Congrats!"
        }
    }
}
    override func viewDidLoad() {
        super.viewDidLoad()
                
        getButton.isHidden = true
        textLabel.text = "Play and find 3 identical cards to win coins"
        
        // Do any additional setup after loading the view.
        cardArray = cardModel.getCards()
        
        // set the view controller as the data source and delegate of the collection view
        collectionView.dataSource = self
        collectionView.delegate = self
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        // Play shuffle sound
        soundPlayer.playSound(effect: .shuffle)
        
        #warning("Important to follow the logic of a-b-c below -> play sound, then adjust anything else")
//        SoundManager.sharedInstance.playSound(effect: .harp)
        SoundManager.sharedInstance.audioPlayer?.numberOfLoops = -1
        SoundManager.sharedInstance.audioPlayer?.volume = 1
    }
    
    
    // MARK: - Collection View Delegate Methods
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //return number of cards
        return cardArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        //get a cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CardCell", for: indexPath) as! CardCollectionViewCell
        //return it
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        //configure state of the cell based on the properties of the card that its represent
        //get the card from card array
        let cardCell = cell as? CardCollectionViewCell
        
        //get the card from the array
        let card = cardArray[indexPath.row]
        
        //finish configuring the cell
        cardCell?.configureCell(card: card)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        //get reference to cell that was tapped
        let cell = collectionView.cellForItem(at: indexPath) as? CardCollectionViewCell
        
        //check the status of the card
        let status = cell?.card?.isFlipped
        
        if status == false && cell?.card?.isMatched == false {
            //flip the card up
            cell?.flipUp()
            // Play flip sound
            soundPlayer.playSound(effect: .flip)

            //check if this is first card flipped or second card flipped
            if firstFlippedCardIndex == nil {
                //this is the first card flipped
                firstFlippedCardIndex = indexPath
            } else if firstFlippedCardIndex != nil && secondFlippedCardIndex == nil {
                secondFlippedCardIndex = indexPath
                //this is the second card flipped
                
                //run comparison logic
                checkForMatchForTwoCards(indexPath)
            } else if firstFlippedCardIndex != nil && secondFlippedCardIndex != nil {
                //run comparison logic
                checkForMatchForThreeCards(indexPath)
            }
        }
    }
    
    // MARK: - Game Logic Methods
    private func checkForMatchForTwoCards(_ secondFlippedCardIndex2: IndexPath) {
        
        //get the two card object and check indices and see if they match
        let cardOne = cardArray[firstFlippedCardIndex!.row]
        self.secondFlippedCardIndex = secondFlippedCardIndex2
        let cardTwo = cardArray[secondFlippedCardIndex!.row]
        
        //get the two collection view cells that represent cardOne and cardTwo
        let cardOneCell = collectionView.cellForItem(at: firstFlippedCardIndex!) as? CardCollectionViewCell
        let cardTwoCell = collectionView.cellForItem(at: secondFlippedCardIndex!) as? CardCollectionViewCell
 
        //compare the two cards
        if cardOne.imageName == cardTwo.imageName {
            //do nothing
        } else {
            //it not match
            
            // Play nomatch sound
            soundPlayer.playSound(effect: .nomatch)
            
            cardOne.isFlipped = false
            cardTwo.isFlipped = false
            
            //flip them back over
            cardOneCell?.flipDown()
            cardTwoCell?.flipDown()
            
            firstFlippedCardIndex = nil
            secondFlippedCardIndex = nil
        }
    }
    
    // MARK: - Game Logic Methods
    private func checkForMatchForThreeCards(_ thirdFlippedCardIndex: IndexPath) {
        
        //get the two card object and check indices and see if they match
        let cardOne = cardArray[firstFlippedCardIndex!.row]
        let cardTwo = cardArray[secondFlippedCardIndex!.row]
        let cardThree = cardArray[thirdFlippedCardIndex.row]
        

        //get the two collection view cells that represent cardOne and cardTwo
        let cardOneCell = collectionView.cellForItem(at: firstFlippedCardIndex!) as? CardCollectionViewCell
        let cardTwoCell = collectionView.cellForItem(at: secondFlippedCardIndex!) as? CardCollectionViewCell
        let cardThreeCell = collectionView.cellForItem(at: thirdFlippedCardIndex) as? CardCollectionViewCell
        
        //compare the two cards
        if cardOne.imageName == cardTwo.imageName && cardOne.imageName == cardThree.imageName{
            //its a match
            
            //set the status and remove them
            cardOne.isMatched = true
            cardTwo.isMatched = true
            cardThree.isMatched = true
            
            let matchedCard = cardOne
            //check for result
            collectionView.isUserInteractionEnabled = false
            checkForGameEnd(matchedCard)
            
        } else {
            //it not match
            // Play nomatch sound
            soundPlayer.playSound(effect: .nomatch)
            
            cardOne.isFlipped = false
            cardTwo.isFlipped = false
            cardThree.isFlipped = false
            
            //flip them back over
            cardOneCell?.flipDown()
            cardTwoCell?.flipDown()
            cardThreeCell?.flipDown()

            firstFlippedCardIndex = nil
            secondFlippedCardIndex = nil
        }
    }
    
    //assume the user has won
    private func checkForGameEnd(_ card: Card) {
        let cardToCheck = card
        var result = 0
        
        switch cardToCheck.imageName {
        case "card1":
            result = 100
            soundPlayer.playSound(effect: .match)
            
            UIView.animate(withDuration: 1.1) {
                self.getButton.isHidden = false
                self.setButtonImage(button: self.getButton, result: result)
                self.setLabelText(label: self.textLabel, result: result)
            }
        case "card2":
            result = 200
            soundPlayer.playSound(effect: .match)

            UIView.animate(withDuration: 1.1) {
                self.getButton.isHidden = false
                self.setButtonImage(button: self.getButton, result: result)
                self.setLabelText(label: self.textLabel, result: result)
            }
        case "card3":
            result = 500
            soundPlayer.playSound(effect: .match)

            UIView.animate(withDuration: 1.1)  {
                self.getButton.isHidden = false
                self.setButtonImage(button: self.getButton, result: result)
                self.setLabelText(label: self.textLabel, result: result)
            }
        case "card4":
            result = 0
            soundPlayer.playSound(effect: .sad)

            UIView.animate(withDuration: 1.1) {
                self.getButton.isHidden = false
                self.setButtonImage(button: self.getButton, result: result)
                self.setLabelText(label: self.textLabel, result: result)
            }
 
        default:
            print("switch went wrong")
        }
    }
        
    private func showAlert(title: String, message: String) {
        //create alert
        let alert = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert
        )
        
        //add btn to user to dismiss it
        let okAction = UIAlertAction(
            title: "Ok",
            style: .default,
            handler: { _ in
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let controller = storyboard.instantiateViewController(withIdentifier: "MainVC")
                self.present(controller, animated: true, completion: nil)
                
            }
        )
        
        alert.addAction(okAction)
        present(
            alert,
            animated: true,
            completion: nil
            //show button
        )
    }
}

extension MatchGameViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        let width = collectionView.frame.width * 0.2857
        let width = 36
        return CGSize(width: width, height: width)
    }
}
