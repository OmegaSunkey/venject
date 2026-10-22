import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Item {
	id: root
	Layout.fillWidth: true
	height: 55

	required property var selectedItem
	property bool showEditButton: false
	signal editRequested

	Rectangle {
		anchors.fill: parent
		color: sysPalette.button
	}

	RowLayout {
		anchors.fill: parent
		anchors.margins: 12
		spacing: 12

		RowLayout {
			spacing: 10

			Image {
				Layout.alignment: Qt.AlignVCenter
				Layout.preferredWidth: 24
				Layout.preferredHeight: 24
				sourceSize: Qt.size(24, 24)
				source: {
					const branch = selectedItem && selectedItem.branch ? selectedItem.branch.toLowerCase(
																			 ) : ""
					if (branch.includes("canary"))
						return "qrc:/VencordLauncher/resources/canary.svg"
					if (branch.includes("development") || branch.includes("ptb"))
						return "qrc:/VencordLauncher/resources/development.svg"
					return "qrc:/VencordLauncher/resources/stable.svg"
				}
				fillMode: Image.PreserveAspectFit
			}

			ColumnLayout {
				Layout.fillWidth: true
				Layout.alignment: Qt.AlignVCenter
				spacing: 2

				Label {
					Layout.fillWidth: true
					text: selectedItem ? (selectedItem.branch + (selectedItem.isFlatpak ? " (Flatpak)" :
																						  "")) : qsTr("No installation selected")
					font.pixelSize: 12
					font.bold: true
					color: sysPalette.text
					elide: Text.ElideRight
				}

				Label {
					Layout.fillWidth: true
					visible: selectedItem !== null
					text: selectedItem ? selectedItem.id : ""
					font.pixelSize: 11
					color: sysPalette.placeholderText
					elide: Text.ElideRight
				}
			}
		}

		Item {
			Layout.fillWidth: true
		}

		Button {
			text: qsTr("View Folder")
			icon.name: "find-location"
			icon.source: "qrc:/VencordLauncher/resources/glyphs/folder-open.svg"
			enabled: root.selectedItem !== null
			onClicked: {
				if (root.selectedItem) {
					if (Qt.platform.os == "windows") {
						Qt.openUrlExternally("file:///" + selectedItem.id)
					} else {
						Qt.openUrlExternally("file://" + selectedItem.id)
					}
				}
			}
		}

		Button {
			text: qsTr("Edit")
			icon.name: "edit-paste"
			icon.source: "qrc:/VencordLauncher/resources/glyphs/edit.svg"
			visible: root.showEditButton
			enabled: root.selectedItem !== null
			onClicked: root.editRequested()
		}

		Button {
			text: qsTr("Launch")
			icon.name: "media-playback-start"
			icon.source: "qrc:/VencordLauncher/resources/glyphs/play.svg"
			enabled: root.selectedItem !== null
			onClicked: {
				if (root.selectedItem) {
					LaunchHelper.handleLaunch(root.selectedItem.path, SettingsHelper.settings.launchArgs,
											  SettingsHelper.settings.entryPoint)
				}
			}
		}
	}
}
