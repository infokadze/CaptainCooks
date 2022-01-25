//
//  SlotCombinations.swift
//  CaptainCooks
//
//  Created by Prokopenko Ihor on 24.01.2022.
//

//import Foundation
//
//extension SlotsController {
//
//    func checkWinCombo(won: Bool) {
//        print("top \(SlotModel.topValues)")
//        print("center \(SlotModel.centralValues)")
//        print("bottom \(SlotModel.bottomValues)")
//
//        let t = SlotModel.topValues
//        let c = SlotModel.centralValues
//        let b = SlotModel.bottomValues
//
//        switch won {
//        case    b[0] == b[1] && b[1] == b[2] && b[2] == b[3] && b[3] == b[4] &&
//                    c[0] == c[1] && c[1] == c[2] && c[2] == c[3] && c[3] == c[4] &&
//                    t[0] == t[1] && t[1] == t[2] && t[2] == t[3] && t[3] == t[4]:
//            print("Combination 1")
//            updateBank(winX: 2)
//
//        case    b[0] == b[1] && b[1] == b[2] && b[2] == b[3] && b[3] == b[4] ||
//                    c[0] == c[1] && c[1] == c[2] && c[2] == c[3] && c[3] == c[4] ||
//                    t[0] == t[1] && t[1] == t[2] && t[2] == t[3] && t[3] == t[4]:
//            print("Combination 3")
//            updateBank(winX: 2)
//
//        case    t[0] == t[2] && t[2] == t[4] &&
//                    c[0] == c[2] && c[2] == c[4] &&
//                    b[0] == b[2] && b[2] == b[4]:
//            print("Combination 3")
//            updateBank(winX: 2)
//
//        case    t[1] == t[3] &&
//                    c[1] == c[3]  &&
//                    b[1] == b[3]:
//            print("Combination 4")
//            updateBank(winX: 2)
//
//        case    t[0] == b[1] && b[1] == t[2] &&
//                    t[2] == b[3] && b[3] == t[4]:
//            print("Combination 5")
//            updateBank(winX: 3)
//        case    b[0] == t[1] && t[1] == b[2] &&
//                    b[2] == t[3] && t[3] == b[4]:
//            print("Combination 6")
//            updateBank(winX: 3)
//
//        case    t[1] == t[2] && t[2] == t[3]:
//            print("Combination 7")
//            updateBank(winX: 2)
//
//        case t[0] == t[2] && c[0] == c[2] && b[0] == b[2]:
//            print("Combination 8")
//            updateBank(winX: 2)
//
//        case t[2] == t[4] && c[2] == c[4] && b[2] == b[4]:
//            print("Combination 9")
//            updateBank(winX: 2)
//
//        case t[0] == t[3] && c[0] == c[3] && b[0] == b[3]:
//            print("Combination 10")
//            updateBank(winX: 2)
//
//
//        case t[0] == t[1] && c[0] == c[1] && b[0] == b[1]:
//            print("Combination 11")
//            updateBank(winX: 3)
//
//        case t[1] == t[4] && c[1] == c[4] && b[1] == b[4]:
//            print("Combination 12")
//            updateBank(winX: 2)
//
//        case t[3] == t[4] && c[3] == c[4] && b[3] == b[4]:
//            print("Combination 13")
//
//            updateBank(winX: 2)
//        default :
//            return
//        }
//    }
//
//}
