import SwiftUI

struct aaaaaa : View {
    var body: some View {
        Text("History")
            .font(Font.custom("SFProText-CondensedBold", size: 32))
            .onAppear {
                // Print available fonts when the view appears
                for family in UIFont.familyNames.sorted() {
                    print(family)
                    for name in UIFont.fontNames(forFamilyName: family).sorted() {
                        print("  \(name)")
                    }
                }
            }
    }
}

#Preview {
    Image(systemName: "ellipsis")
        .resizable()
        .aspectRatio(contentMode: .fit)
        .frame(maxWidth: 24, maxHeight: 24)
        .padding()
        .background(.red)
        .cornerRadius(10)
}
