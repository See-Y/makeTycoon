final Map<String, Map<String, double>> instrumentEnhanceRates = {
  '일반': {'success': 0.8, 'fail': 0.2, 'downgrade': 0.0},
  '레어': {'success': 0.7, 'fail': 0.25, 'downgrade': 0.05},
  '유니크': {'success': 0.6, 'fail': 0.3, 'downgrade': 0.1},
  '레전드': {'success': 0.5, 'fail': 0.35, 'downgrade': 0.15},
  '신화': {'success': 0.0, 'fail': 1.0, 'downgrade': 0.0}, // 신화는 최고 등급
};

final Map<String, int> instrumentEnhanceCosts = {
  '일반': 1000,
  '레어': 3000,
  '유니크': 10000,
  '레전드': 50000,
  '신화': 0, // 강화 불가
};
