
class Validation{

  Validation();


  String emailValidator(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value)) {
      return 'Email format is invalid';
    } else {
      return null;
    }
  }

  String nameValidator(String value){
    String value1=value.trimRight();
    if(value.length > 3){
      Pattern letter=r'[a-zA-Z]{3}$';
      Pattern digit="0-9";
      Pattern special="(?=.*?[!@#\$&*~])";
      Pattern pattern=r'[!@#<>?":_`~;[\]\\|=+)(*&^%\s-.,/%]$';
      //   Pattern pattern= r'^(?=.*?[a-zA-Z]).{5,}[^0-9](?=.*?[^!@#\$&*~.])';
      //Alternative to the above pattern is to dissallow /s which matches the whitespace character


      RegExp regex=new RegExp(pattern);
      if(value1.isEmpty){
        return 'Please Enter full names';
      }
      else{
        if(regex.hasMatch(value1)){
          return 'Full names must be longer than 3 characters \n  with no digits or special characters';
        }
        else{
          return null;
        }
      }


    }
    else{
      return 'Full names must be longer than 3 characters';
    }

  }
  String pwdValidator(String value) {
    /*  if (value.length < 8) {
      return 'Password must be longer than 8 characters';
    } else {
      return null;
    }*/
    if(value.length > 8){
      Pattern letter='r[a-zA-z]{5,}';
      Pattern digit="0-9";
      Pattern special="(?=.*?[!@#\$&*~,.\" ])";
      Pattern special1='[\W]';
      Pattern pattern= r'(?=.*?[a-zA-z]).{5,}(?=.*?[0-9])(?=.*?[!@#\$&*~.])';
      //  Pattern pattern1= r'(?:(?=.*?[a-zA-z]).{5,}(?=.*?[0-9])(?=.*?[!@#\$&*~.])| (?=.*?[0-9])(?=.*?[!@#\$&*~.])(?=.*?[a-zA-z]).{5,})$';
      Pattern pattern1=r'^(?:(?=.*[a-zA-z]).{5,}|(?=.*[\d\W])|(?=.*\W])(?=.*\d)(?:(?=.*[a-zA-z]).{5,}(?=.*[\d])(?=.*[\W])|(?=.*\W)(?=.*\d)(?=.*[a-zA-z]).{5,})|(?=.*\W)(?=.*[a-zA-z]).{5,}(?=.*\d))$';

//(?=.*[\d\W])

      RegExp regSpecial=new RegExp(special);
      RegExp regex=new RegExp(pattern1);
      if(value.isEmpty){
        return 'Please Enter password';
      }
      else{
        if(!regex.hasMatch(value)){
          return 'Invalid password.Password must include a symbol or a number and have atleast 5 characters';
        }
        else{
          return null;
        }
      }


    }
    else{
      return 'password must be longer than 8 characters';
    }
  }



  String phoneValidator(String value){
    String new_value;
    /* if(value.length < 10){
      return "Please enter a valid phone number";
    }
    else{
      if(( value.startsWith("07")) && value.length==10){
        }
      else if((value.startsWith("+254")) && value.length==13){

      }
      else{
        return "Invalid phone number format";
      }
    }*/

    // String pattern=r'(^(?:[+0]7)?[0-9]{10,13}$)';
    //  |(^(?:[+]2547)?[0-9]{10,13}$)
    //  Pattern pattern=r'(^(?:[+0]7)?[0-9]{10,13}$)';
    // Pattern pattern=r'(^(?:[0]7)?[0-9]{10,13}$)';
    //  Pattern pattern='^(0|+[0-9]{1,3})?([7-9][0-9]{9,15})';
    Pattern pattern=r'^[0-9]+$';

    if(( value.startsWith("07")) && value.length==10){
      new_value=value.substring(2,10);

    }
    else if((value.startsWith("+254")) && value.length==13){
      new_value=value.substring(4,13);
    }

    else{
      return 'Please enter a valid phone number';
    }

    RegExp regExp=new RegExp(pattern);
    if(value.length==0){
      return 'Mobile number is empty';
    }
    else if(!regExp.hasMatch(new_value)){
      return 'please enter valid mobile number';
    }

    return null;

  }


  String nationalIdNumber(String value){
    Pattern pattern=r'^[0-9]+$';


    RegExp regExp=new RegExp(pattern);
    if(value.length==0){
      return 'National ID number is empty';
    }
    else if(!regExp.hasMatch(value)){
      return 'please enter valid national ID number';
    }

    return null;
  }
  String bankAccountValidator(String value){
    if(value.length > 7){
      Pattern pattern=r'^(?=.*?[0-9])';

      RegExp regex=new RegExp(pattern);

      if(value.isEmpty){
        return 'Please enter bank account';
      }

      else if(!regex.hasMatch(value)){
        return 'Enter valid bank account';
      }

      else{
        return null;
      }
    }

    else{
      return 'Account Number must be atleast 8 characters';
    }
  }


  String businessNoValidator(String value){
    if(value.length > 5){
      // Pattern pattern=r'^(?=.*?[0-9])*$';
      Pattern pattern=r'^(?=.*?[0-9])';

      RegExp regex=new RegExp(pattern);

      if(value.isEmpty){
        return 'Please enter business number';
      }

      else if(!regex.hasMatch(value)){
        return 'Enter valid business number';
      }

      else{
        return null;
      }
    }

    else{
      return 'Business Number must be atleast 6 characters';
    }
  }

  String checkDate(String value){
    if(value.isEmpty){
      return 'Select appropriate date';
    }
    return null;
  }

  String checkTime(String value){
    if(value.isEmpty){
      return 'Select appropriate time';
    }
    return null;
  }

  String empty_field_validator(String value){
    String new_value=value.trimRight();
    if(new_value.length < 1){
      return "Please enter password";
    }
    else{
      return null;
    }
  }

}