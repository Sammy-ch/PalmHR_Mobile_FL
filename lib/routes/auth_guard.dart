import 'package:PALMHR_MOBILE/main.dart';
import 'package:PALMHR_MOBILE/routes/app_router.gr.dart';
import 'package:auto_route/auto_route.dart';


class AuthGuard extends AutoRouteGuard {

  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    // the navigation is paused until resolver.next() is called with either
    // true to resume/continue navigation or false to abort navigation

    var authenticated = false;
    final session = supabase.auth.currentSession;

    if (session!= null) {
      authenticated = true;
    }
   
    if(authenticated) {
      // if user is authenticated we continue
      resolver.next(true);
    } else {
        // we redirect the user to our login page
        // tip: use resolver.redirect to have the redirected route
        // automatically removed from the stack when the resolver is completed
        resolver.redirect(
          const LoginRoute()
        );
    }
  }
}