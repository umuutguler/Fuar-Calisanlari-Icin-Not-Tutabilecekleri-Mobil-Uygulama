import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_custom_tabs/flutter_custom_tabs.dart';

class Chrometab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Custom Tabs Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        brightness: Brightness.light,
      ),
      darkTheme: ThemeData(
        primarySwatch: Colors.blue,
        brightness: Brightness.dark,
      ),
      home: Builder(
        builder: (_context) => Scaffold(
          appBar: AppBar(
            title: const Text('Flutter Custom Tabs Example'),
            systemOverlayStyle: SystemUiOverlayStyle.dark,
          ),
          body: Center(
            child: TextButton(
              onPressed: () => _launchURL(_context),
              child: Text(
                'Show Flutter homepage',
                style: TextStyle(fontSize: 17),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _launchURL(BuildContext context) async {
    final theme = Theme.of(context);
    try {
      await launch(
        'http://lb.edu.ciloglunet.com/#/login',
        customTabsOption: CustomTabsOption(
          toolbarColor: theme.primaryColor,
          enableDefaultShare: true,
          enableUrlBarHiding: true,
          showPageTitle: true,
          animation: CustomTabsSystemAnimation.slideIn(),
          extraCustomTabs: const <String>[
            // ref. https://play.google.com/store/apps/details?id=org.mozilla.firefox
            'org.mozilla.firefox',
            // ref. https://play.google.com/store/apps/details?id=com.microsoft.emmx
            'com.microsoft.emmx',
          ],
        ),
        safariVCOption: SafariViewControllerOption(
          preferredBarTintColor: theme.primaryColor,
          preferredControlTintColor: Colors.white,
          barCollapsingEnabled: true,
          entersReaderIfAvailable: false,
          dismissButtonStyle: SafariViewControllerDismissButtonStyle.close,
        ),
      );
    } catch (e) {
      // An exception is thrown if browser app is not installed on Android device.
      debugPrint(e.toString());
    }
  }
}
