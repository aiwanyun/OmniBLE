//
//  LowReservoirReminderSetupView.swift
//  OmniBLE
//
//  Created by Pete Schwamb on 5/17/21.
//  Copyright © 2021 LoopKit Authors. All rights reserved.
//

import SwiftUI
import LoopKitUI
import LoopKit
import HealthKit

struct LowReservoirReminderSetupView: View {

    @State var lowReservoirReminderValue: Int
    
    public var valueChanged: ((_ value: Int) -> Void)?
    public var continueButtonTapped: (() -> Void)?
    public var cancelButtonTapped: (() -> Void)?

    var insulinQuantityFormatter = QuantityFormatter(for: .internationalUnit())

    func formatValue(_ value: Int) -> String {
        return insulinQuantityFormatter.string(from: HKQuantity(unit: .internationalUnit(), doubleValue: Double(value))) ?? ""
    }

    var body: some View {
        GuidePage(content: {
            VStack(alignment: .leading, spacing: 15) {
                Text(LocalizedString("You will be notified when the amount of insulin in the Pod reaches a selected level.\n\nScroll to set the number of units (1 to 50) at which you would like to be reminded.", comment: "Description text on LowReservoirReminderSetupView"))
                Divider()
                HStack {
                    Text(LocalizedString("低水箱", comment: "Label text for low reservoir value row"))
                    Spacer()
                    Text(formatValue(lowReservoirReminderValue))
                }
                picker
            }
            .padding(.vertical, 8)
        }) {
            VStack {
                Button(action: {
                    continueButtonTapped?()
                }) {
                    Text(LocalizedString("下一个", comment: "Text of continue button on ExpirationReminderSetupView"))
                        .actionButtonStyle(.primary)
                }
            }
            .padding()
        }
        .navigationBarTitle(LocalizedString("低水箱", comment: "navigation bar title for low reservoir"), displayMode: .automatic)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(LocalizedString("取消", comment: "Cancel button title"), action: {
                    cancelButtonTapped?()
                })
            }
        }
    }
    
    private var picker: some View {
        Picker("", selection: $lowReservoirReminderValue) {
            ForEach(Pod.allowedLowReservoirReminderValues, id: \.self) { value in
                Text(formatValue(value))
            }
        }.pickerStyle(WheelPickerStyle())
        .onChange(of: lowReservoirReminderValue) { value in
            valueChanged?(value)
        }

    }

}
struct LowReservoirReminderSetupView_Previews: PreviewProvider {
    static var previews: some View {
        LowReservoirReminderSetupView(lowReservoirReminderValue: 10)
    }
}
