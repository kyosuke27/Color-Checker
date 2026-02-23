import SwiftUI

struct SettingScreen: View {
    @State var selectedImageType: SettingImageType = .defaultImage
    let appSettingReposiroty:AppSettingsRepository = AppSettingsRepositoryImpl()
    var body: some View {
        ScrollView {
            VStack {
                menuItemHeader("テーマカラー")
                colorItemRowView()
            }
            .padding()
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.extendedColors.component.borderColor, lineWidth: 1)
            )
        }
        .padding()
    }

    func menuItemHeader(_ title: String) -> some View {
        VStack(alignment: .leading) {
            HStack(alignment: .center) {
                Text(title)
                    .foregroundStyle(Color.extendedColors.base.baseFontColor)
                    .fontWeight(.bold)

            }
            Divider()
                .background(.white)
        }
        .frame(maxWidth: .infinity)
    }

    func colorItemRowView() -> some View {
        HStack {
            ForEach(SettingImageType.allCases, id: \.rawValue) {setting in
                SettingImageCardView(selectedSetingImagType: selectedImageType, settingImageType: setting, side: 45, onTap: {selectedImageType = setting})
            }
            Spacer()
        }
        .frame(maxWidth: .infinity)
    }
}

#Preview {
    SettingScreen()
}
