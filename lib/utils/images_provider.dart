class ImagesProvider {
  /*
   * 根据name获取图片路径
   */
  static String getImagePath(String imageName) {
    return "images/$imageName.png";
  }
}
