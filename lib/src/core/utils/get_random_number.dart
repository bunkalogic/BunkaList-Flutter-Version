import 'dart:math';

bool randomAdsOrBanner(){
  Random random = new Random();
  int randomNumber = random.nextInt(2);

  return randomNumber == 1 ? true : false;
}
  