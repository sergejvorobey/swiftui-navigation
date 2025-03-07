import CustomDump
import SwiftUINavigation
import XCTest

final class AlertTests: XCTestCase {
  func testAlertState() {
    let alert = AlertState(
      title: .init("Alert!"),
      message: .init("Something went wrong..."),
      primaryButton: .destructive(.init("Destroy"), action: .send(true, animation: .default)),
      secondaryButton: .cancel(.init("Cancel"), action: .send(false))
    )
    XCTAssertNoDifference(
      alert,
      AlertState(
        title: .init("Alert!"),
        message: .init("Something went wrong..."),
        primaryButton: .destructive(.init("Destroy"), action: .send(true, animation: .default)),
        secondaryButton: .cancel(.init("Cancel"), action: .send(false))
      )
    )

    var dump = ""
    customDump(alert, to: &dump)
    XCTAssertNoDifference(
      dump,
      """
      AlertState(
        title: "Alert!",
        actions: [
          [0]: ButtonState(
            role: ButtonState.Role.destructive,
            action: ButtonState.Handler.send(
              true,
              animation: Animation.easeInOut
            ),
            label: "Destroy"
          ),
          [1]: ButtonState(
            role: ButtonState.Role.cancel,
            action: ButtonState.Handler.send(false),
            label: "Cancel"
          )
        ],
        message: "Something went wrong..."
      )
      """
    )

    if #available(iOS 13, macOS 12, tvOS 13, watchOS 6, *) {
      dump = ""
      customDump(
        ConfirmationDialogState(
          title: .init("Alert!"),
          message: .init("Something went wrong..."),
          buttons: [
            .destructive(.init("Destroy"), action: .send(true, animation: .default)),
            .cancel(.init("Cancel"), action: .send(false)),
          ]
        ),
        to: &dump
      )
      XCTAssertNoDifference(
        dump,
        """
        ConfirmationDialogState(
          title: "Alert!",
          actions: [
            [0]: ButtonState(
              role: ButtonState.Role.destructive,
              action: ButtonState.Handler.send(
                true,
                animation: Animation.easeInOut
              ),
              label: "Destroy"
            ),
            [1]: ButtonState(
              role: ButtonState.Role.cancel,
              action: ButtonState.Handler.send(false),
              label: "Cancel"
            )
          ],
          message: "Something went wrong..."
        )
        """
      )
    }
  }
}
