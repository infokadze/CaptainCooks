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
        let storyBoard = UIStoryboard(name: Constants.storyboardName.mainName, bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: Constants.storyboardID.main) as! InitialViewController
        
        playBackgroundAudio(playerClassInstance: SoundManager.sharedAudioBackgroundObject, sound: .main)
        present(vc, animated: true)
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
            labelText.text = "You earned \(result * 3) coins! Congrats!"
                UserDefault.coins += (result * 3)
#warning("set defaults win +=")
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
        super.viewDidAppear(animated)
        // Play shuffle sound +
        _ = SoundManager.sharedAudioBackgroundObject.audioEffectsPlayer?.fadeVolume(from: 1, to: 0, duration: 1, completion: {
            SoundManager.sharedAudioBackgroundObject.audioEffectsPlayer?.stop()
        })
        
        playSoundOneTimer(playerClassInstance: soundPlayer, sound: .shuffle)
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
            playSoundOneTimer(playerClassInstance: soundPlayer, sound: .flip)

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
            playSoundOneTimer(playerClassInstance: soundPlayer, sound: .nomatch)
            
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
            playSoundOneTimer(playerClassInstance: soundPlayer, sound: .nomatch)
            
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
            playSoundOneTimer(playerClassInstance: soundPlayer, sound: .match)
            
            UIView.animate(withDuration: 1.1) {
                self.getButton.isHidden = false
                self.setButtonImage(button: self.getButton, result: result)
                self.setLabelText(label: self.textLabel, result: result)
            }
        case "card2":
            result = 200
            playSoundOneTimer(playerClassInstance: soundPlayer, sound: .match)

            UIView.animate(withDuration: 1.1) {
                self.getButton.isHidden = false
                self.setButtonImage(button: self.getButton, result: result)
                self.setLabelText(label: self.textLabel, result: result)
            }
        case "card3":
            result = 500
            playSoundOneTimer(playerClassInstance: soundPlayer, sound: .match)

            UIView.animate(withDuration: 1.1)  {
                self.getButton.isHidden = false
                self.setButtonImage(button: self.getButton, result: result)
                self.setLabelText(label: self.textLabel, result: result)
            }
        case "card4":
            result = 0
            playSoundOneTimer(playerClassInstance: soundPlayer, sound: .sad)

            UIView.animate(withDuration: 1.1) {
                self.getButton.isHidden = false
                self.setButtonImage(button: self.getButton, result: result)
                self.setLabelText(label: self.textLabel, result: result)
            }
 
        default:
            break
        }
    }
}

extension MatchGameViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        let width = collectionView.frame.width * 0.2857
        let width = 36
        return CGSize(width: width, height: width)
    }
}
