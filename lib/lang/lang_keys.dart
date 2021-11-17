part of 'translation_service.dart';

abstract class Lang {
  /// 公共
  static const sure = "sure";
  static const edit = "edit";
  static const cancel = "cancel";
  static const next = 'next';

  /// 默认页面
  static const indexTitle = "indexTitle";
  static const indexGoRegister = 'indexGoRegister';
  static const indexHint = 'indexHint';
  static const indexGoLogin = 'indexGoLogin';

  /// 输入框
  static const inputPassword = 'inputPassword';
  static const inputPhone = 'inputPhone';
  static const inputEmail = 'inputEmail';
  static const inputCount = 'inputCount';
  static const inputSearch = 'inputSearch';

  /// 登陆页面
  static const loginTitle = "loginTitle";
  static const loginForget = 'loginForget';
  static const loginButton = 'loginButton';

  /// 注册页面
  static const registerTitle = 'registerTitle';
  static const registerPhone = 'registerPhone';
  static const registerEmail = 'registerEmail';
  static const registerAgreen_1 = 'registerAgreen_1';
  static const registerAgreen_2 = 'registerAgreen_2';
  static const registerService = 'registerService';
  static const registerPrivacy = 'registerPrivacy';
  static const registerVerifyPhone = 'registerVerifyPhone';
  static const registerVerifyEmail = 'registerVerifyEmail';
  static const registerDialogPhone_1 = 'registerDialogPhone_1';
  static const registerDialogPhone_2 = 'registerDialogPhone_2';
  static const registerDialogEmail_1 = 'registerDialogEmail_1';
  static const registerDialogEmail_2 = 'registerDialogEmail_2';
  static const registerAllready = 'registerAllready';

  /// 验证码
  static const codeTile = 'codeTile';
  static const codeSendTile = 'codeSendTile';
  static const codeResend = 'codeResend';
  static const codeMsg = 'codeMsg';
  static const codeSussful = 'codeSussful';

  /// 设置页面
  static const setTitle = 'setTitle';
  static const setLang = 'setLang';
  static const setLangValueCN = 'setLangValueCN';
  static const setLangValueEN = 'setLangValueEN';

  /// 语言设置
  static const langTitle = 'langTitle';
  static const langCN = 'langCN';
  static const langEN = 'langEN';
  static const langMsg = 'langMsg';

  /// 设置密码
  static const passwordTitle = 'paddwordTitle';
  static const passwordSecondTitle = 'paddwordSecondTitle';
  static const passwordThirdTitle = 'passwordThirdTitle';

  /// 区号选择
  static const codeTitle = 'codeTitle';
}
