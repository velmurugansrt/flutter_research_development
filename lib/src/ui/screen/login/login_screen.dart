import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_research_development/src/assets/styles/app_images.dart';
import 'package:flutter_research_development/src/assets/styles/app_widget_size.dart';
import 'package:flutter_research_development/src/blocs/login/login_bloc.dart';
import 'package:flutter_research_development/src/ui/navigation/screen_routes.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  LoginBloc _loginBloc;
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loginBloc = BlocProvider.of<LoginBloc>(context);
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(),
    );
  }

  Container _buildBody() {
    return Container(
      padding: const EdgeInsets.only(left: 16, right: 16),
      decoration: BoxDecoration(
        image: AppImages.loginBackground(),
      ),
      child: SizedBox.expand(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            _buildLoginheader(),
            _buildInputSection(),
            _buildButtonSection(),
          ],
        ),
      ),
    );
  }

  Wrap _buildLoginheader() {
    return Wrap(
      direction: Axis.vertical,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: <Widget>[
        Text(
          'Welcome to Login',
          style: Theme.of(context).textTheme.headline6,
        ),
        // Text(
        //   'Welcome to shopping cart',
        //   style: Theme.of(context).accentTextTheme.headline4,
        // ),
      ],
    );
  }

  Wrap _buildInputSection() {
    return Wrap(
      children: <Widget>[
        _buildInpuField(
          'Username',
          TextField(
            controller: _usernameController,
            decoration: InputDecoration(
              hintText: 'Please enter username',
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 16),
          child: _buildInpuField(
            'Password',
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(
                hintText: 'Please enter password',
              ),
            ),
          ),
        ),
      ],
    );
  }

  Wrap _buildInpuField(String label, TextField textField) {
    return Wrap(
      children: <Widget>[
        Text(
          label,
          style: Theme.of(context).accentTextTheme.headline5,
        ),
        Container(
          margin: const EdgeInsets.only(top: 16),
          padding: const EdgeInsets.only(left: 16, right: 16),
          decoration: BoxDecoration(
            color: Theme.of(context).accentColor,
            borderRadius: BorderRadius.circular(8),
          ),
          child: textField,
        ),
      ],
    );
  }

  SizedBox _buildButtonSection() {
    return SizedBox(
      width: double.infinity,
      height: 48,
      child: RaisedButton(
        elevation: 0,
        color: Theme.of(context).primaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: AppWidgetSize.buttonBorderRadius,
        ),
        onPressed: _loginButtonPressed,
        child: Text(
          'Login',
          style: Theme.of(context).textTheme.button,
          // style:  ,
        ),
      ),
    );
  }

  void _loginButtonPressed() {
    final String username = _usernameController.text.trim();
    final String password = _passwordController.text.trim();
    if (username == '') {
      showAlert('Please enter valid username');
    } else if (password == '') {
      showAlert('Please enter valid password');
    } else {

      _loginBloc.add(FetchUserLoginEvent());

      // Navigator.of(context).pushReplacementNamed(ScreenRoutes.HOME_SCREEN);
    }
  }

  void showAlert(String message) {
    showDialog<AlertDialog>(
      context: context,
      barrierDismissible: false, // user must tap button for close dialog!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Shopping cart',
            style: Theme.of(context).textTheme.headline5,
          ),
          content: Container(
            child: Text(
              message ?? '',
              style: Theme.of(context).textTheme.headline3,
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text(
                'Okay',
                style: Theme.of(context).textTheme.headline5,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          ],
        );
      },
    );
  }
}
