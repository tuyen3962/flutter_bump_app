// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'app_route.dart';

abstract class _$AppRouter extends RootStackRouter {
  // ignore: unused_element
  _$AppRouter({super.navigatorKey});

  @override
  final Map<String, PageFactory> pagesMap = {
    CampaignDetailsRoute.name: (routeData) {
      final args = routeData.argsAs<CampaignDetailsRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: CampaignDetailsPage(
          key: args.key,
          parameter: args.parameter,
        ),
      );
    },
    CreateHighlightRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const CreateHighlightPage(),
      );
    },
    DashboardRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const DashboardPage(),
      );
    },
    DiscoverDetailRoute.name: (routeData) {
      final args = routeData.argsAs<DiscoverDetailRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: DiscoverDetailPage(
          key: args.key,
          parameter: args.parameter,
        ),
      );
    },
    HomeRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const HomePage(),
      );
    },
    LaunchSponsorshipRoute.name: (routeData) {
      final args = routeData.argsAs<LaunchSponsorshipRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: LaunchSponsorshipPage(
          key: args.key,
          parameter: args.parameter,
        ),
      );
    },
    ProfileRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const ProfilePage(),
      );
    },
    SignInRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const SignInPage(),
      );
    },
    SplashRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const SplashPage(),
      );
    },
    SponsorHubRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const SponsorHubPage(),
      );
    },
    UpdateProfileRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const UpdateProfilePage(),
      );
    },
    WalletRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const WalletPage(),
      );
    },
  };
}

/// generated route for
/// [CampaignDetailsPage]
class CampaignDetailsRoute extends PageRouteInfo<CampaignDetailsRouteArgs> {
  CampaignDetailsRoute({
    Key? key,
    required CampaignDetailsParameter parameter,
    List<PageRouteInfo>? children,
  }) : super(
          CampaignDetailsRoute.name,
          args: CampaignDetailsRouteArgs(
            key: key,
            parameter: parameter,
          ),
          initialChildren: children,
        );

  static const String name = 'CampaignDetailsRoute';

  static const PageInfo<CampaignDetailsRouteArgs> page =
      PageInfo<CampaignDetailsRouteArgs>(name);
}

class CampaignDetailsRouteArgs {
  const CampaignDetailsRouteArgs({
    this.key,
    required this.parameter,
  });

  final Key? key;

  final CampaignDetailsParameter parameter;

  @override
  String toString() {
    return 'CampaignDetailsRouteArgs{key: $key, parameter: $parameter}';
  }
}

/// generated route for
/// [CreateHighlightPage]
class CreateHighlightRoute extends PageRouteInfo<void> {
  const CreateHighlightRoute({List<PageRouteInfo>? children})
      : super(
          CreateHighlightRoute.name,
          initialChildren: children,
        );

  static const String name = 'CreateHighlightRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [DashboardPage]
class DashboardRoute extends PageRouteInfo<void> {
  const DashboardRoute({List<PageRouteInfo>? children})
      : super(
          DashboardRoute.name,
          initialChildren: children,
        );

  static const String name = 'DashboardRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [DiscoverDetailPage]
class DiscoverDetailRoute extends PageRouteInfo<DiscoverDetailRouteArgs> {
  DiscoverDetailRoute({
    Key? key,
    required DiscoverDetailParameter parameter,
    List<PageRouteInfo>? children,
  }) : super(
          DiscoverDetailRoute.name,
          args: DiscoverDetailRouteArgs(
            key: key,
            parameter: parameter,
          ),
          initialChildren: children,
        );

  static const String name = 'DiscoverDetailRoute';

  static const PageInfo<DiscoverDetailRouteArgs> page =
      PageInfo<DiscoverDetailRouteArgs>(name);
}

class DiscoverDetailRouteArgs {
  const DiscoverDetailRouteArgs({
    this.key,
    required this.parameter,
  });

  final Key? key;

  final DiscoverDetailParameter parameter;

  @override
  String toString() {
    return 'DiscoverDetailRouteArgs{key: $key, parameter: $parameter}';
  }
}

/// generated route for
/// [HomePage]
class HomeRoute extends PageRouteInfo<void> {
  const HomeRoute({List<PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [LaunchSponsorshipPage]
class LaunchSponsorshipRoute extends PageRouteInfo<LaunchSponsorshipRouteArgs> {
  LaunchSponsorshipRoute({
    Key? key,
    required LaunchSponsorshipParameter parameter,
    List<PageRouteInfo>? children,
  }) : super(
          LaunchSponsorshipRoute.name,
          args: LaunchSponsorshipRouteArgs(
            key: key,
            parameter: parameter,
          ),
          initialChildren: children,
        );

  static const String name = 'LaunchSponsorshipRoute';

  static const PageInfo<LaunchSponsorshipRouteArgs> page =
      PageInfo<LaunchSponsorshipRouteArgs>(name);
}

class LaunchSponsorshipRouteArgs {
  const LaunchSponsorshipRouteArgs({
    this.key,
    required this.parameter,
  });

  final Key? key;

  final LaunchSponsorshipParameter parameter;

  @override
  String toString() {
    return 'LaunchSponsorshipRouteArgs{key: $key, parameter: $parameter}';
  }
}

/// generated route for
/// [ProfilePage]
class ProfileRoute extends PageRouteInfo<void> {
  const ProfileRoute({List<PageRouteInfo>? children})
      : super(
          ProfileRoute.name,
          initialChildren: children,
        );

  static const String name = 'ProfileRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [SignInPage]
class SignInRoute extends PageRouteInfo<void> {
  const SignInRoute({List<PageRouteInfo>? children})
      : super(
          SignInRoute.name,
          initialChildren: children,
        );

  static const String name = 'SignInRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [SplashPage]
class SplashRoute extends PageRouteInfo<void> {
  const SplashRoute({List<PageRouteInfo>? children})
      : super(
          SplashRoute.name,
          initialChildren: children,
        );

  static const String name = 'SplashRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [SponsorHubPage]
class SponsorHubRoute extends PageRouteInfo<void> {
  const SponsorHubRoute({List<PageRouteInfo>? children})
      : super(
          SponsorHubRoute.name,
          initialChildren: children,
        );

  static const String name = 'SponsorHubRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [UpdateProfilePage]
class UpdateProfileRoute extends PageRouteInfo<void> {
  const UpdateProfileRoute({List<PageRouteInfo>? children})
      : super(
          UpdateProfileRoute.name,
          initialChildren: children,
        );

  static const String name = 'UpdateProfileRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [WalletPage]
class WalletRoute extends PageRouteInfo<void> {
  const WalletRoute({List<PageRouteInfo>? children})
      : super(
          WalletRoute.name,
          initialChildren: children,
        );

  static const String name = 'WalletRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}
