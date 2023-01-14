//
//  SampleCumstomEmbedSegue.swift
//  ContainerViewSample
//
//  Created by Ysk.Manabe on 2023/01/14.
//

import UIKit

final class SampleCumstomEmbedSegue: UIEmbedSegue {

    override func perform() {

        guard let parent = self.parent else {
            return
        }

        guard let container = self.container else {
            return
        }

        self.source.willMove(toParent: nil)
        parent.addChild(self.destination)

        self.destination.view.frame = .zero

        parent.transition(from: self.source,
                          to: self.destination,
                          duration: 0.3) {
            self.destination.view.frame = container.bounds
            self.source.view.frame = .zero
        } completion: { finished in
            self.source.removeFromParent()
            self.destination.didMove(toParent: parent)
        }

    }

}
