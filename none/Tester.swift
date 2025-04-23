import SwiftUI


#Preview {
    Menu {
        Button {
        } label: {
            Label("Start Program", systemImage: "rectangle.stack.badge.plus")
        }
        Button {
        } label: {
            Label("Edit", systemImage: "folder.badge.plus")
        }
        Button {
        } label: {
            Label("Manage Access", systemImage: "rectangle.stack.badge.person.crop")
        }
        Button {
        } label: {
            Label("Delete", systemImage: "rectangle.stack.badge.person.crop")
        }
    } label: {
        Label("", systemImage: "ellipsis")
            .foregroundStyle(Color("PrimaryColor"))
            .font(.system(size: 18, weight: .bold)) // Increase size and weight
            .symbolRenderingMode(.monochrome) // Ensure consistent styling
            .imageScale(.large) // Optional: Adjust scale if needed
            .frame(width: 44, height: 44)
            .contentShape(Rectangle())
    }
    .menuStyle(.button)
    .animation(.easeInOut)
    .padding(.horizontal, 8)
    .background(.secondaryBg)
    .clipShape(RoundedRectangle(cornerRadius: 5))
}
