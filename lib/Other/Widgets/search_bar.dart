import 'package:flutter/material.dart';
class SearchBar extends StatelessWidget {

  final Function onChange$;
  final TextEditingController textEditingController$;

  SearchBar({this.onChange$, this.textEditingController$});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 380,
      padding: EdgeInsets.all(5),
      child:
       TextFormField(
          onChanged: onChange$,
          controller: textEditingController$,
          decoration: InputDecoration(
            prefixIcon: Icon(Icons.search),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10)
            ),
            contentPadding: EdgeInsets.all(10),
              fillColor: Colors.white,
            filled: true
          ),
        ),

    );
  }
}



// TextFormField(
// onChanged: (value) {
//
// userController.changeTextForm.value = value;
// // userController.changeTextForm.value = textEditingController.text ;
// },
// controller: textEditingController,
// decoration: InputDecoration(
// prefixIcon: Icon(Icons.search ),
// suffixIcon: textEditingController.text.length > 0  ?   IconButton(icon:Icon(Icons.clear) ,onPressed: () {
// textEditingController.clear() ;
// },):null,
// border: OutlineInputBorder(
// borderRadius: BorderRadius.circular(10)
// ),
// contentPadding: EdgeInsets.all(10),
// fillColor: Colors.white,
// filled: true
// ),
// ),