import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:login/bloc/dashboarduser/dashboard_user_bloc.dart';
import 'package:login/injector/injector.dart';
import 'package:login/model/user/user.dart';
import 'package:login/storage/sharedpreferences/shared_preferences_manager.dart';
import 'package:login/widget/widget_card_loading.dart';

class DashboardUserScreen extends StatefulWidget {
  @override
  _DashboardUserScreenState createState() => _DashboardUserScreenState();
}

class _DashboardUserScreenState extends State<DashboardUserScreen> {
  final DashboardUserBloc _dashboardUserBloc = DashboardUserBloc();
  @override
  void initState() {
    _dashboardUserBloc.add(DashboardUserEvent());
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Dashboard"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              _dashboardUserBloc.add(DashboardUserEvent());
            },
          ),
          IconButton(
            icon: Icon(FontAwesomeIcons.signOutAlt),
            onPressed: () {
              locator<SharedPreferencesManager>().clearAll();
              Navigator.pushNamedAndRemoveUntil(
                  context, '/login_screen', (r) => false);
            },
          ),
        ],
      ),
      body: BlocProvider<DashboardUserBloc>(
        create: (context) => _dashboardUserBloc,
        child: BlocListener<DashboardUserBloc, DashboardUserState>(
          listener: (context, state) {
            if (state is DashboardUserInitial) {
              Scaffold.of(context).showSnackBar(SnackBar(
                content: Text(state.error),
              ));
            }
          },
          child: BlocBuilder<DashboardUserBloc, DashboardUserState>(
            builder: (context, state) {
              if (state is DashboardUserLoading) {
                return WidgetCardLoading();
              } else if (state is DashboardUserSuccess) {
                ItemUser user = state.user;

                return ListView.separated(
                  itemBuilder: (context, index) {
                    ItemUser itemUser = user;

                    return ListTile(
                      // ignore: deprecated_member_use
                      title: Text(
                        itemUser.fullname,
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return Divider();
                  },
                  itemCount: 1,
                );
              } else {
                return Container();
              }
            },
          ),
        ),
      ),
    );
  }
}
