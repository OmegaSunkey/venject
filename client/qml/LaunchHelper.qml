pragma Singleton
import QtQuick

Item {
	signal handleLaunchMessage(path: string, launchArgs: string, entryPointPath: string)

	function handleLaunch(path, launchArgs, entryPointPath) {
		handleLaunchMessage(path, launchArgs, entryPointPath)
	}
}
