//
//  func.swift
//  Unknown Number
//
//  Created by Павел Ходенков on 06.02.2023.
//

import Foundation

// генерация случайного числа
func getRandomValue() -> UInt8 {
    let randomNumber = UInt8.random(in: 1...255)
    return randomNumber
}

//обработка полученного от пользователя значения, вывод результата на консоль
func handlerValue(randomValue value: UInt8) {
    for _ in 1... {
        //запрос значения
        print("Введите ваш вариант и нажмите Enter")
        //проверка значения
        guard let chek = UInt8(readLine() ?? "") else {
            print("Введено некорректное значение. Значение может содержать цифровые символы, составляющие число в промежутке от '0' до '255'")
            continue
        }
        // сравнение введенного и сгенерированного чисел
        if chek > value {
            print("Ваш вариант больше загаданного числа")
            continue
        } else if chek < value {
            print("Ваш вариант меньше загаданного числа")
            continue
        } else {
            print("Вы угадали!")
            break
        }
    }
}

//проверка ответа пользователя на новую игру
func questionAndAnswer() -> UInt8 {
    var result = UInt8()
    for _ in 1... {
        guard let answer = UInt8(readLine() ?? ""), (1...2).contains(answer) else {
            print("Введено некорректное значение. Попробуйте ещё раз...")
            continue
        }
        result = answer
        break
    }
    return result
}

//переход к новой игре, либо завершение игры
func newGameOrFinishGame(answer value: UInt8) -> Bool {
    if value == 1 {
        print("Новая игра")
        return true
    } else {
        print("Игра завершена")
        return false
    }
}


