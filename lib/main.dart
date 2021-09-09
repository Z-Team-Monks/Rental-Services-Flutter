import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rental/core/presentation/customTheme/appTheme.dart';
import 'package:rental/features/auth/bloc/auth_form_bloc.dart';
import 'package:rental/features/auth/bloc/user_auth/user_auth_bloc.dart';
import 'package:rental/features/auth/repository/repository.dart';
import 'package:rental/features/auth/screens/auth_screen.dart';
import 'package:rental/features/property/bloc/add_review/add_review_bloc.dart';
import 'package:rental/features/property/bloc/update_property/update_property_bloc.dart';
import 'package:rental/features/property/data_provider/property_local_data_provider.dart';
import 'package:rental/features/property/data_provider/property_remote_data_provider.dart';
import 'package:rental/features/property/repository/property_repository.dart';
import 'package:rental/features/user/bloc/profile_bloc/profile_bloc.dart';
import 'package:rental/features/user/data_providers/user_remote_data_provider.dart';
import 'package:rental/features/user/repository/user_repository.dart';
import 'package:rental/locator.dart';
import 'package:rental/route.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'features/property/bloc/property_add/property_add_bloc.dart';
import 'features/property/data_provider/add_review/review_remote_data_provider.dart';
import 'features/property/repository/add_review/add_review_repository.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setUp();
  runApp(MyApp());
}

_retriveOnboardInfo() async {
  SharedPreferences prefs = getIt<SharedPreferences>();
  final isViewed = prefs.getBool('isViewed');
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  final AuthRepository _authRepository = getIt.get<AuthRepository>();

  @override
  Widget build(BuildContext context) {
    final propertyRepository = new PropertyRepository(
        new PropertyLocalDataProvider(), new PropertyRemoteDataProvider());
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthFormBloc>(
            create: (BuildContext context) =>
                AuthFormBloc(authRepository: _authRepository)),
        BlocProvider<UserAuthBloc>(
            create: (BuildContext context) =>
                UserAuthBloc(authRepository: _authRepository)),

        BlocProvider<ProfileBloc>(
            create: (BuildContext context) => ProfileBloc(
                  userRepository: UserRepository(
                    UserRemoteDataProvider(),
                    // UserLocalDataProvider(),
                  ),
                )..add(ProfileLoad())),
        // BlocProvider<AddReviewFormBloc>(
        //     create: (BuildContext context) => AddReviewFormBloc(
        //           reviewRepository: ReviewRemoteDataProvider(),
        //         )),
        BlocProvider<PropertyAddBloc>(
          create: (BuildContext context) => PropertyAddBloc(
            propertyRepository: PropertyRepository(
              PropertyLocalDataProvider(),
              PropertyRemoteDataProvider(),
            ),
          ),
        ),
        BlocProvider<UpdatePropertyBloc>(
          create: (BuildContext context) =>
              UpdatePropertyBloc(propertyRepository)
                ..add(UpdatePropertyLoadProperty(
                    productId: "61389e84a6a60a468bce7d11")),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: AuthPage.pageRoute,
        onGenerateRoute: RouteGenerator.generateRoute,
        title: 'House Rent',
        theme: CustomTheme.lightTheme,
        darkTheme: CustomTheme.darkTHeme,
        themeMode: ThemeMode.light,
      ),
    );
  }
}
