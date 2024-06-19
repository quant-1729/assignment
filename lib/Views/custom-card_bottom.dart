import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomCardBottom extends StatefulWidget {
  final String like_count;
  final String comment_count;

  const CustomCardBottom({super.key, required this.like_count, required this.comment_count});

  @override
  State<CustomCardBottom> createState() => _CustomCardBottomState();
}

class _CustomCardBottomState extends State<CustomCardBottom> {
  bool showcommentfield= false;
  TextEditingController textEditingController= TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Likeicon(likecount: widget.like_count),
            Spacer(),
            Commenticon(context, widget.comment_count, (){
              // Comment action
              setState(() {
              showcommentfield=!showcommentfield;});
                }),
            Spacer(),
            Shareicon(context, (){
              //Share action
            })
          ],
        ),
        if (showcommentfield) Row(
          children: [
            TextInput("Write your comment", textEditingController)
          ],
        )


      ],
    );
  }

  Widget Commenticon(BuildContext context, commentcount, VoidCallback onpressed) {
    return Row(
      children: [
        IconButton(
            color: Colors.grey,
            icon: Icon(Icons.mode_comment_outlined),
            onPressed: onpressed
        ),
        Text(commentcount, style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400
        ),),
        SizedBox(width: 2), // Space between the icon count and text
        Text("Comment", style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400
        ),),
      ],
    );
  }

  Widget Shareicon(BuildContext context, VoidCallback onpressed) {
    return Row(
      children: [
        IconButton(
            color: Colors.grey,
            icon: Icon(CupertinoIcons.arrow_turn_up_right),
            onPressed: onpressed
        ),
        SizedBox(width: 2), // Space between the icon count and text
        Text("Share", style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400
        ),),
      ],
    );
  }

  Widget TextInput(String hint, TextEditingController messageController) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(8.0), // Optional padding
        child: TextField(
          controller: messageController,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Color(0xFFF5F5F6)),
            ),
            fillColor: Color(0xFFF5F5F6),
            filled: true,
            hintText: hint, // Use the provided hint parameter
            hintStyle: TextStyle(
              color: Colors.grey,
              fontSize: 14,
            ),
          ),
        ),
      ),
    );
  }

}

class Likeicon extends StatefulWidget {
  final String likecount;

  Likeicon({required this.likecount});

  @override
  _LikeiconState createState() => _LikeiconState();
}

class _LikeiconState extends State<Likeicon> {
  bool color_value = true; // Initial state for like icon color

  @override
  Widget build(BuildContext context) {
    Color like_color = color_value ? Colors.grey : Colors.red;

    return Row(
      children: [
        IconButton(
          icon: Icon(CupertinoIcons.hand_thumbsup, color: like_color ,),
          onPressed: () {
            setState(() {
              color_value = !color_value; // Toggle color_value
            });
          },
        ),
        Text(widget.likecount, style: TextStyle(
          fontWeight: FontWeight.w400,
          fontSize: 14,
        )),
        SizedBox(width: 2), // Space between the icon count and text
        Text("Likes", style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w400,
        )),
      ],
    );
  }
}



