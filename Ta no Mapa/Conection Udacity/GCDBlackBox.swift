//
//  GCDBlackBox.swift
//  Ta no Mapa
//
//  Created by Wagner  Filho on 27/09/2018.
//  Copyright © 2018 Artesmix. All rights reserved.
//

import Foundation

func performUIUpdatesOnMain(_ updates: @escaping () -> Void) {
    DispatchQueue.main.async {
        updates()
    }
}
