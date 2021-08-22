abstract class LoginStates {}
class LoginInitialState extends LoginStates{}

class LoginLoadingState extends LoginStates{}

class LoginSucessfulState extends LoginStates{}

class LoginErrorState extends LoginStates{}


class LoginNotSucessfulState extends LoginStates{}
class changeBottomTab extends LoginStates{}

class GetUserSucessSocialStates extends LoginStates{}

class GetUserErrorSocialStates extends LoginStates{}
