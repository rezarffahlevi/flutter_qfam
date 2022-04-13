import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_siap_nikah/src/features/home/bloc/home/home_bloc.dart';
import 'package:flutter_siap_nikah/src/features/home/bloc/home_root/home_root_bloc.dart';
import 'package:flutter_siap_nikah/src/styles/my_colors.dart';
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
    return BlocListener<HomeRootBloc, HomeRootState>(
      listenWhen: (prev, curr) => prev.isLoading != curr.isLoading,
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
                bottomNavigationBar: SizedBox(
                  height: 50.0,
                  child: BottomNavigationBar(
                    type: BottomNavigationBarType.fixed,
                    selectedItemColor: MyColors.primary,
                    unselectedItemColor: Colors.grey,
                    currentIndex: state.index,
                    selectedLabelStyle: Theme.of(context).textTheme.subtitle2?.copyWith(fontSize: 12.0),
                    unselectedLabelStyle: Theme.of(context).textTheme.subtitle2?.copyWith(fontSize: 10.0),
                    selectedIconTheme: Theme.of(context).iconTheme.copyWith(size: 20.0, color: MyColors.primary),
                    unselectedIconTheme: Theme.of(context).iconTheme.copyWith(size: 16.0),
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
                        label: 'Cari',
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
                ),
              );
            }),
      ),
    );
  }
}
