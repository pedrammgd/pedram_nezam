import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller$;
  final String hintText$;
  final Icon prefixIcon$;
  final Function validator$;
  final TextInputType keyboardType$;
  final EdgeInsetsGeometry contentPadding$;
  final IconButton suffixIcon$;
  final bool obscureText$;
  final int maxLength$;

  CustomTextField({this.controller$, this.hintText$, this.prefixIcon$ ,this.validator$ ,this.keyboardType$ , this.contentPadding$ , this.suffixIcon$, this.obscureText$ =false
  ,this.maxLength$
  });
  @override
  Widget build(BuildContext context) {
    return Container(

      padding: EdgeInsets.symmetric(vertical: 5),
      child: TextFormField(
        onTap: (){
        FocusScope.of(context).unfocus();
        },

        autovalidateMode:AutovalidateMode.onUserInteraction ,
        keyboardType: keyboardType$,
        validator:validator$ ,
        controller:controller$,
        obscureText:obscureText$ ,
        maxLength: maxLength$,
        decoration: InputDecoration(
          contentPadding: contentPadding$,
          hintText:hintText$,
          prefixIcon:prefixIcon$,
          suffixIcon:suffixIcon$,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
          )
        ),
      ),
    );
  }
}
