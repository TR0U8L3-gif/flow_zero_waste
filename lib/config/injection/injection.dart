import 'package:flow_zero_waste/config/injection/injection.config.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
	
/// GetIt instance
final locator = GetIt.instance;  
  
@InjectableInit(  
  initializerName: 'init', // default  
  preferRelativeImports: true, // default  
  asExtension: true, // default  
)  
/// Configure the dependencies
void configureDependencies() => locator.init(); 
