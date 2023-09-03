class SliderModel {
  String imageAssetPath;
  String title;
  String subtitle;
  // String desc;

  SliderModel({this.imageAssetPath = '', this.title = '', this.subtitle = ''});

  void setImageAssetPath(String getImageAssetPath) {
    imageAssetPath = getImageAssetPath;
  }

  void setTitle(String getTitle) {
    title = getTitle;
  }

  void setSubTitle(String getSubTitle) {
    subtitle = getSubTitle;
  }

  // void setDesc(String getDesc){
  //   desc = getDesc;
  // }

  String getImageAssetPath() {
    return imageAssetPath;
  }

  String getTitle() {
    return title;
  }

  String getSubTitle() {
    return subtitle;
  }

  // String getDesc(){
  //   return desc;
  // }
}

List<SliderModel> getSlides() {
  List<SliderModel> slides = <SliderModel>[];
  SliderModel sliderModel = SliderModel();

  //1
  // sliderModel.setDesc("Discover Restaurants offering the best fast food food near you on Foodwa");
  sliderModel.setTitle("Creative");
  sliderModel.setSubTitle("Browse");
  sliderModel.setImageAssetPath("images/onborader/illustration3.png");
  slides.add(sliderModel);

  sliderModel = SliderModel();

  //2
  // sliderModel.setDesc("Our veggie plan is filled with delicious seasonal vegetables, whole grains, beautiful cheeses and vegetarian proteins");
  sliderModel.setTitle("Creative");
  sliderModel.setSubTitle("Order");
  sliderModel.setImageAssetPath("images/onborader/illustration2.png");
  slides.add(sliderModel);

  sliderModel = SliderModel();

  //3
  // sliderModel.setDesc("Food delivery or pickup from local restaurants, Explore restaurants that deliver near you.");
  sliderModel.setTitle("Creative");
  sliderModel.setSubTitle("Receive");
  sliderModel.setImageAssetPath("images/onborader/illustration.png");
  slides.add(sliderModel);

  sliderModel = SliderModel();

  return slides;
}
