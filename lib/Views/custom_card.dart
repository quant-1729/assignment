// custom_card.dart
import 'package:assignment/Views/custom-card_bottom.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:assignment/DTO/post_dto.dart';

class CustomCard extends StatelessWidget {
  final PostDTO post;

  CustomCard({required this.post});

  @override
  Widget build(BuildContext context) {
    // Diving the Title
    List<String> titleParts = post.title.split(':');
    String titlePart1 = titleParts.length > 0 ? titleParts[0].trim() : '';
    String titlePart2 = titleParts.length > 1 ? titleParts[1].trim() : '';
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(0)
      ),
      color: Colors.white,
      child: Column(
        children: <Widget>[
          // card Title
          Padding(
            padding: const EdgeInsets.only(left: 8, top: 6, bottom: 4, right: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                 CircleAvatar(

                  backgroundImage: NetworkImage('https://via.placeholder.com/150'),
                   radius: 15.75,
                ),
                 SizedBox(width: 9.25,),
                 Column(
                   children: [
                     Text(titlePart1, style: TextStyle(
                       fontSize: 12,
                       fontWeight: FontWeight.w400
                     ),),
                     SizedBox(height: 1,
                     ),
                     Text(titlePart2, style: TextStyle(fontSize: 10, fontWeight: FontWeight.w400),)
                   ],
                 ),
                 Spacer(),
                 Icon(Icons.more_horiz),

              ],
            ),
          ),
          // Card Image
          Image.network(post.image.isNotEmpty ? post.image[0] : 'https://via.placeholder.com/150'),
          Padding(
            padding:  EdgeInsets.only(left: 13, right: 15, top: 11, bottom: 12),
            child: ExpandableText(text: post.eventDescription)),
          // Making the horizontal line
          Divider(),
          Padding(
            padding:  EdgeInsets.only(top: 11, bottom: 15, left: 18, right: 21),
            child: Row(
              children: <Widget>[
                IconWithCount(iconData: CupertinoIcons.hand_thumbsup, initialCount: post.likes, labelText: "Likes",onPressed:
                (){
                  // implementing the like logic
                },),
                Spacer(),
                IconWithCount(iconData: Icons.mode_comment_outlined, initialCount: post.comments.length, labelText: "Comments", onPressed: (){
                  //implementing the comment logic
                },),
                Spacer(),
                // Making the share icon different
                Row(
                  children: [
                    IconButton(
                      icon: Icon(CupertinoIcons.arrow_turn_up_right),
                      color: Colors.grey,
                      onPressed: (){
                        // Implementing the share logic

                      }
                    ),
                    SizedBox(width: 2), // Space between the icon count and text
                    Text("Share"),
                  ],
                )

              ],
            ),
          ),
        ],
      ),
    );
  }
}


// Creating Expandable text
class ExpandableText extends StatefulWidget {
  final String text;

  ExpandableText({required this.text});

  @override
  _ExpandableTextState createState() => _ExpandableTextState();
}

class _ExpandableTextState extends State<ExpandableText> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          widget.text,
          maxLines: isExpanded ? null : 2,
          overflow: isExpanded ? TextOverflow.visible : TextOverflow.ellipsis,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
        ),
        GestureDetector(
          onTap: () {
            setState(() {
              isExpanded = !isExpanded;
            });
          },
          child: Text(
            isExpanded ? "Show less" : "See more",
            style: TextStyle(color: Colors.blue),
          ),
        ),
      ],
    );
  }
}
