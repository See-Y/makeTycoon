import 'album.dart';
import 'instrument.dart';
import 'member.dart';

class Band {
  final String name;
  Member leader;
  List<Member> members;
  List<Album> albums;
  int fans;
  int money;

  Band({
    required this.name,
    required this.leader,
    required this.members,
    required this.albums,
    this.fans = 0,
    this.money = 0,
  });

  void addMember(Member member) {
    members.add(member);
  }

  void removeMember(Member member) {
    members.remove(member);
  }

  void addAlbum(Album album) {
    albums.add(album);
  }
}
