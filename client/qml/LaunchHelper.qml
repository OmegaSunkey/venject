pragma Singleton
import QtQuick

Item {
	signal handleLaunchMessage(
		path: string, 
		launchArgs: string, 
		entryPointPath: string,
		userDataPath: string
	)

	function handleLaunch(path, launchArgs, entryPointPath, userDataPath) {
		handleLaunchMessage(path, launchArgs, entryPointPath, userDataPath)
	}
}
