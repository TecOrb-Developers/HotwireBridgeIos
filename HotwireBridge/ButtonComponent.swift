//
//  ButtonComponent.swift
//  HotwireBridge
//
//  Created by apple on 13/01/26.
//

import HotwireNative
import UIKit

final class ButtonComponent: BridgeComponent {
    override class nonisolated(unsafe) var name: String { "button" }
    @MainActor
    override func onReceive(message: Message) {
        guard let viewController else { return }
        print("✅ iOS: viewController found, adding button...")
        addButton(via: message, to: viewController)
    }

    private var viewController: UIViewController? {
        delegate?.destination as? UIViewController
    }
    @MainActor
    private func addButton(via message: Message, to viewController: UIViewController) {
        guard let data: MessageData = message.data() else { return }
        print("✅ iOS: Button title = \(data.title)")
        let action = UIAction { [unowned self] _ in
            self.reply(to: "connect")
            print("🔥 iOS: Reply sent!")
        }
        let item = UIBarButtonItem(title: data.title, primaryAction: action)
        viewController.navigationItem.rightBarButtonItem = item
        print("✅ iOS: Button added to navigation bar")
    }
}

private extension ButtonComponent {
    struct MessageData: Decodable {
        let title: String
    }
}
