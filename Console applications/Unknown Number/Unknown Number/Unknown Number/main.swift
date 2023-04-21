//
//  main.swift
//  Unknown Number
//
//  Created by Павел Ходенков on 06.02.2023.
//

import Foundation

//решение пользователя играть в новую игру или нет
var answerUser = UInt8()
//начало новой игры
repeat {
    //объявление пользователю
    print("Компьютер случайным образом загадал число в диапазоне от 1 до 255. Вам требуется отгадать его.")
    //загаданное число
    let randomValue = getRandomValue()
    //основная логика игры
    handlerValue(randomValue: randomValue)
    //спрашиваем пользователя про новую игру
    print("""
    "Хотите начать новую игру? Выберите вариант ответа и нажмите Enter:
    1) Да
    2) Нет
    """)
    //получение ответа пользователя
    answerUser = questionAndAnswer()
    //переход к новой игре, либо завершение игры
} while newGameOrFinishGame(answer: answerUser)

