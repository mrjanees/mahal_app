import 'package:go_router/go_router.dart';
import 'package:mahal_app/views/pages/dash_board.dart';
import 'package:mahal_app/views/pages/house_details.dart';
import 'package:mahal_app/views/pages/login_page.dart';
import 'package:mahal_app/views/pages/todays_collection.dart';
import 'package:mahal_app/views/pages/prinitng.dart';

import 'package:mahal_app/views/pages/subscription.dart';

final GoRouter router = GoRouter(
  initialLocation: '/login',
  routes: [
    GoRoute(
      path: '/login',
      builder: (context, state) => LoginPage(),
    ),
    GoRoute(
      path: '/home',
      builder: (context, state) => const DashBoard(),
    ),
    GoRoute(
      path: '/subscription',
      builder: (context, state) => Subscription(),
    ),
    GoRoute(
      path: '/houseDetails',
      builder: (context, state) => HouseDetails(),
    ),
    // GoRoute(
    //   path: '/monthlyCollection',
    //   builder: (context, state) => const (),
    // ),
    // GoRoute(
    //   path: "/printer",
    //   builder: (context, state) => const SubscriptionPrinting(),
    // )
  ],
);
