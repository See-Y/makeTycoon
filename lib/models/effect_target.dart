enum EffectTarget {
  performance, // 공연
  album,       // 음반
  approval,    // 지지율
  stats,       // 스탯
  event,       // 이벤트
  enhancement, // 강화
  rentalFee,   // 대관료
  fan,         // 팬
}

// 맵핑: enum -> 한글 설명
const Map<EffectTarget, String> effectTargetDescriptions = {
  EffectTarget.performance: "공연",
  EffectTarget.album: "음반",
  EffectTarget.approval: "지지율",
  EffectTarget.stats: "스탯",
  EffectTarget.event: "이벤트",
  EffectTarget.enhancement: "강화",
  EffectTarget.rentalFee: "대관료",
  EffectTarget.fan: "팬",
};
