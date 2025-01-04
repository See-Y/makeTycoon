import 'package:flutter/cupertino.dart';

import 'album.dart';
import 'member.dart';

class Band with ChangeNotifier{
  String name;
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

  void updateMoney(int amount) {
    money += amount;
    notifyListeners();
  }

  void updateFans(int count) {
    fans += count;
    notifyListeners();
  }
}
