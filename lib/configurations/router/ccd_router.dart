import 'package:auto_route/annotations.dart';
import 'package:ccd2023/features/app/app.dart';
import 'package:ccd2023/features/auth/presentation/pages/activate_email_page.dart';
import 'package:ccd2023/features/auth/presentation/pages/forgot_pass_page.dart';
import 'package:ccd2023/features/home/pages/home_page.dart';
import 'package:ccd2023/features/auth/auth.dart';

export 'package:auto_route/auto_route.dart';
export 'ccd_router.gr.dart';

@AdaptiveAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: <AutoRoute>[
    AutoRoute(page: HomePage, initial: true, path: "/home"),
    AutoRoute(page: LoginPage, path: "/login"),
    AutoRoute(page: SignUpPage, path: "/signup"),
    AutoRoute(page: ActivateEmailPage, path: "/activate-account"),
    AutoRoute(page: ForgotPassPage, path: "/forgot-pass"),
    AutoRoute(path: '*', page: UnknownPage),
  ],
)
class $AppRouter {}
