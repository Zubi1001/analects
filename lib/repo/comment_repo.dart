import 'package:analects/app/modules/widgets/widget_imports.dart';
import 'package:analects/models/comment_model.dart';
import 'package:analects/services/database_service.dart';
import 'package:reaction_askany/models/emotions.dart';

class CommentsRepo {
  final _db = DatabaseService();

  // Stream<List<CommentModel?>> getCommentStream(String analectId) {
  //   return _db.commentsCollection(analectId).snapshots().map((event) {

  //     return event.docs.map((e) => CommentModel.fromMap(e.data())).toList();
  //   });
  // }

  Future<void> postComment(CommentModel comment, String analectId) async {
    await _db.commentsCollection(analectId).add(comment.toMap()).then((value) {
      _db.commentsCollection(analectId).doc(value.id).update({
        'id': value.id,
      });
    });
  }

  Stream<int> commentCountStream(analectId) =>
      _db.commentsCollection(analectId).snapshots().map(
        (event) {
          return event.docs.length;
        },
      );

  Future<void> reactToComment(
      CommentModel commentModel, Emotions reaction) async {

    commentModel.commentReactionCount.update(
      reaction,
      (value) => value + 1,
      ifAbsent: () => 1,
    );
    // commentModel.totalReactionCount = commentModel.commentReactionCount.values.fold(0, (previousValue, element) => previousValue + element);
    await _db.commentsCollection(commentModel.analectId).doc(commentModel.id).update(commentModel.toMap());
  }
}
