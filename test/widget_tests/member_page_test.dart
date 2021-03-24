import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

// Local files imports.
import 'package:talawa/controllers/auth_controller.dart';
import 'package:talawa/controllers/org_controller.dart';
import 'package:talawa/services/preferences.dart';
import 'package:talawa/utils/GQLClient.dart';
import 'package:talawa/views/pages/members/members.dart';



Widget createMemberPageScreen() => MultiProvider(
  providers: [
    ChangeNotifierProvider<GraphQLConfiguration>(
      create: (_) => GraphQLConfiguration(),
    ),
    ChangeNotifierProvider<OrgController>(
      create: (_) => OrgController(),
    ),
    ChangeNotifierProvider<AuthController>(
      create: (_) => AuthController(),
    ),
    ChangeNotifierProvider<Preferences>(
      create: (_) => Preferences(),
    ),
  ],
  child: MaterialApp(
    home: Organizations(),
  ),
);

void main() {
  final TestWidgetsFlutterBinding binding = TestWidgetsFlutterBinding
      .ensureInitialized();
  // Function for ignoring overflow errors.
  Function onErrorIgnoreOverflowErrors = (FlutterErrorDetails details, {
    bool forceReport = false,
  }) {
    assert(details != null);
    assert(details.exception != null);

    bool ifIsOverflowError = false;

    // Detect overflow error.
    var exception = details.exception;
    if (exception is FlutterError)
      ifIsOverflowError = !exception.diagnostics.any(
            (e) =>
            e.value.toString().startsWith(
              "A RenderFlex overflowed by",
            ),
      );

    // Ignore if is overflow error.
    if (ifIsOverflowError) {
      print("Over flow error");
    }

    // Throw other errors.
    else {
      FlutterError.dumpErrorToConsole(
        details,
        forceReport: forceReport,
      );
    }
  };
  group("member Page Tests", ()
  {
    testWidgets("Testing if member page shows up", (tester) async {
      await tester.pumpWidget(createMemberPageScreen());

      /// Verify if [member page] shows up.
    });

    testWidgets("Testing overflow of Member page in a mobile screen",
            (tester) async {
          binding.window.physicalSizeTestValue = Size(440, 800);
          binding.window.devicePixelRatioTestValue = 1.0;

          await tester.pumpWidget(createMemberPageScreen());

          /// Verify if [memberpage] shows up.
        });
    testWidgets("Testing overflow of Member Page in a tablet screen",
            (tester) async {
          binding.window.physicalSizeTestValue = Size(1024, 768);
          binding.window.devicePixelRatioTestValue = 1.0;

          await tester.pumpWidget(createMemberPageScreen());

          /// Verify if [LoginPage] shows up.
        });
  });
}
