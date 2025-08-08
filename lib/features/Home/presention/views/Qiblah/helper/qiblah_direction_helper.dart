String getDirectionFromDegree(double degree) {
  if (degree >= 22.5 && degree < 67.5) {
    return "شمال شرقي";
  } else if (degree >= 67.5 && degree < 112.5) {
    return "شرق";
  } else if (degree >= 112.5 && degree < 157.5) {
    return "جنوب شرقي";
  } else if (degree >= 157.5 && degree < 202.5) {
    return "جنوب";
  } else if (degree >= 202.5 && degree < 247.5) {
    return "جنوب غربي";
  } else if (degree >= 247.5 && degree < 292.5) {
    return "غرب";
  } else if (degree >= 292.5 && degree < 337.5) {
    return "شمال غربي";
  } else {
    return "شمال";
  }
}


String convertToArabicNumbers(String input) {
  const english = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9', '.'];
  const arabic = ['٠', '١', '٢', '٣', '٤', '٥', '٦', '٧', '٨', '٩', '٫'];

  for (int i = 0; i < english.length; i++) {
    input = input.replaceAll(english[i], arabic[i]);
  }
  return input;
}
