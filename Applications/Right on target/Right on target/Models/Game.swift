//
//  Game.swift
//  Right on target
//
//  Created by Павел Ходенков on 03.04.2023.
//

import UIKit

//Реализация бизнес-логики игры 'Угадай число'

protocol GameProtocol {
    
    var sumPoints: Int {get}
    var generator: GeneratorRandomValueProtocol {get}
    var currentRound: RoundProtocol! {get}
    var endOfTheGame: Bool {get}
    func startNewGame()
    func startNewRound()
}

//Сущность игра 'Угадай число'
class Game: GameProtocol {
    
    //Сумма очков за прошедшие раунды
    var sumPoints: Int {
        var result = 0
        for round in arrayRounds {
            result += round.points
        }
        return result
    }
    //Экземпляр генератора случайного числа
    var generator: GeneratorRandomValueProtocol
    //Экземпляр текущего раунда
    var currentRound: RoundProtocol!
    //Количество раундов в игре
    private let countRounds: Int
    //Массив раундов
    private var arrayRounds: [RoundProtocol] = []
    //Указатель на законченную игру
    var endOfTheGame: Bool {
        if arrayRounds.count < countRounds {
            return true
        } else {
            return false
        }
    }
    
    init(countRounds: Int, generator: GeneratorRandomValueProtocol?) {
        guard let value = generator else {
            assert(false, "minRandomValue должно быть меньше, чем maxRandomValue")
        }
        self.generator = value
        self.countRounds = countRounds
        startNewRound()
    }
    
    //Начало новой игры. Обнуление массива раундов, переход к первому раунду
    func startNewGame() {
        arrayRounds = []
        startNewRound()
    }
    //Переход к новому раунду, установка нового случайного загаданного значения
    func startNewRound() {
        //создание нового экземпляра текущего раунда с инициализацией случаного загаданного значения
        currentRound = Round(secretValue: getRandomSecretValue())
        //добавление нового текущего раунда в массив раундов
        arrayRounds.append(currentRound)
        print("Раунд \(arrayRounds.count)")
    }
    //Получение случайного загаданного значения
    private func getRandomSecretValue() -> Int {
        return generator.getRandomValue()
    }
}

