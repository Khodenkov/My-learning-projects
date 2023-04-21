//
//  SecondViewController.swift
//  Right on target
//
//  Created by Павел Ходенков on 05.04.2023.
//

import UIKit

class SecondViewController: UIViewController {
    
    //Загрузка графических элементов в память устройства
    override func loadView() {
        super.loadView()
        print("loadView SecondViewController")
    }
    //Вызов данного метода происходит после загрузки графических элементов в память устройства
    override func viewDidLoad() {
        super.viewDidLoad()
        print("viewDidLoad SecondViewController")
    }
    //Вызов данного метода происходит перед добавлением графических элементов в иерархию View
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("viewWillAppear SecondViewController")
    }
    //Вызов данного метода происходит после добавления графических элементов в иерархию View
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("viewDidAppear SecondViewController")
    }
    //Вызов данного метода происходит перед удалением графических элементов из иерархии View
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("viewWillDisappear SecondViewController")
    }
    //Вызов данного метода происходит после удаления графических элементов из иерархии View
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print("viewDidDisappear SecondViewController")
    }
    //Удаление экземпляра SecondViewController
    deinit {
        print("экземпляр SecondViewController удален")
    }
}

