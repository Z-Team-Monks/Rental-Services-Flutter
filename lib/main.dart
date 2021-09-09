import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rental/core/presentation/customTheme/appTheme.dart';
import 'package:rental/features/auth/bloc/auth_form_bloc.dart';
import 'package:rental/features/auth/bloc/user_auth/user_auth_bloc.dart';
import 'package:rental/features/auth/repository/repository.dart';
import 'package:rental/features/property/bloc/update_property/update_property_bloc.dart';
import 'package:rental/features/property/data_provider/property_local_data_provider.dart';
import 'package:rental/features/property/data_provider/property_remote_data_provider.dart';
import 'package:rental/features/property/repository/property_repository.dart';
import 'package:rental/features/property/bloc/property_add/property_add_bloc.dart';
import 'package:rental/features/property/screens/add_property/add_property_screen.dart';
import 'package:rental/features/property/screens/property_feed/feed.dart';
import 'package:rental/features/user/bloc/profile_bloc/profile_bloc.dart';
import 'package:rental/features/user/data_providers/user_remote_data_provider.dart';
import 'package:rental/features/user/repository/user_repository.dart';
import 'package:rental/features/user/screens/profile/profile_page.dart';
import 'package:rental/locator.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'features/property/bloc/property_add/property_add_bloc.dart';

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
            // ..add(UpdatePropertyLoadProperty(
            //     productId: "61389e84a6a60a468bce7d11")),
            )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        // initialRoute: AuthPage.pageRoute,
        // onGenerateRoute: RouteGenerator.generateRoute,
        title: 'House Rent',
        theme: CustomTheme.lightTheme,
        darkTheme: CustomTheme.darkTHeme,
        themeMode: ThemeMode.light,
        home: Home(),
      ),
    );
  }
}

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeState();
  }
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;
  final List<Widget> _children = [
    HomeFeed(),
    AddProperty(),
    ProfilePage(),
  ];
  final List<String> _titles = ["Home", "Cases", "Symptoms"];

  // CaseBloc caseBloc = CaseBloc(repo: CaseRepo());

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      drawerScrimColor: Colors.black.withOpacity(0.2),
      // drawerScrimColor: Colors.transparent,
      // drawer: BlurredDrawer(),

      body: _children[_currentIndex],
      bottomNavigationBar: SizedBox(
        height: size.height * 0.068,
        child: BottomNavigationBar(
          iconSize: size.height * 0.024,
          onTap: onTabTapped,
          type: BottomNavigationBarType.shifting,
          // this will be set when a new tab is tapped
          unselectedItemColor: Colors.grey,
          selectedItemColor: Colors.redAccent,
          currentIndex: _currentIndex,
          items: [
            BottomNavigationBarItem(
              icon: new Icon(
                Icons.home,
              ),
              title: new Text(
                '',
                style: TextStyle(fontSize: 14),
              ),
            ),
            BottomNavigationBarItem(
              icon: new Icon(
                Icons.add,
              ),
              title: new Text(
                '',
                style: TextStyle(fontSize: 14),
              ),
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.person),
                title: Text(
                  '',
                  style: TextStyle(fontSize: 14),
                )),
          ],
        ),
      ),
    );
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}
