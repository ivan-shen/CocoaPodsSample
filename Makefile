clean:
	-rm -rf build/*

test:
	GHUNIT_CLI=1 xcodebuild ONLY_ACTIVE_ARCH=NO -workspace CocoaPodsSample.xcworkspace -scheme Tests -configuration Debug -sdk iphonesimulator build
