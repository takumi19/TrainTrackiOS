// PopupMenu.swift
import SwiftUI

/// A fully custom, keyboard-navigable menu you can drop anywhere.
///
/// Usage:
/// ```swift
/// @State private var showMenu = false
///
/// Button(action: { withAnimation { showMenu = true } }) { Image(systemName: "ellipsis") }
/// .popupMenu(isPresented: $showMenu) {
///     PopupMenuItem(icon: "arrow.right.circle.fill",
///                   title: "Start Program", tint: .green) { start() }
///     PopupMenuItem(icon: "pencil.circle.fill",
///                   title: "Edit",          tint: .green) { edit() }
///     PopupMenuItem(icon: "person.crop.circle.badge.share",
///                   title: "Manage Access", tint: .green) { share() }
///     PopupMenuItem(icon: "xmark", title: "Delete",
///                   tint: .red, isDestructive: true) { delete() }
/// }
/// ```
struct PopupMenuItem: Identifiable {
    let id = UUID()
    var icon: String
    var title: String
    var tint: Color
    var isDestructive: Bool = false
    var action: () -> Void
}

private struct PopupMenuModifier<Label>: ViewModifier where Label: View {
    @Binding var isPresented: Bool
    let items: [PopupMenuItem]
    @ViewBuilder var label: () -> Label

    // MARK: – constants
    private let cornerRadius: CGFloat = 16
    private let maxWidth: CGFloat    = 220
    private let padding: CGFloat     = 12

    func body(content: Content) -> some View {
        ZStack {
            content

            if isPresented {
                // dimmed backdrop
                Color.black.opacity(0.35)
                    .ignoresSafeArea()
                    .onTapGesture { withAnimation { isPresented = false } }
                    .transition(.opacity)

                // the menu itself
                menu
                    .transition(.scale.combined(with: .opacity))
                    .accessibilityAddTraits(.isModal)
            }
        }
        .animation(.spring(response: 0.35, dampingFraction: 0.8), value: isPresented)
    }

    // MARK: – menu view
    private var menu: some View {
        VStack(spacing: 0) {
            ForEach(items.indices, id: \.self) { idx in
                button(for: items[idx])
//                if idx != items.indices.last { Divider().background(Color.white.opacity(0.15)) }
            }
        }
        .frame(maxWidth: maxWidth, alignment: .leading)
        .padding(padding)
        .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: cornerRadius))
        .overlay(
            RoundedRectangle(cornerRadius: cornerRadius)
                .strokeBorder(Color.white.opacity(0.08), lineWidth: 0.5)
        )
        .shadow(radius: 20, y: 10)
        .padding()
    }

    // MARK: – single row
    @ViewBuilder
    private func button(for item: PopupMenuItem) -> some View {
        Button(role: item.isDestructive ? .destructive : nil) {
            item.action()
            withAnimation { isPresented = false }
        } label: {
            SwiftUI.Label {
                Text(item.title)
                    .foregroundColor(.white)
                    .fontWeight(item.isDestructive ? .bold : .semibold)
            } icon: {
                Image(systemName: item.icon)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .symbolRenderingMode(.hierarchical)
                    .foregroundStyle(item.tint)
                    .frame(width: 22, height: 22)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.vertical, 8)
        }
        .buttonStyle(.plain)
        .keyboardShortcut(.defaultAction)   // return/space activates focused row
    }
}

// MARK: – Convenience API -----------------------------------------------------

extension View {
    /// Presents a customisable pop-up menu.
    func popupMenu<Label>(
        isPresented: Binding<Bool>,
        @ViewBuilder label: @escaping () -> Label,
        items: [PopupMenuItem]
    ) -> some View where Label: View {
        modifier(PopupMenuModifier(isPresented: isPresented,
                                   items: items,
                                   label: label))
    }

    /// Overload that uses a result-builder for menu items.
    func popupMenu(
        isPresented: Binding<Bool>,
        @PopupMenuBuilder items: () -> [PopupMenuItem]
    ) -> some View {
        modifier(PopupMenuModifier(isPresented: isPresented,
                                   items: items(),
                                   label: { EmptyView() }))
    }
}

/// Result-builder so you can list items inline.
@resultBuilder
struct PopupMenuBuilder {
    static func buildBlock(_ components: PopupMenuItem...) -> [PopupMenuItem] { components }
}

struct ExampleView: View {
    @State private var showMenu = false

    var body: some View {
        VStack {
            Spacer()

            Button(action: { withAnimation { showMenu = true } }) {
                Image(systemName: "ellipsis")
                    .font(.system(size: 20, weight: .bold))
                    .padding()
                    .background(Circle().fill(Color("SecondaryBg")))
            }
            .popupMenu(isPresented: $showMenu) {
                PopupMenuItem(icon: "arrow.right.circle.fill",
                              title: "Start Program", tint: Color("PrimaryColor")) {
                    print("Start")
                }
                PopupMenuItem(icon: "pencil.circle.fill",
                              title: "Edit", tint: Color("PrimaryColor")) {
                    print("Edit")
                }
                PopupMenuItem(icon: "square.and.arrow.up.fill",
                              title: "Manage Access", tint: Color("PrimaryColor")) {
                    print("Share")
                }
                PopupMenuItem(icon: "xmark",
                              title: "Delete", tint: .red,
                              isDestructive: true) {
                    print("Delete")
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color("PrimaryBg"))
    }
}

#Preview {
    ExampleView()
}
