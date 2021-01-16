import 'package:gitrepo/src/common/box_repository.dart';
import 'package:gitrepo/src/models/tag.dart';

class TagRepository {
  BoxRepository _boxRepository;
  TagRepository(this._boxRepository);

  Tag findSomerepository(int repositoryId) {
    Tag tag = _boxRepository.repoBox.get('TAGS$repositoryId');
    if (tag == null) return null;
    return tag;
  }

  Future<Tag> saveRepositoryTag(int repositoryId, String tag) async {
    Tag tagFounded = findSomerepository(repositoryId);
    if (tagFounded == null) {
      tagFounded = Tag(idRepository: repositoryId, tags: [tag]);
    } else if (!tagFounded.tags.contains(tag)) {
      tagFounded.tags.add(tag);
    }
    await _boxRepository.repoBox.put('TAGS$repositoryId', tagFounded);
    return tagFounded;
  }

  Future<Tag> deleteTag(int repositoryId, String tag) async {
    Tag tagFounded = findSomerepository(repositoryId);
    tagFounded.tags.removeWhere((element) => element == tag);
    await _boxRepository.repoBox.put('TAGS$repositoryId', tagFounded);
    return tagFounded;
  }
}
