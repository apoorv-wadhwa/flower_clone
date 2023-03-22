#!/bin/bash
cd ..
flutter pub add -d json_serializable
flutter pub add -d retrofit_generator
flutter pub add -d build_runner
flutter pub add flutter_bloc
flutter pub add flutter_easyloading
flutter pub add intl
flutter pub add retrofit
flutter pub add pretty_dio_logger
flutter pub add json_annotation
mkdir assets
cd assets
mkdir images icons animations videos
cd ..
cd lib
mkdir src
cd . > bloc_providers.dart
cd src
mkdir core data presentation
cd core
mkdir constants flavors helpers
cd constants
if [ -e app_text_styles.dart ]
then 
    echo "app_text_styles.dart exists"
else
    cd . > app_text_styles.dart
    printf "class AppTextStyles {" >> app_text_styles.dart
    printf "}" >> app_text_styles.dart
fi
if [ -e color_constants.dart ]
then 
    echo "color_constants.dart exists"
else
    cd . > color_constants.dart
    printf "class ColorConstants {" >> color_constants.dart
    printf "}" >> color_constants.dart
fi    
if [ -e dimension_constants.dart ]
then 
    echo "dimension_constants.dart exists"
else    
    cd . > dimension_constants.dart
    printf "class AppDimensions {" >> dimension_constants.dart
    printf "}" >> dimension_constants.dart
fi    
if [ -e enum_constants.dart ]
then 
    echo "enum_constants.dart exists"
else      
    cd . > enum_constants.dart
fi    
if [ -e image_constants.dart ]
then 
    echo "image_constants.dart exists"
else    
    cd . > image_constants.dart
    printf "class ImageConstants {" >> image_constants.dart
    printf "}" >> image_constants.dart
fi    
if [ -e icon_constants.dart ]
then 
    echo "icon_constants.dart exists"
else    
    cd . > icon_constants.dart
    printf "class IconConstants {" >> icon_constants.dart
    printf "}" >> icon_constants.dart
fi    
if [ -e string_constants.dart ]
then 
    echo "string_constants.dart exists"
else    
    cd . > string_constants.dart
    printf "class StringConstants {" >> string_constants.dart
    printf "}" >> string_constants.dart
fi    
if [ -e constants_import.dart ]
then 
    echo "constants_import.dart exists"
else    
    cd . > constants_import.dart
    printf "export 'app_text_styles.dart';" >> constants_import.dart
    printf "export 'color_constants.dart';" >> constants_import.dart
    printf "export 'dimension_constants.dart';" >> constants_import.dart
    printf "export 'enum_constants.dart';" >> constants_import.dart
    printf "export 'image_constants.dart';" >> constants_import.dart
    printf "export 'icon_constants.dart';" >> constants_import.dart
    printf "export 'string_constants.dart';" >> constants_import.dart
fi
if [ -e shared_prefs.dart]
then
    echo "constants_import.dart exists"
else
    cd . > shared_prefs.dart
fi
if [ -e apis.dart]
then
    echo "apis.dart exists"
else
    cd . > apis.dart
fi
cd ..
cd flavors
mkdir flavors_config
cd flavors_config
cd ..
cd ..
cd helpers
if [ -e app_helper.dart ]
then 
    echo "app_helper.dart exists"
else
    cd . > app_helper.dart
fi
if [ -e alert_helper.dart ]
then 
    echo "alert_helper.dart exists"
else
    cd . > alert_helper.dart
fi
if [ -e url_helper.dart ]
then 
    echo "url_helper.dart exists"
else
    cd . > url_helper.dart
fi
if [ -e validator_helper.dart ]
then 
    echo "validator_helper.dart exists"
else
    cd . > validator_helper.dart
fi
if [ -e size_helper.dart ]
then 
    echo "size_helper.dart exists"
else
    cd . > size_helper.dart
fi
if [ -e routing_helper.dart ]
then 
    echo "routing_helper.dart exists"
else
    cd . > routing_helper.dart
fi
if [ -e helper_imports.dart ]
then 
    echo "helper_imports.dart exists"
else
    cd . > helper_imports.dart
    printf "export 'app_helper.dart';" >> helper_imports.dart
    printf "export 'alert_helper.dart';" >> helper_imports.dart
    printf "export 'url_helper.dart';" >> helper_imports.dart
    printf "export 'validator_helper.dart';" >> helper_imports.dart
    printf "export 'size_helper.dart';" >> helper_imports.dart
    printf "export 'routing_helper.dart';" >> helper_imports.dart
fi
cd ..
cd ..
cd data
mkdir models network repositories services
cd models
mkdir common_models
cd ..
cd network
if [ -e rest_client.dart ]
then 
    echo "rest_client.dart exists"
else
    cd . > rest_client.dart
    printf "import 'package:retrofit/retrofit.dart';" >> rest_client.dart
    printf "import 'package:flutter/foundation.dart';" >> rest_client.dart
    printf "import 'package:dio/dio.dart';" >> rest_client.dart
    printf "part 'rest_client.g.dart';" >> rest_client.dart
    printf "@RestApi(baseUrl: '')" >> rest_client.dart
    printf "abstract class RestClient {" >> rest_client.dart
    printf "    factory RestClient(Dio dio,{@required String baseUrl}) = _RestClient;" >> rest_client.dart
    printf "}" >> rest_client.dart
fi
cd ..
cd repositories
if [ -e api_repository.dart ]
then 
    echo "api_repository.dart exists"
else
    cd . > api_repository.dart
    printf "import '../network/rest_client.dart';" >> api_repository.dart
    printf "import 'package:dio/dio.dart';" >> api_repository.dart
    printf "import 'package:flutter/foundation.dart';" >> api_repository.dart
    printf "import 'package:pretty_dio_logger/pretty_dio_logger.dart';" >> api_repository.dart
    printf "import '../../core/constants/constants_import.dart';" >> api_repository.dart
    printf "class ApiRepository {" >> api_repository.dart
    printf "    static RestClient? _restClient;" >> api_repository.dart
    printf "    static Future<void> init() async {" >> api_repository.dart
    printf "        final _dio = Dio();" >> api_repository.dart
    printf "        final _headers = { " >> api_repository.dart
    printf "            'X-Authorization' : 'authorization_here'," >> api_repository.dart
    printf "            'Authorization' : 'authorization_here'" >> api_repository.dart
    printf "        };" >> api_repository.dart
    printf "   _dio.options = BaseOptions(headers: _headers);" >> api_repository.dart
    printf "   if(kDebugMode) {" >> api_repository.dart
    printf "        _dio.interceptors.add(" >> api_repository.dart
    printf "            PrettyDioLogger(" >> api_repository.dart
    printf "                request: true,requestHeader: false,requestBody: true,responseBody: false,responseHeader: false,error: true,compact: true,maxWidth: 90," >> api_repository.dart
    printf "            )," >> api_repository.dart
    printf "         );" >> api_repository.dart
    printf "   }" >> api_repository.dart
    printf "   _restClient = RestClient(_dio, baseUrl: 'base_url_here');" >> api_repository.dart
    printf "}" >> api_repository.dart
    printf "}" >> api_repository.dart
fi
cd ..
cd ..
cd presentation
mkdir bloc views widgets
cd widgets
mkdir common custom
cd custom
if [ -e custom_widget_imports.dart ]
then 
    echo "custom_widget_imports.dart exists"
else
    cd . > custom_widget_imports.dart
fi
cd ..
cd ..
cd ..
cd ..
cd ..
flutter packages pub run build_runner build --delete-conflicting-outputs
pwd

