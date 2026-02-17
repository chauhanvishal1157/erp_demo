class CrmBaseAppUrl{
  CrmBaseAppUrl._();

  static Environment environment = Environment.demo;

  static String serverUrl(){
    switch(environment) {
      case Environment.demo:
        return "https://shiserp.com/demo/";
      case Environment.live:
        return "https://shiserp.com/";
    }
  }

  static String crmBaseAppUrl = "${serverUrl()}api/";
  static String crmBaseImageUrl = serverUrl();}

enum Environment{
  live,
  demo,
}


