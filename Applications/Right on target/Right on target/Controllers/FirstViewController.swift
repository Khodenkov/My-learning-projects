//
//  ViewController.swift
//  Right on target
//
//  Created by Павел Ходенков on 03.04.2023.
//

import UIKit

class FirstViewController: UIViewController {
    
    //Экземпляр игры
    var game: Game!
    
    
    //Слайдер с бегунком
    @IBOutlet var slider: UISlider!
    //Метка с загаданным числом
    @IBOutlet var label: UILabel!
    
    
    //MARK: - Взаимодействие Model-View
    
    //По нажатию на кнопку 'Проверить', вызывается данный метод
    @IBAction func checkNumber() {
        //Начисление очков за пройденный раунд
        game.currentRound.countingOfPoints(with: getValueSlider())
        //Проверка, закончилась игра или нет
        if game.endOfTheGame {
            //Игра продолжается. Переход к следующему раунду
            game.startNewRound()
        } else {
            //Игра закончилась. Вывод сообщения на экран
            creatAlertEndOfTheGame(with: game.sumPoints)
            //Старт новой игры
            game.startNewGame()
        }
        //Установка нового загаданного значения в метку
        setTextLabel(text: String(game.currentRound.secretValue))
    }
    
    
    //MARK: - Жизненный цикл ViewController
    
    //Загрузка графических элементов в память устройства
    override func loadView() {
        super.loadView()
        print("loadView")
    }
    //Предварительная настройка игры, перед тем как сцена появится на экране
    override func viewDidLoad() {
        super.viewDidLoad()
        print("viewDidLoad")
        
        //Создание экземпляра игры
        game = Game(countRounds: 5,
                    generator: GeneratorRandomValue(minRandomValue: 1, maxRandomValue: 50))
        //Предварительная настройка метки - установка загаданного значения в метку
        setTextLabel(text: String(game.currentRound.secretValue))
    }
    //Вызов данного метода происходит перед добавлением графических элементов в иерархию View
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("viewWillAppear")
    }
    //Вызов данного метода происходит после добавления графических элементов в иерархию View
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("viewDidAppear")
    }
    //Вызов данного метода происходит перед удалением графических элементов из иерархии View
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("viewWillDisappear")
    }
    //Вызов данного метода происходит после удаления графических элементов из иерархии View
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print("viewDidDisappear")
    }
    //Удаление экземпляра FirstViewController
    deinit {
        print("Экземпляр FirstViewController удалён")
    }
    
    
    //MARK: - Обновление View
    
    //Получение значения со слайдера, выбранного пользователем с помощью бегунка
    private func getValueSlider() -> Int {
        return Int(slider.value)
    }
    //Добавление текста в метку
    private func setTextLabel(text: String) {
        label.text = text
    }
    //Создание объявления об окончании игры с результатом заработанных очков и предложением начать новую игру
    private func creatAlertEndOfTheGame(with score: Int) {
        let result = UIAlertController(title: "Игра окончена!",
                                       message: "Вы набрали \(score) очка(ов)",
                                       preferredStyle: .actionSheet)
        let buttonNewGame = UIAlertAction(title: "Начать новую игру",
                                          style: .cancel,
                                          handler: nil)
        result.addAction(buttonNewGame)
        present(result, animated: true)
    }
}
        


