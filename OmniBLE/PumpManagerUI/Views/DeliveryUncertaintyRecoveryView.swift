//
//  DeliveryUncertaintyRecoveryView.swift
//  OmniBLE
//
//  Created by Pete Schwamb on 8/17/20.
//  Copyright © 2020 LoopKit Authors. All rights reserved.
//

import SwiftUI
import LoopKitUI

struct DeliveryUncertaintyRecoveryView: View {
    
    let model: DeliveryUncertaintyRecoveryViewModel

    init(model: DeliveryUncertaintyRecoveryViewModel) {
        self.model = model
    }

    var body: some View {
        GuidePage(content: {
            Text(String(format: LocalizedString("自 %2$@ 以来，%1$@ 一直无法与您身上的 pod 通信。\n\n如果不与 pod 通信，应用程序将无法继续发送胰岛素输送命令或显示有关您的活性胰岛素的准确的最新信息 或 Pod 输送的胰岛素。\n\n在接下来的 6 小时或更长时间内密切监测您的血糖，因为您体内可能有也可能没有 %3$@ 无法显示的胰岛素在积极工作。", comment: "Format string for main text of delivery uncertainty recovery page. (1: app name)(2: date of command)(3: app name)"), self.model.appName, self.uncertaintyDateLocalizedString, self.model.appName))
                .padding([.top, .bottom])
        }) {
            VStack {
                Text(LocalizedString("准备重新建立沟通", comment: "Description string above progress indicator while attempting to re-establish communication from an unacknowledged command")).padding(.top)
                ProgressIndicatorView(state: .indeterminantProgress)
                Button(action: {
                    self.model.podDeactivationChosen()
                }) {
                    Text(LocalizedString("停用豆荚", comment: "Button title to deactive pod on uncertain program"))
                    .actionButtonStyle(.destructive)
                    .padding()
                }
            }
        }
        .navigationBarTitle(Text(LocalizedString("无法到达豆荚", comment: "Title of delivery uncertainty recovery page")), displayMode: .large)
        .navigationBarItems(leading: backButton)
    }
    
    private var uncertaintyDateLocalizedString: String {
        DateFormatter.localizedString(from: model.uncertaintyStartedAt, dateStyle: .none, timeStyle: .short)
    }
    
    private var backButton: some View {
        Button(LocalizedString("后退", comment: "Back button text on DeliveryUncertaintyRecoveryView"), action: {
            self.model.onDismiss?()
        })
    }
}

struct DeliveryUncertaintyRecoveryView_Previews: PreviewProvider {
    static var previews: some View {
        let model = DeliveryUncertaintyRecoveryViewModel(appName: "Test App", uncertaintyStartedAt: Date())
        return DeliveryUncertaintyRecoveryView(model: model)
    }
}
