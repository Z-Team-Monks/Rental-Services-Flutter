import 'package:flutter/material.dart';
import 'custom_rect_tween.dart';
import 'package:rental/presentation/core/customTheme/appTheme.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'hero_dialogue_route.dart';

/// {@template add_todo_button}
/// Button to add a new [Todo].
///
/// Opens a [HeroDialogRoute] of [_AddReviewPopup].
///
/// Uses a [Hero] with tag [_heroAddTodo].
/// {@endtemplate}
class AddTodoButton extends StatelessWidget {
  /// {@macro add_todo_button}
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).push(
            HeroDialogRoute(builder: (context) {
              return AddReviewPopup();
            }),
          );
        },
        child: Hero(
          tag: _heroAddTodo,
          // createRectTween: (begin, end) {
          // return CustomRectTween(begin: begin, end: end);
          // },
          child: Material(
            color: CustomTheme.lightTheme.cardColor,
            elevation: 2,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
            child: const Icon(
              Icons.add_rounded,
              size: 56,
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}

/// Tag-value used for the add todo popup button.
const String _heroAddTodo = 'add-todo-hero';

/// {@template add_todo_popup_card}
/// Popup card to add a new [Todo]. Should be used in conjuction with
/// [HeroDialogRoute] to achieve the popup effect.
///
/// Uses a [Hero] with tag [_heroAddTodo].
/// {@endtemplate}

class AddReviewPopup extends StatefulWidget {
  AddReviewPopup({Key? key}) : super(key: key);

  @override
  _AddReviewPopupState createState() => _AddReviewPopupState();
}

class _AddReviewPopupState extends State<AddReviewPopup> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Hero(
          tag: _heroAddTodo,
          child: Material(
            color: CustomTheme.lightTheme.cardColor,
            elevation: 2,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(32.0, 32.0, 32.0, 18.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Add Review",
                      style: TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 24),
                    const Text(
                      "This review must be based on real experience of the product.",
                      style: TextStyle(
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 16),
                    RatingBar.builder(
                      initialRating: 3,
                      minRating: 1,
                      allowHalfRating: true,
                      itemCount: 5,
                      // itemPadding: EdgeInsets.symmetric(horizontal: 0.0),
                      itemBuilder: (context, _) => Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      onRatingUpdate: (rating) {
                        print("rating");
                      },
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      keyboardType: TextInputType.multiline,
                      decoration: InputDecoration(
                        hintText: 'Write your reviews here',
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 1, color: Colors.grey),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 1, color: Colors.grey),
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      cursorColor: Colors.black,
                      maxLines: 7,
                    ),
                    const SizedBox(height: 14),
                    SizedBox(
                      width: double.infinity,
                      child: TextButton(
                        onPressed: () {},
                        child: const Text(
                          'Submit',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
