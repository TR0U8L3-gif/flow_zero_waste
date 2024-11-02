import 'package:flow_zero_waste/app.dart';
import 'package:flow_zero_waste/core/enums/build_type_enum.dart';

void main() {
  App.setup(
    flavour: 'development',
    buildType: BuildType.debug,
  );
}
