//
//  GeneratorRandomValue.swift
//  Right on target
//
//  Created by Павел Ходенков on 03.04.2023.
//

import UIKit

//Реализация бизнес-логики генератора случайного значения

protocol GeneratorRandomValueProtocol {
    func getRandomValue() -> Int
}

//Сущность 'Генератор случайного значения'
class GeneratorRandomValue: GeneratorRandomValueProtocol {

    //Минимальное возможное случаное значение
    private let minRandomValue: Int
    //Максимальное возможное случаное значение
    private let maxRandomValue: Int
    
    init?(minRandomValue: Int, maxRandomValue: Int) {
        guard minRandomValue < maxRandomValue else {
            return nil
        }
        self.minRandomValue = minRandomValue
        self.maxRandomValue = maxRandomValue
    }
    
    //Получение случайного значения
    func getRandomValue() -> Int {
        return (minRandomValue...maxRandomValue).randomElement()!
    }
}
