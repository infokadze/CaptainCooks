//
//  SlotCombinations.swift
//  CaptainCooks
//
//  Created by Prokopenko Ihor on 24.01.2022.
//

import Foundation

extension SlotsController {
    
    func checkWinComboFor17(isWin: Bool) {
        
        switch isWin {
            // 1
        case dataModel[0][17] == dataModel[1][17] && dataModel[1][17] == dataModel[2][17] && dataModel[2][17] == dataModel[3][17] && dataModel[3][17] == dataModel[4][17] && dataModel[5][17] == dataModel[6][17] && dataModel[6][17] == dataModel[7][17] && dataModel[7][17] == dataModel[8][17] && dataModel[8][17] == dataModel[9][17] && dataModel[10][17] == dataModel[11][17] && dataModel[11][17] == dataModel[12][17] && dataModel[12][17] == dataModel[13][17] && dataModel[13][17] == dataModel[14][17]:
            updateBank(multiplyBy: 15)
            print("update bank x15 -> Combination all 17 rows - Monster")
            
            // 2
        case dataModel[0][17] == dataModel[1][17] && dataModel[1][17] == dataModel[2][17] && dataModel[2][17] == dataModel[3][17] && dataModel[3][17] == dataModel[4][17] ||
            
            dataModel[5][17] == dataModel[6][17] && dataModel[6][17] == dataModel[7][17] && dataModel[7][17] == dataModel[8][17] && dataModel[8][17] == dataModel[9][17] ||
            
            dataModel[10][17] == dataModel[11][17] && dataModel[11][17] == dataModel[12][17] && dataModel[12][17] == dataModel[13][17] && dataModel[13][17] == dataModel[14][17]:
            print("update bank x5 -> Combination top/mid/bottom horizontal x5")
            updateBank(multiplyBy: 5)
            
            // 3
        case dataModel[0][17] == dataModel[1][17] && dataModel[1][17] == dataModel[2][17] && dataModel[2][17] == dataModel[3][17] ||
            dataModel[1][17] == dataModel[2][17] && dataModel[2][17] == dataModel[3][17] && dataModel[3][17] == dataModel[4][17] ||
            // top x4
            
            dataModel[5][17] == dataModel[6][17] && dataModel[6][17] == dataModel[7][17] && dataModel[7][17] == dataModel[8][17] ||
            dataModel[6][17] == dataModel[7][17] && dataModel[7][17] == dataModel[8][17] && dataModel[8][17] == dataModel[9][17] ||
            // mid x4
            
            dataModel[10][17] == dataModel[11][17] && dataModel[11][17] == dataModel[12][17] && dataModel[12][17] == dataModel[13][17] ||
            dataModel[11][17] == dataModel[12][17] && dataModel[12][17] == dataModel[13][17] && dataModel[13][17] == dataModel[14][17]:
            // bottom x4
            print("update bank x4 -> Combination top/mid/bottom horizontal x4")
            updateBank(multiplyBy: 4)
            
            // 4
        case dataModel[0][17] == dataModel[1][17] && dataModel[1][17] == dataModel[2][17] ||
            dataModel[1][17] == dataModel[2][17] && dataModel[2][17] == dataModel[3][17] ||
            dataModel[2][17] == dataModel[3][17] && dataModel[3][17] == dataModel[4][17] ||
            //top x3
            
            dataModel[5][17] == dataModel[6][17] && dataModel[6][17] == dataModel[7][17] ||
            dataModel[6][17] == dataModel[7][17] && dataModel[7][17] == dataModel[8][17] ||
            dataModel[7][17] == dataModel[8][17] && dataModel[8][17] == dataModel[9][17] ||
            //mid x3
            
            dataModel[10][17] == dataModel[11][17] && dataModel[11][17] == dataModel[12][17] ||
            dataModel[11][17] == dataModel[12][17] && dataModel[12][17] == dataModel[13][17] ||
            dataModel[12][17] == dataModel[13][17] && dataModel[13][17] == dataModel[14][17]:
            //bottom x3
            print("update bank x3 -> Combination top/mid/bottom horizontal x3")
            updateBank(multiplyBy: 3)
            
            // 5
        case dataModel[0][17] == dataModel[5][17] && dataModel[5][17] == dataModel[10][17] ||
            dataModel[1][17] == dataModel[6][17] && dataModel[6][17] == dataModel[11][17] ||
            dataModel[2][17] == dataModel[7][17] && dataModel[7][17] == dataModel[12][17] ||
            dataModel[3][17] == dataModel[8][17] && dataModel[8][17] == dataModel[13][17] ||
            dataModel[4][17] == dataModel[9][17] && dataModel[9][17] == dataModel[14][17]:
            print("update bank x3 -> Combination vertical 0/1/2/3/4 rows")
            updateBank(multiplyBy: 3)
            
            // 6
        case dataModel[0][17] == dataModel[6][17] && dataModel[6][17] == dataModel[12][17] && dataModel[12][17] == dataModel[8][17] && dataModel[8][17] == dataModel[4][17] ||
            
            dataModel[10][17] == dataModel[6][17] && dataModel[6][17] == dataModel[2][17] && dataModel[2][17] == dataModel[8][17] && dataModel[8][17] == dataModel[14][17] :
            print("update bank x5 -> Combination V for 5 rows")
            updateBank(multiplyBy: 5)
            
            // 7
        case dataModel[0][17] == dataModel[6][17] && dataModel[6][17] == dataModel[12][17] && dataModel[12][17] == dataModel[8][17] ||
            
            //
            dataModel[1][17] == dataModel[7][17] && dataModel[7][17] == dataModel[13][17] && dataModel[13][17] == dataModel[9][17] ||
            
            dataModel[3][17] == dataModel[6][17] && dataModel[6][17] == dataModel[11][17] && dataModel[11][17] == dataModel[5][17] ||
            //
            
            dataModel[4][17] == dataModel[8][17] && dataModel[8][17] == dataModel[12][17] && dataModel[12][17] == dataModel[6][17] ||
            
            dataModel[10][17] == dataModel[6][17] && dataModel[6][17] == dataModel[2][17] && dataModel[2][17] == dataModel[8][17] ||
            
            dataModel[14][17] == dataModel[8][17] && dataModel[8][17] == dataModel[2][17] && dataModel[2][17] == dataModel[6][17]:
            print("update bank x4 -> Combination V for 4 rows")
            updateBank(multiplyBy: 4)
            
            // 8
        case dataModel[0][17] == dataModel[6][17] && dataModel[6][17] == dataModel[12][17] ||
            dataModel[12][17] == dataModel[8][17] && dataModel[8][17] == dataModel[4][17] ||
            dataModel[12][17] == dataModel[6][17] && dataModel[6][17] == dataModel[8][17] ||
            
            dataModel[10][17] == dataModel[6][17] && dataModel[6][17] == dataModel[2][17] ||
            dataModel[2][17] == dataModel[8][17] && dataModel[8][17] == dataModel[14][17] ||
            dataModel[6][17] == dataModel[2][17] && dataModel[2][17] == dataModel[8][17] :
            print("update bank x3 -> Combination V for 3 rows")
            updateBank(multiplyBy: 3)
            
        default:
            break
        }
    }
    
    func checkWinComboFor0(isWin: Bool) {
        switch isWin {
            // 1
        case dataModel[0][0] == dataModel[1][0] && dataModel[1][0] == dataModel[2][0] && dataModel[2][0] == dataModel[3][0] && dataModel[3][0] == dataModel[4][0] && dataModel[5][0] == dataModel[6][0] && dataModel[6][0] == dataModel[7][0] && dataModel[7][0] == dataModel[8][0] && dataModel[8][0] == dataModel[9][0] && dataModel[10][0] == dataModel[11][0] && dataModel[11][0] == dataModel[12][0] && dataModel[12][0] == dataModel[13][0] && dataModel[13][0] == dataModel[14][0]:
            print("update bank x15 -> Combination all 17 rows - Monster")
            updateBank(multiplyBy: 15)
            
            // 2
        case dataModel[0][0] == dataModel[1][17] && dataModel[1][0] == dataModel[2][0] && dataModel[2][0] == dataModel[3][0] && dataModel[3][17] == dataModel[4][0] ||
            
            dataModel[5][0] == dataModel[6][0] && dataModel[6][0] == dataModel[7][0] && dataModel[7][0] == dataModel[8][0] && dataModel[8][0] == dataModel[9][0] ||
            
            dataModel[10][0] == dataModel[11][0] && dataModel[11][0] == dataModel[12][0] && dataModel[12][0] == dataModel[13][0] && dataModel[13][0] == dataModel[14][0]:
            print("update bank x5 -> Combination top/mid/bottom horizontal x5")
            updateBank(multiplyBy: 5)
            
            // 3
        case dataModel[0][0] == dataModel[1][0] && dataModel[1][0] == dataModel[2][0] && dataModel[2][0] == dataModel[3][0] || dataModel[1][0] == dataModel[2][0] && dataModel[2][0] == dataModel[3][0] && dataModel[3][0] == dataModel[4][0] ||
            // top x4
            
            dataModel[5][0] == dataModel[6][0] && dataModel[6][0] == dataModel[7][0] && dataModel[7][0] == dataModel[8][0] ||
            dataModel[6][0] == dataModel[7][0] && dataModel[7][0] == dataModel[8][0] && dataModel[8][0] == dataModel[9][0] ||
            // mid x4
            
            dataModel[10][0] == dataModel[11][0] && dataModel[11][0] == dataModel[12][0] && dataModel[12][0] == dataModel[13][0] || dataModel[11][0] == dataModel[12][0] && dataModel[12][0] == dataModel[13][0] && dataModel[13][0] == dataModel[14][0]:
            // bottom x4
            print("update bank x4 -> Combination top/mid/bottom horizontal x4")
            updateBank(multiplyBy: 4)
            
            // 4
        case dataModel[0][0] == dataModel[1][0] && dataModel[1][0] == dataModel[2][0] ||
            dataModel[1][0] == dataModel[2][0] && dataModel[2][0] == dataModel[3][0] ||
            dataModel[2][0] == dataModel[3][0] && dataModel[3][0] == dataModel[4][0] ||
            //top x3
            
            dataModel[5][0] == dataModel[6][0] && dataModel[6][0] == dataModel[7][0] ||
            dataModel[6][0] == dataModel[7][0] && dataModel[7][0] == dataModel[8][0] ||
            dataModel[7][0] == dataModel[8][0] && dataModel[8][0] == dataModel[9][0] ||
            //mid x3
            
            dataModel[10][0] == dataModel[11][0] && dataModel[11][0] == dataModel[12][0] ||
            dataModel[11][0] == dataModel[12][0] && dataModel[12][0] == dataModel[13][0] ||
            dataModel[12][0] == dataModel[13][0] && dataModel[13][0] == dataModel[14][0]:
            //bottom x3
            print("update bank x3 -> Combination top/mid/bottom horizontal x3")
            updateBank(multiplyBy: 3)
            
            // 5
        case dataModel[0][0] == dataModel[5][0] && dataModel[5][0] == dataModel[10][0] ||
            dataModel[1][0] == dataModel[6][0] && dataModel[6][0] == dataModel[11][0] ||
            dataModel[2][0] == dataModel[7][0] && dataModel[7][0] == dataModel[12][0] ||
            dataModel[3][0] == dataModel[8][0] && dataModel[8][0] == dataModel[13][0] ||
            dataModel[4][0] == dataModel[9][0] && dataModel[9][0] == dataModel[14][0]:
            print("update bank x3 -> Combination vertical 0/1/2/3/4 rows")
            updateBank(multiplyBy: 3)
            
            // 6
        case dataModel[0][0] == dataModel[6][0] && dataModel[6][0] == dataModel[12][0] && dataModel[12][0] == dataModel[8][0] && dataModel[8][0] == dataModel[4][0] ||
            
            dataModel[10][0] == dataModel[6][0] && dataModel[6][0] == dataModel[2][0] && dataModel[2][0] == dataModel[8][0] && dataModel[8][0] == dataModel[14][0] :
            print("update bank x5 -> Combination V for 5 rows")
            updateBank(multiplyBy: 5)
            
            // 7
        case dataModel[0][0] == dataModel[6][0] && dataModel[6][0] == dataModel[12][0] && dataModel[12][0] == dataModel[8][0] ||
            
            //
            dataModel[1][0] == dataModel[7][0] && dataModel[7][0] == dataModel[13][0] && dataModel[13][0] == dataModel[9][0] ||
            
            dataModel[3][0] == dataModel[6][0] && dataModel[6][0] == dataModel[11][0] && dataModel[11][0] == dataModel[5][0] ||
            //
            
            dataModel[4][0] == dataModel[8][0] && dataModel[8][0] == dataModel[12][0] && dataModel[12][0] == dataModel[6][0] ||
            
            dataModel[10][0] == dataModel[6][0] && dataModel[6][0] == dataModel[2][0] && dataModel[2][0] == dataModel[8][0] ||
            
            dataModel[14][0] == dataModel[8][0] && dataModel[8][0] == dataModel[2][0] && dataModel[2][0] == dataModel[6][0]:
            print("update bank x4 -> Combination V for 4 rows")
            updateBank(multiplyBy: 4)
            
            // 8
        case dataModel[0][0] == dataModel[6][0] && dataModel[6][0] == dataModel[12][0] ||
            dataModel[12][0] == dataModel[8][0] && dataModel[8][0] == dataModel[4][0] ||
            dataModel[12][0] == dataModel[6][0] && dataModel[6][0] == dataModel[8][0] ||
            
            dataModel[10][0] == dataModel[6][0] && dataModel[6][0] == dataModel[2][0] ||
            dataModel[2][0] == dataModel[8][0] && dataModel[8][0] == dataModel[14][0] ||
            dataModel[6][0] == dataModel[2][0] && dataModel[2][0] == dataModel[8][0] :
            print("update bank x3 -> Combination V for 3 rows")
            updateBank(multiplyBy: 3)
            
        default:
            break
            
        }
    }
}
