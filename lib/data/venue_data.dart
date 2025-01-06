//공연장 정보를 저장하는 데이터 파일임.

import '../models/venue.dart';

final List<Venue> venueData = [
  Venue(
    name: "길거리 버스킹",
    fee: 0,
    fanIncrease: 20,
    maxAudience: 50,
    idealPrice: 0.5,
    description: "작은 거리에서 버스킹을 할 수 있습니다. 대관료는 무료입니다.",
  ),
  Venue(
    name: "홍대 라이브클럽",
    fee: 80,
    fanIncrease: 100,
    maxAudience: 300,
    idealPrice: 2,
    description: "홍대의 인기 있는 라이브클럽입니다.",
  ),
  Venue(
    name: "홍대 상상마당",
    fee: 1000,
    fanIncrease: 150,
    maxAudience: 500,
    idealPrice: 5,
    description: "공연 시설이 잘 갖춰진 상상마당에서의 무대.",
  ),
  Venue(
    name: "예스 24 라이브홀",
    fee: 5000,
    fanIncrease: 300,
    maxAudience: 1000,
    idealPrice: 7,
    description: "대형 공연을 위한 예스 24 라이브홀.",
  ),
  Venue(
    name: "고척돔",
    fee: 40000,
    fanIncrease: 1000,
    maxAudience: 40000,
    idealPrice: 17,
    description: "대규모 팬을 수용할 수 있는 고척돔.",
  ),
  Venue(
    name: "락 페스티벌",
    fee: 10000,
    fanIncrease: 200,
    maxAudience: 5000,
    idealPrice: 15,
    description: "열정적인 팬들을 위한 락 페스티벌 공연.",
  ),
];
