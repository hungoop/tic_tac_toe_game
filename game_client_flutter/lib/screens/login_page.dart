
import 'package:country_code_picker/country_code_picker.dart';
import 'package:english_words/english_words.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_client_flutter/blocs/blocs.dart';
import 'package:game_client_flutter/configs/configs.dart';
import 'package:game_client_flutter/language/languages.dart';
import 'package:game_client_flutter/screens/screens.dart';
import 'package:game_client_flutter/storage/storage.dart';
import 'package:game_client_flutter/utils/utils.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}): super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _LoginPage();
  }

}

class _LoginPage extends State<LoginPage> with SingleTickerProviderStateMixin {
  final TextEditingController _telephoneEditingController = TextEditingController();
  final TextEditingController _emailEditingController = TextEditingController();
  final TextEditingController _passEditingController = TextEditingController();

  Color backgroundColor = AppTheme.currentTheme.color;
  final SizedBox spaceHeight = SizedBox(height: 20.0);

  late LoginBloc _loginBloc;

  CountryCode _cCodeDef = CountryCode(
      code: 'VN',
      dialCode: '84'
  );

  late CountryCode? _countryCode;
  late TabController _tabController;

  LOGIN_TYPE _getLoginType(int indTab){
    if(_tabController.index == 1){
      return LOGIN_TYPE.EMAIL_OR_ID;
    } else {
      return LOGIN_TYPE.TELEPHONE_PWD;
    }
  }

  @override
  void initState() {
    super.initState();

    _countryCode = _cCodeDef;

    _loginBloc = BlocProvider.of<LoginBloc>(context);
    _tabController = TabController(length: 2, vsync: this);
    _tabController.index = 1;

    _telephoneEditingController.addListener(() {
      _loginBloc.add(LoginEventIdentificationChanged(
          _telephoneEditingController.text,
          _getLoginType(_tabController.index))
      );
    });

    _emailEditingController.addListener(() {
      _loginBloc.add(LoginEventIdentificationChanged(
          _emailEditingController.text,
          _getLoginType(_tabController.index))
      );
    });

    _passEditingController.addListener(() {
      _loginBloc.add(LoginEventPasswordChanged(
          password: _passEditingController.text,identification: _tabController.index ==1 ? _emailEditingController.text :  _telephoneEditingController.text
          , loginType: _getLoginType(_tabController.index))
      );
    });

    _tabController.addListener(() {
      //////0.By Token 1.By UserName  2.By Telephone 3.By Email
      print('--------loginType: ${_getLoginType(_tabController.index)}----------');
    });

    String userGen = generateWordPairs().take(10).first.first;
    _emailEditingController.text = userGen.toUpperCase();
    _passEditingController.text = userGen;
  }

  @override
  void dispose() {
    _tabController.dispose();

    super.dispose();
  }

  void _onLoginEmailAndPassword(){
    String identify = "";

    if(_getLoginType(_tabController.index) == LOGIN_TYPE.EMAIL_OR_ID){
      identify = _emailEditingController.text;
    }
    else if(_getLoginType(_tabController.index) == LOGIN_TYPE.TELEPHONE_PWD){
      identify = _telephoneEditingController.text;
    }

    UtilOther.hiddenKeyboard(context);
    _loginBloc.add(LoginEventWithEmailAndPasswordPress(
        identify,
        _passEditingController.text,
        _getLoginType(_tabController.index),
        countryCode: _countryCode ?? _cCodeDef
    ));
  }

  void _onOpenRegisterPage(){
    RouteGenerator.pushNamed(ScreenRoutes.REGISTER);
  }

  void _onOpenForgetPasswordPage(){
    RouteGenerator.pushNamed(ScreenRoutes.FORGET);
  }

  @override
  Widget build(BuildContext context) {
    backgroundColor = Theme.of(context).backgroundColor;
    return guiForMobile();
  }

  guiForMobile(){
    return SafeArea(child: Scaffold(
        body: BlocListener<LoginBloc, LoginState>(
            listener: (context, loginState){
              if(loginState is LoginStateFailure){
                _confirmLoginMessage(errorMsg: loginState.getErrorMsg());
              }
            },
            child: BlocBuilder<LoginBloc, LoginState>(
              builder: (context, loginState) {
                bool isValidIdentification = false;
                bool isValidPassword = false;
                bool isLoginButtonEnabled  = false;

                if (loginState is LoginStateLoading){
                  return Center(
                    child: CircularProgressIndicator(),
                  );

                }

                if(loginState is LoginStateSuccess){
                  isValidIdentification = loginState.isValidIdentification;
                  isValidPassword = loginState.isValidPassword;
                  isLoginButtonEnabled = loginState.isLoginButtonEnabled();
                }

                return _showLoginMasterBox(
                    isValidIdentification,
                    isValidPassword,
                    isLoginButtonEnabled
                );
              },
            )
        )

    ));
  }

  _backLoginScreen(){
    _loginBloc.add(LoginEventStarted(isLogout: true));
  }

  _confirmLoginMessage({required String errorMsg}) {
    final baseDialog = AppAlertDialog (
        title: AppLanguage().translator(
            AppLanguage().translator(LanguageKeys.APP_TITLE)
        ),
        content: Text(
            errorMsg
        ),
        yesOnPressed: () {
          if(this.mounted){
            RouteGenerator.maybePop();
            _backLoginScreen();
          }
        },
        noOnPressed: null,
        txtYes: AppLanguage().translator(LanguageKeys.AGREE_TEXT_ALERT),
        txtNo: AppLanguage().translator(LanguageKeys.CANCEL_TEXT_ALERT)
    );

    showDialog(context: context, builder: (BuildContext context) => baseDialog);
  }

  void _onCountryChange(CountryCode? codeSelection) {
    print('New Country selected: $codeSelection');
    _countryCode = codeSelection;
    SharedData().setString(
        Preferences.countryCode,
        codeSelection.toString()
    );
  }

  void _onCountryInit(CountryCode? codeSelection) {
    print("New Country _onCountryInit: " + codeSelection.toString());
    _countryCode = codeSelection;
  }

  ////0.By Token 1.By UserName  2.By Telephone 3.By Email
  _showLoginMasterBox(bool isValidIdentification, bool isValidPassword, bool isLoginButtonEnabled) {
    return Padding(
      padding: EdgeInsets.all(Application.PADDING_ALL),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          AppConnectivity(),
          spaceHeight,
          SizedBox(
            height: MediaQuery.of(context).size.width / 8,
            child: Image.asset(
              "assets/images/logo.png",
              fit: BoxFit.contain,
            ),
          ),
          spaceHeight,
          Container(
            width: MediaQuery.of(context).size.width,
            child: TabBar(
                onTap: (currIndex) {
                  _loginBloc.add(LoginEventPasswordChanged(
                      password: _passEditingController.text,
                      identification: currIndex ==1 ? _emailEditingController.text :  _telephoneEditingController.text,
                      loginType: _getLoginType(_tabController.index)
                  ));

                },
                controller: _tabController,
                unselectedLabelColor: Colors.grey,
                indicatorSize: TabBarIndicatorSize.label,
                indicator: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: Theme.of(context).buttonColor
                ),
                tabs: [
                  Tab(
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          border: Border.all(
                              color: Theme.of(context).buttonColor,
                              width: 1
                          )
                      ),
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(AppLanguage().translator(
                            LanguageKeys.TELEPHONE_TEXT_DESCRIPTTION
                        )),
                      ),
                    ),
                  ),
                  Tab(
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          border: Border.all(
                              color: Theme.of(context).buttonColor,
                              width: 1
                          )
                      ),
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(AppLanguage().translator(
                            LanguageKeys.EMAIL_OR_ID_TEXT_DESCRIPTION
                        )),
                      ),
                    ),
                  ),
                ]),
          ),
          spaceHeight,
          Expanded(
            child: TabBarView(
                controller: _tabController,
                children: [
                  _showLoginBoxWithTelephone(
                      isValidIdentification,
                      isValidPassword,
                      isLoginButtonEnabled
                  ),
                  _showLoginBoxWithEmailOrID(
                      isValidIdentification,
                      isValidPassword,
                      isLoginButtonEnabled
                  ),
                ]
            ),
          ),
        ],
      ),
    );
  }

  _showLoginBoxWithTelephone(
      bool isValidIdentification,
      bool isValidPassword,
      bool isLoginButtonEnabled
  ){
    return Padding(
      padding: EdgeInsets.all(0),
      child: Form(
        child: ListView(
          children: <Widget>[
            Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                AppCountryPicker(
                  onCountryInit: _onCountryInit,
                  onCountryChange: _onCountryChange,
                ),
                Expanded(
                    child: Container(
                      margin: EdgeInsets.only(top: 20),
                      width: double.infinity,
                      child: AppTextInput(
                        maxLines: 1,
                        maxLength: 12,
                        controller: _telephoneEditingController,
                        labelText: AppLanguage().translator(
                            LanguageKeys.TELEPHONE_TEXT_DESCRIPTTION
                        ),
                        hintText: AppLanguage().translator(
                            LanguageKeys.TELEPHONE_TEXT_DESCRIPTTION
                        ),
                        keyboardType: TextInputType.phone,
                        validator: (_){
                          return isValidIdentification ? null : AppLanguage().translator(
                              LanguageKeys.INVALID_TELEPHONE_FORMAT
                          );
                        },
                      ),
                    ),
                ),
              ],
            ),
            spaceHeight,
            AppTextInput(
              maxLines: 1,
              maxLength: 50,
              controller: _passEditingController,
              labelText: AppLanguage().translator(
                  LanguageKeys.PASSWORD_TEXT_DESCRIPTTION
              ),
              hintText: AppLanguage().translator(
                  LanguageKeys.PASSWORD_TEXT_DESCRIPTTION
              ),
              obscureText: true,
              validator: (_){
                return isValidPassword ? null : AppLanguage().translator(
                    LanguageKeys.INVALID_PASSWORD_FORMAT
                );
              },
            ),
            _widgetAllButton(isLoginButtonEnabled)
          ],
        ),
      ),
    );
  }

  _showLoginBoxWithEmailOrID(
      bool isValidIdentification,
      bool isValidPassword,
      bool isLoginButtonEnabled
  ){
    return Padding(
      padding: EdgeInsets.all(0),
      child: Form(
        child: ListView(
          children: <Widget>[
            SizedBox(height: 20.0),
            AppTextInput(
              maxLines: 1,
              maxLength: 50,
              controller: _emailEditingController,
              labelText: AppLanguage().translator(
                  LanguageKeys.EMAIL_OR_ID_TEXT_DESCRIPTION
              ),
              hintText: AppLanguage().translator(
                  LanguageKeys.EMAIL_OR_ID_TEXT_DESCRIPTION
              ),
              keyboardType: TextInputType.emailAddress,
              validator: (_){
                return isValidIdentification ? null : AppLanguage().translator(
                    LanguageKeys.INVALID_EMAIL_OR_ID_FORMAT
                );
              },
            ),
            SizedBox(height: 20.0),
            AppTextInput(
              maxLines: 1,
              maxLength: 50,
              controller: _passEditingController,
              labelText: AppLanguage().translator(
                  LanguageKeys.PASSWORD_TEXT_DESCRIPTTION
              ),
              hintText: AppLanguage().translator(
                  LanguageKeys.PASSWORD_TEXT_DESCRIPTTION
              ),
              obscureText: true,
              validator: (_){
                return isValidPassword ? null : AppLanguage().translator(
                    LanguageKeys.INVALID_PASSWORD_FORMAT
                );
              },
            ),
            _widgetAllButton(isLoginButtonEnabled)
          ],
        ),
      ),
    );
  }

  _widgetAllButton(bool isLoginButtonEnabled){
    return Padding(
      padding: EdgeInsets.symmetric(vertical: Application.PADDING_ALL),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          AppButton(
            AppLanguage().translator(
                LanguageKeys.LOGIN_TEXT_BUTTON
            ),
            onPressed: isLoginButtonEnabled ? _onLoginEmailAndPassword : null,
            type: ButtonType.bigWith,
            loading: _loginBloc.state is LoginStateLoading,
          ),
          /*
          spaceHeight,
          AppButton(
            AppLanguage().translator(
                LanguageKeys.REGISTER_TEXT_BUTTON
            ),
            onPressed: _onOpenRegisterPage,
            type: ButtonType.bigNo,
          ),
          spaceHeight,
          AppButton(
            AppLanguage().translator(
                LanguageKeys.FORGET_PASSWORD_TEXT_BUTTON
            ),
            onPressed: _onOpenForgetPasswordPage,
            type: ButtonType.bigNo,
          ),

           */
        ],
      ),
    );
  }
}
