deeplink_android:
	adb shell 'am start -a android.intent.action.VIEW \
	-c android.intent.category.BROWSABLE \
	-d "jti://jti.app/todo"' \
	com.gnuao.jti
deeplink_ios:
	xcrun simctl openurl booted jti://jti.app/todo