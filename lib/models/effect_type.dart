enum EffectType {
  increase, // 증가
  decrease, // 감소
}

// 맵핑: enum -> 한글 설명
const Map<EffectType, String> effectTypeDescriptions = {
  EffectType.increase: "증가",
  EffectType.decrease: "감소",
};
