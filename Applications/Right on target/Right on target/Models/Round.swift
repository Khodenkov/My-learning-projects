//
//  Round.swift
//  Right on target
//
//  Created by Павел Ходенков on 03.04.2023.
//

import UIKit

//Реализация бизнес-логики отдельного раунда

protocol RoundProtocol {

    var points: Int {get}
    var secretValue: Int! {get}
    func countingOfPoints(with value: Int)
}

//Сущность 'Раунд'
class Round: RoundProtocol {
    
    //Очки за раунд
    var points: Int = 0
    //Загаданное значение в раунде
    var secretValue: Int!
    
    init(secretValue: Int) {
        self.secretValue = secretValue
    }
    
    //Вычисление значения, на которое установлен ползунок слайдера, сравнение этого значения с загаданным числом, вычисление и начисление очков
    func countingOfPoints(with value: Int) {
        print("Выбранное значение \(value)")
        if value == secretValue{
            points = 50
            print("Начислено очков: 50")
        } else if value < secretValue {
            points = 50 - secretValue + value
            print("Начислено очков: \(50 - secretValue + value)")
        } else if value > secretValue {
            points = 50 - value + secretValue
            print("Начислено очков: \(50 - value + secretValue)")
        }
    }
}


