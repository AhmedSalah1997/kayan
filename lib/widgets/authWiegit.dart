import 'package:flutter/material.dart';

class authMainButton extends StatelessWidget {
  final String mainButtonLabel;
  final Function() onPress ;
  const authMainButton({
    Key? key,
    required this.onPress , required this.mainButtonLabel
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 30.0),
      child: Material(
        color: Colors.purple,
        borderRadius: BorderRadius.circular(25),
        child: MaterialButton(
          minWidth: double.infinity,
          onPressed: onPress,
          child:  Text(
            mainButtonLabel,
            style:const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}

class HaveAccount extends StatelessWidget {
  final String haveAccount;
  final String actionLAbel;
  final Function() onPress;
  const HaveAccount({
    Key? key,
    required this.haveAccount , required this.actionLAbel , required this.onPress
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(
          haveAccount,
          style:const TextStyle(
              fontSize: 16, fontStyle: FontStyle.italic),
        ),
        TextButton(
          onPressed: onPress,
          child:  Text(
            actionLAbel,
            style: const TextStyle(
                color: Colors.purple,
                fontWeight: FontWeight.bold,
                fontSize: 20),
          ),
        ),
      ],
    );
  }
}

class HeaderLabel extends StatelessWidget {
  final String headerLabel;

  const HeaderLabel({Key? key, required this.headerLabel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            headerLabel,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 35,
            ),
          ),
          IconButton(
            onPressed: () {
              Navigator.pushReplacementNamed(context, '/welcome_screen');
            },
            icon: const Icon(
              Icons.home,
              color: Colors.purpleAccent,
              size: 40,
            ),
          ),
        ],
      ),
    );
  }
}

var textFormDecoration = InputDecoration(
  labelText: 'Full Name',
  hintText: ' Enter your Full name',
  border: OutlineInputBorder(
    borderRadius: BorderRadius.circular(25),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: const BorderSide(color: Colors.purple, width: 1),
    borderRadius: BorderRadius.circular(25),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: const BorderSide(color: Colors.deepOrangeAccent, width: 2),
    borderRadius: BorderRadius.circular(25),
  ),
);

extension EmailVa on String {

  bool isValidEmail() {
    return RegExp(r'^([a-zA-Z0-9]+)([\-\_\.]*)([a-zA-Z0-9]+)([\-\_\.]*)([a-zA-Z0-9]*)(@)([a-zA-Z0-9]{2,})([\.][a-zA-Z]{2,3})$')
        .hasMatch(this);
  }
}

