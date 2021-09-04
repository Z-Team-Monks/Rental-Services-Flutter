import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rental/core/presentation/customTheme/appTheme.dart';
import 'package:rental/features/property/bloc/add_review/add_review_bloc.dart';
import 'package:rental/features/property/data_provider/add_review/review_remote_data_provider.dart';
import 'package:rental/features/property/repository/add_review/add_review_repository.dart';
import 'package:rental/features/property/screens/add_review/add_review_popup.dart';
import 'package:rental/features/property/screens/add_property/add_property_screen.dart';
// import 'package:rental/features/property/screens/review_property/add_review_popup.dart';
import 'package:rental/features/user/bloc/profile_bloc/profile_bloc.dart';
import 'package:rental/features/user/data_providers/user_local_data_provider.dart';
import 'package:rental/features/user/data_providers/user_remote_data_provider.dart';
import 'package:rental/features/user/repository/user_repository.dart';
import 'package:rental/locator.dart';
import 'package:rental/features/user/data_providers/user_local_data_provider.dart';
import 'package:rental/features/user/data_providers/user_remote_data_provider.dart';
import 'package:rental/features/user/repository/user_repository.dart';
import 'package:rental/route.dart';
import 'package:rental/features/property/screens/property_detail/property_detail_screen.dart';
import 'package:rental/features/onBoard/screens/splash_screen.dart';

void main() {
  setUp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      //https://pub.dev/documentation/flutter_bloc/latest/flutter_bloc/MultiBlocProvider-class.html
      providers: [
        BlocProvider<ProfileBloc>(
            create: (BuildContext context) => ProfileBloc(
                  userRepository: UserRepository(
                    UserRemoteDataProvider(),
                    // UserLocalDataProvider(),
                  ),
                )..add(ProfileLoad())),
        BlocProvider<AddReviewFormBloc>(
            create: (BuildContext context) => AddReviewFormBloc(
                  reviewRepository: ReviewRepository(
                    ReviewRemoteDataProvider(),
                  ),
                )),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        // initialRoute: AddReviewPopup.pageRoute,
        onGenerateRoute: RouteGenerator.generateRoute,
        title: 'House Rent',
        theme: CustomTheme.lightTheme,
        darkTheme: CustomTheme.darkTHeme,
        themeMode: ThemeMode.light,
      ),
    );
  }
}
