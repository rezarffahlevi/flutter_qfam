import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_qfam/src/features/home/bloc/home/home_bloc.dart';
import 'package:flutter_qfam/src/features/home/bloc/home_root/home_root_bloc.dart';
import 'package:flutter_qfam/src/styles/my_colors.dart';
import 'package:flutter_qfam/src/styles/my_font_weight.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class HomeRootScreen extends StatefulWidget {
  static const String routeName = '/home';

  const HomeRootScreen({Key? key}) : super(key: key);

  @override
  _HomeRootScreenState createState() => _HomeRootScreenState();
}

class _HomeRootScreenState extends State<HomeRootScreen> {
  HomeRootBloc bloc = HomeRootBloc();
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  @override
  Widget build(BuildContext context) {
    final dimension = MediaQuery.of(context).size;
    return BlocListener<HomeRootBloc, HomeRootState>(
      listenWhen: (prev, curr) => prev.state != curr.state,
      listener: (context, state) {
        if (state.isLoading) {
          print('ISLOADING TRUE');
        }
      },
      child: WillPopScope(
        onWillPop: null,
        child: BlocConsumer<HomeRootBloc, HomeRootState>(
            bloc: bloc,
            listener: (context, state) {
              // TODO: implement listener
            },
            builder: (context, state) {
              return Scaffold(
                key: null,
                body: bloc.children[state.index],
                bottomNavigationBar: BottomNavigationBar(
                  type: BottomNavigationBarType.fixed,
                  selectedItemColor: MyColors.primary,
                  unselectedItemColor: Colors.grey,
                  currentIndex: state.index,
                  selectedLabelStyle: Theme.of(context)
                      .textTheme
                      .subtitle2
                      ?.copyWith(fontSize: 12.0, fontWeight: MyFontWeight.bold),
                  unselectedLabelStyle: Theme.of(context)
                      .textTheme
                      .subtitle2
                      ?.copyWith(
                          fontSize: 10.0,
                          fontWeight: MyFontWeight.bold,
                          color: MyColors.grey),
                  iconSize: 20,
                  selectedIconTheme: IconThemeData(size: 24),
                  onTap: (index) {
                    bloc.add(HomeRootEventSelectedIndex(index: index));
                  },
                  items: [
                    BottomNavigationBarItem(
                      icon: Icon(Icons.home),
                      label: 'Beranda',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.search),
                      label: 'Edukasi',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.forum),
                      label: 'Forum',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.person),
                      label: 'Profil',
                    ),
                  ],
                ),
              );
            }),
      ),
    );
  }
}
