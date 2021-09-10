import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:rental/core/presentation/customSnackBar.dart';
import 'package:rental/core/presentation/customTheme/appTheme.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:rental/features/property/bloc/add_review/add_review_bloc.dart';
import 'package:rental/features/property/bloc/add_review/add_review_event.dart';
import 'package:rental/features/property/bloc/add_review/add_review_state.dart';
import 'package:rental/features/property/data_provider/add_review/review_remote_data_provider.dart';
import 'package:rental/features/property/repository/add_review/add_review_repository.dart';
import './animation/hero_dialogue_route.dart';

// This is a sample button for add review popup route
class AddReviewButton extends StatelessWidget {
  final propertyId;
  AddReviewButton({required this.propertyId});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).push(
            HeroDialogRoute(builder: (context) {
              return AddReviewPopup(
                propertyId: propertyId,
              );
            }),
          );
        },
        child: Hero(
          tag: _heroAddReview,
          child: Material(
            color: CustomTheme.lightTheme.cardColor,
            elevation: 2,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
            child: const Icon(
              Icons.add_rounded,
              size: 56,
            ),
          ),
        ),
      ),
    );
  }
}

const String _heroAddReview = 'add-review-hero';

class AddReviewPopup extends StatelessWidget {
  static const pageRoute = "/add_review";
  final propertyId;
  // final ctx;
  late final FocusNode messageFocusNode;
  late final TextEditingController messageController;
  AddReviewPopup({
    Key? key,
    required this.propertyId,
    // required this.ctx,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    this.messageController = TextEditingController();
    this.messageFocusNode = FocusNode();
    this.messageFocusNode
      ..addListener(() {
        if (!this.messageFocusNode.hasFocus) {
          // BlocProvider.of<AddReviewFormBloc>(context).add(MessageUnfocused());
          context.read<AddReviewFormBloc>().add(MessageUnfocused());
        }
      });
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Hero(
          tag: _heroAddReview,
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
                    BlocBuilder<AddReviewFormBloc, AddReviewFormState>(
                        builder: (context, state) {
                      return RatingBar.builder(
                        initialRating: state.rating,
                        minRating: 1,
                        allowHalfRating: true,
                        itemCount: 5,
                        // itemPadding: EdgeInsets.symmetric(horizontal: 0.0),
                        itemBuilder: (context, _) => Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                        onRatingUpdate: (rating) {
                          context
                              .read<AddReviewFormBloc>()
                              .add(RatingChanged(rating: rating));
                        },
                      );
                    }),
                    const SizedBox(height: 16),
                    BlocBuilder<AddReviewFormBloc, AddReviewFormState>(
                      builder: (context, state) {
                        messageController.value = TextEditingValue(
                          text: state.message.value,
                          selection: TextSelection.fromPosition(
                            TextPosition(
                                offset:
                                    messageController.selection.base.offset),
                          ),
                        );
                        return TextField(
                          cursorColor: Colors.black,
                          maxLines: 6,
                          textInputAction: TextInputAction.done,
                          onChanged: (value) {
                            context
                                .read<AddReviewFormBloc>()
                                .add(MessageChanged(message: value));
                          },
                          controller: messageController,
                          focusNode: messageFocusNode,
                          keyboardType: TextInputType.multiline,
                          decoration: InputDecoration(
                            alignLabelWithHint: true,
                            hintText: 'Write your reviews here',
                            labelText: 'Review*',
                            helperText: 'Not empty',
                            errorText: state.message.invalid
                                ? 'Please ensure review is not empty'
                                : null,
                            errorBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(width: 1, color: Colors.grey),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(width: 1, color: Colors.grey),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(width: 1, color: Colors.grey),
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 24),
                    const Text(
                      "This review must be based on real experience of the product.",
                      style: TextStyle(
                        fontSize: 14,
                      ),
                    ),

                    // );
                    // }),
                    const SizedBox(height: 14),
                    BlocConsumer<AddReviewFormBloc, AddReviewFormState>(
                      listener: (context, state) {
                        if (state.isUpdating &&
                            state.status == FormzStatus.submissionSuccess) {
                          print("success");
                          final lunchBar = LunchBars(
                              lunchBarText: "Review Update Success",
                              event: LunchBarEvents.LunchBarSuccess);
                          ScaffoldMessenger.of(context).showSnackBar(lunchBar);
                        } else if (state.status ==
                            FormzStatus.submissionSuccess) {
                          print("success");
                          final lunchBar = LunchBars(
                              lunchBarText: "Review Created Successfully",
                              event: LunchBarEvents.LunchBarSuccess);
                          ScaffoldMessenger.of(context).showSnackBar(lunchBar);
                        } else if (state.status ==
                            FormzStatus.submissionFailure) {
                          print("failure");
                          final lunchBar = LunchBars(
                              lunchBarText: "Failed",
                              event: LunchBarEvents.LunchBarSuccess);
                          ScaffoldMessenger.of(context).showSnackBar(lunchBar);
                        }
                      },
                      builder: (context, state) {
                        if (state.status == FormzStatus.submissionInProgress) {
                          return Center(
                            child: SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(),
                            ),
                          );
                        }

                        return SizedBox(
                          width: double.infinity,
                          child: TextButton(
                            onPressed: () {
                              messageFocusNode.unfocus();
                              context
                                  .read<AddReviewFormBloc>()
                                  .add(FormSubmitted());
                            },
                            child: const Text(
                              'Submit',
                            ),
                          ),
                        );
                      },
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
  // ,);
}
