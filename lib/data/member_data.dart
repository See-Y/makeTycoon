import '../models/leader_effect.dart';
import '../models/effect_target.dart';
import '../models/effect_type.dart';

final List<Map<String, dynamic>> memberData = [
  {
    "instrument": "보컬",
    "animalType": "갈매기",
    "leaderEffect1": LeaderEffect(
      description: "공연 팬 증가량 +10%",
      target: EffectTarget.performance,
      type: EffectType.increase,
      value: 10,
    ),
    "leaderEffect2": LeaderEffect(
      description: "악기 강화 성공 확률 -10%",
      target: EffectTarget.enhancement,
      type: EffectType.decrease,
      value: 10,
    ),
    "image": "assets/images/갈매기.png",
    "position": [0.0, 0.5, -10.0],
  },
  {
    "instrument": "기타",
    "animalType": "여우",
    "leaderEffect1": LeaderEffect(
      description: "음반 명반 확률 +10%",
      target: EffectTarget.album,
      type: EffectType.increase,
      value: 10,
    ),
    "leaderEffect2": LeaderEffect(
      description: "팬 감소율 +15%",
      target: EffectTarget.approval,
      type: EffectType.increase,
      value: 15,
    ),
    "image": "assets/images/여우.png",
    "position": [0.5, 0.05, -6.0],
  },
  {
    "instrument": "드럼",
    "animalType": "고릴라",
    "leaderEffect1": LeaderEffect(
      description: "공연 수익 +15%",
      target: EffectTarget.performance,
      type: EffectType.increase,
      value: 15,
    ),
    "leaderEffect2": LeaderEffect(
      description: "공연 성공률 -10%",
      target: EffectTarget.performance,
      type: EffectType.decrease,
      value: 10,
    ),
    "image": "assets/images/고릴라.png",
    "position": [0.0, -0.7, 5.0],
  },
  {
    "instrument": "베이스",
    "animalType": "판다",
    "leaderEffect1": LeaderEffect(
      description: "악기 강화 성공 확률 +10%",
      target: EffectTarget.enhancement,
      type: EffectType.increase,
      value: 10,
    ),
    "leaderEffect2": LeaderEffect(
      description: "음반 수익 -5%",
      target: EffectTarget.album,
      type: EffectType.decrease,
      value: 5,
    ),
    "image": "assets/images/팬더.png",
    "position": [-0.5, -0.5, 1.0],
  },
  {
    "instrument": "키보드",
    "animalType": "비버",
    "leaderEffect1": LeaderEffect(
      description: "팬 감소율 -10%",
      target: EffectTarget.approval,
      type: EffectType.decrease,
      value: 10,
    ),
    "leaderEffect2": LeaderEffect(
      description: "자신의 지지율 -10",
      target: EffectTarget.approval,
      type: EffectType.decrease,
      value: 10,
    ),
    "image": "assets/images/비버.png",
    "position": [-0.9, -0.3, 0.0],
  },
  {
    "instrument": "리코더",
    "animalType": "너구리",
    "leaderEffect1": LeaderEffect(
      description: "공연 성공률 +10%",
      target: EffectTarget.performance,
      type: EffectType.increase,
      value: 10,
    ),
    "leaderEffect2": LeaderEffect(
      description: "음반 명반 확률 -5%",
      target: EffectTarget.album,
      type: EffectType.decrease,
      value: 5,
    ),
    "image": "assets/images/너구리.png",
    "position": [-0.8, 0.8, 4.0],
  },
  {
    "instrument": "캐스터네츠",
    "animalType": "다람쥐",
    "leaderEffect1": LeaderEffect(
      description: "자신의 지지율 +10",
      target: EffectTarget.approval,
      type: EffectType.increase,
      value: 10,
    ),
    "leaderEffect2": LeaderEffect(
      description: "명반 확률 +5%",
      target: EffectTarget.album,
      type: EffectType.increase,
      value: 5,
    ),
    "image": "assets/images/다람쥐.png",
    "position": [0.03, 0.0, -3.0],
  },
  {
    "instrument": "콘트라베이스",
    "animalType": "펭귄",
    "leaderEffect1": LeaderEffect(
      description: "돌발 이벤트 등장률 +10%",
      target: EffectTarget.event,
      type: EffectType.increase,
      value: 10,
    ),
    "leaderEffect2": LeaderEffect(
      description: "자신의 지지율 -5",
      target: EffectTarget.approval,
      type: EffectType.decrease,
      value: 5,
    ),
    "image": "assets/images/펭귄.png",
    "position": [-0.2, 0.4, -9.0],
  },
  {
    "instrument": "바이올린",
    "animalType": "사슴",
    "leaderEffect1": LeaderEffect(
      description: "음반 수익 +10%",
      target: EffectTarget.album,
      type: EffectType.increase,
      value: 10,
    ),
    "leaderEffect2": LeaderEffect(
      description: "본인의 모든 스탯 -3",
      target: EffectTarget.stats,
      type: EffectType.decrease,
      value: 3,
    ),
    "image": "assets/images/사슴.png",
    "position":[0.8, -0.05, -2.0],
  },
  {
    "instrument": "트라이앵글",
    "animalType": "개구리",
    "leaderEffect1": LeaderEffect(
      description: "모든 공연 대관료 -10%",
      target: EffectTarget.rentalFee,
      type: EffectType.decrease,
      value: 10,
    ),
    "leaderEffect2": LeaderEffect(
      description: "음반 명반 확률 -5%",
      target: EffectTarget.album,
      type: EffectType.decrease,
      value: 5,
    ),
    "image": "assets/images/개구리.png",
    "position": [0.6, 0.4, -7.0],
  },
  {
    "instrument": "탬버린",
    "animalType": "앵무새",
    "leaderEffect1": LeaderEffect(
      description: "본인의 모든 스탯 +5",
      target: EffectTarget.stats,
      type: EffectType.increase,
      value: 5,
    ),
    "leaderEffect2": LeaderEffect(
      description: "모든 공연 대관료 +10%",
      target: EffectTarget.rentalFee,
      type: EffectType.increase,
      value: 10,
    ),
    "image": "assets/images/앵무새.png",
    "position": [0.8, -0.7, -1.0],
  },
  {
    "instrument": "트럼펫",
    "animalType": "카피바라",
    "leaderEffect1": LeaderEffect(
      description: "공연 수익 +15%",
      target: EffectTarget.performance,
      type: EffectType.increase,
      value: 15,
    ),
    "leaderEffect2": LeaderEffect(
      description: "모든 공연 대관료 +10%",
      target: EffectTarget.rentalFee,
      type: EffectType.increase,
      value: 10,
    ),
    "image": "assets/images/카피바라.png",
    "position": [-0.4, 0.0, -5.0],
  },
  {
    "instrument": "우쿨렐레",
    "animalType": "오랑우탄",
    "leaderEffect1": LeaderEffect(
      description: "악기 강화 성공 확률 +10%",
      target: EffectTarget.enhancement,
      type: EffectType.increase,
      value: 10,
    ),
    "leaderEffect2": LeaderEffect(
      description: "공연 팬 증가량 -5%",
      target: EffectTarget.performance,
      type: EffectType.decrease,
      value: 5,
    ),
    "image": "assets/images/오랑우탄.png",
    "position": [0.5, -0.5, 2.0],
  },
  {
    "instrument": "거문고",
    "animalType": "고슴도치",
    "leaderEffect1": LeaderEffect(
      description: "공연 팬 증가량 +10%",
      target: EffectTarget.performance,
      type: EffectType.increase,
      value: 10,
    ),
    "leaderEffect2": LeaderEffect(
      description: "악기 강화 성공 확률 -10%",
      target: EffectTarget.enhancement,
      type: EffectType.decrease,
      value: 10,
    ),
    "image": "assets/images/고슴도치.png",
    "position": [0.2, 0.5, -8.0],
  },
  {
    "instrument": "마림바",
    "animalType": "코알라",
    "leaderEffect1": LeaderEffect(
      description: "음반 수익 +10%",
      target: EffectTarget.album,
      type: EffectType.increase,
      value: 10,
    ),
    "leaderEffect2": LeaderEffect(
      description: "공연 수익 -5%",
      target: EffectTarget.performance,
      type: EffectType.decrease,
      value: 5,
    ),
    "image": "assets/images/코알라.png",
    "position": [-0.8, -0.8, 3.0],
  },
  {
    "instrument": "해금",
    "animalType": "두루미",
    "leaderEffect1": LeaderEffect(
      description: "음반 명반 확률 +10%",
      target: EffectTarget.album,
      type: EffectType.increase,
      value: 10,
    ),
    "leaderEffect2": LeaderEffect(
      description: "돌발 이벤트 등장률 -10%",
      target: EffectTarget.event,
      type: EffectType.decrease,
      value: 10,
    ),
    "image": "assets/images/두루미.png",
    "position": [-0.05, -0.05, -4.0],
  },
];
