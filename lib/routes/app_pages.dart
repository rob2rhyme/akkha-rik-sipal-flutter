//lib/routes/app_pages.dart
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:akkha_rik_lipi_sipal/ui/add_subtract/bindings/add_subtract_bindings.dart';
import 'package:akkha_rik_lipi_sipal/ui/add_subtract/views/add_subtract_screen.dart';
import 'package:akkha_rik_lipi_sipal/ui/alphabets/bindings/alphabets_binding.dart';
import 'package:akkha_rik_lipi_sipal/ui/alphabets/views/alphabets_screen.dart';
import 'package:akkha_rik_lipi_sipal/ui/compare/bindings/compare_binding.dart';
import 'package:akkha_rik_lipi_sipal/ui/compare/views/compare_screen.dart';
import 'package:akkha_rik_lipi_sipal/ui/counting/bindings/counting_bindings.dart';
import 'package:akkha_rik_lipi_sipal/ui/counting/views/couting_screens.dart';
import 'package:akkha_rik_lipi_sipal/ui/dragquiz/bindings/drag_quiz_bindings.dart';
import 'package:akkha_rik_lipi_sipal/ui/dragquiz/views/drag_quiz_views.dart';
import 'package:akkha_rik_lipi_sipal/ui/dragsubcategory/bindings/drag_subcategory_bindings.dart';
import 'package:akkha_rik_lipi_sipal/ui/dragsubcategory/views/drag_subcategory_views.dart';
import 'package:akkha_rik_lipi_sipal/ui/home/bindings/home_binding.dart';
import 'package:akkha_rik_lipi_sipal/ui/home/views/home_screen.dart';
import 'package:akkha_rik_lipi_sipal/ui/items/bindings/item_binding.dart';
import 'package:akkha_rik_lipi_sipal/ui/items/views/items_screen.dart';
import 'package:akkha_rik_lipi_sipal/ui/missing_numbers/bindings/missing_numbers_bindings.dart';
import 'package:akkha_rik_lipi_sipal/ui/missing_numbers/views/missing_numbers_screens.dart';
import 'package:akkha_rik_lipi_sipal/ui/months_days/bindings/months_days_bindings.dart';
import 'package:akkha_rik_lipi_sipal/ui/months_days/views/months_days_screens.dart';
import 'package:akkha_rik_lipi_sipal/ui/numbers/bindings/numbers_binding.dart';
import 'package:akkha_rik_lipi_sipal/ui/numbers/views/numbers_screens.dart';
import 'package:akkha_rik_lipi_sipal/ui/paint/bindings/paint_binding.dart';
import 'package:akkha_rik_lipi_sipal/ui/paint/views/paint_screen.dart';
import 'package:akkha_rik_lipi_sipal/ui/pro_version/bindings/pro_version_binding.dart';
import 'package:akkha_rik_lipi_sipal/ui/pro_version/views/pro_version_screen.dart';
import 'package:akkha_rik_lipi_sipal/ui/quantity/bindings/quantity_binding.dart';
import 'package:akkha_rik_lipi_sipal/ui/quantity/views/quantity_screen.dart';
import 'package:akkha_rik_lipi_sipal/ui/quiz/bindings/quiz_binding.dart';
import 'package:akkha_rik_lipi_sipal/ui/quiz/views/quiz_screen.dart';
import 'package:akkha_rik_lipi_sipal/ui/settings/bindings/settings_binding.dart';
import 'package:akkha_rik_lipi_sipal/ui/settings/views/settings_screen.dart';
import 'package:akkha_rik_lipi_sipal/ui/single_item/bindings/single_item_binding.dart';
import 'package:akkha_rik_lipi_sipal/ui/single_item/views/single_item_screen.dart';
import 'package:akkha_rik_lipi_sipal/ui/spelling/bindings/spelling_bindings.dart';
import 'package:akkha_rik_lipi_sipal/ui/spelling/views/spelling_screens.dart';
import 'package:akkha_rik_lipi_sipal/ui/subcategory/bindings/subcategory_binding.dart';
import 'package:akkha_rik_lipi_sipal/ui/subcategory/views/subcategory_sceen.dart';
import 'package:akkha_rik_lipi_sipal/ui/time/bindings/time_binding.dart';
import 'package:akkha_rik_lipi_sipal/ui/time/views/time_screens.dart';
import 'package:akkha_rik_lipi_sipal/ui/upper_lower/bindings/upper_lower_binding.dart';
import 'package:akkha_rik_lipi_sipal/ui/upper_lower/views/upper_lower_screen.dart';
import 'package:akkha_rik_lipi_sipal/ui/videoList/bindings/video_list_binding.dart';
import 'package:akkha_rik_lipi_sipal/ui/videoList/views/video_list_screen.dart';
import 'package:akkha_rik_lipi_sipal/ui/video_player/bindings/video_player_binding.dart';
import 'package:akkha_rik_lipi_sipal/ui/video_player/views/video_player_screen.dart';
import 'package:akkha_rik_lipi_sipal/ui/video_subcategory/bindings/video_subcategory_binding.dart';
import 'package:akkha_rik_lipi_sipal/ui/video_subcategory/views/video_subcategory_screen.dart';
import 'app_routes.dart';

class AppPages {
  static var list = [
    GetPage(
      name: AppRoutes.home,
      page: () => HomeScreen(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: AppRoutes.subcategory,
      page: () => SubCategoryScreen(),
      binding: SubCategoryBinding(),
    ),
    GetPage(
      name: AppRoutes.items,
      page: () => ItemScreen(),
      binding: ItemBinding(),
    ),
    GetPage(
      name: AppRoutes.singleItem,
      page: () => const SingleItemScreen(),
      binding: SingleItemBinding(),
    ),
    GetPage(
      name: AppRoutes.quiz,
      page: () => QuizScreen(),
      binding: QuizBinding(),
    ),
    GetPage(
      name: AppRoutes.settings,
      page: () => SettingScreen(),
      binding: SettingsBinding(),
    ),
    GetPage(
      name: AppRoutes.paint,
      page: () => const PaintScreen(),
      binding: PaintBinding(),
    ),
    GetPage(
      name: AppRoutes.dragSubcategory,
      page: () => const DragSubcategoryScreen(),
      binding: DragSubcategoryBindings(),
    ),
    GetPage(
      name: AppRoutes.dragQuiz,
      page: () => DragQuizScreen(),
      binding: DragQuizBindings(),
    ),

    GetPage(
      name: AppRoutes.numbers,
      page: () => NumbersScreen(),
      binding: NumbersBinding(),
    ),
    GetPage(
      name: AppRoutes.counting,
      page: () => const CountingScreen(),
      binding: CountingBinding(),
    ),
    GetPage(
      name: AppRoutes.addSubtract,
      page: () => const AddSubtractScreen(),
      binding: AddSubtractBinding(),
    ),
    GetPage(
      name: AppRoutes.compare,
      page: () => const CompareScreen(),
      binding: CompareBinding(),
    ),
    GetPage(
      name: AppRoutes.missingNum,
      page: () => const MissingNumbersScreen(),
      binding: MissingNumbersBindings(),
    ),
    GetPage(
      name: AppRoutes.time,
      page: () => const TimeScreen(),
      binding: TimeBinding(),
    ),
    GetPage(
      name: AppRoutes.month,
      page: () => const MonthsDaysScreens(),
      binding: MonthsDaysBinding(),
    ),
    GetPage(
      name: AppRoutes.quantity,
      page: () => const QuantityScreen(),
      binding: QuantityBinding(),
    ),
    GetPage(
      name: AppRoutes.alphabets,
      page: () => const AlphabetsScreen(),
      binding: AlphabetsBinding(),
    ),
    GetPage(
      name: AppRoutes.upper,
      page: () => const UpperLowerScreen(),
      binding: UpperLowerBinding(),
    ),
    GetPage(
      name: AppRoutes.spelling,
      page: () => const SpellingScreen(),
      binding: SpellingBindings(),
    ),
    GetPage(
      name: AppRoutes.proVersion,
      page: () => ProVersionScreen(),
      binding: ProVersionBinding(),
    ),
    GetPage(
      name: AppRoutes.videoSubcategory,
      page: () => VideoSubCategoryScreen(),
      binding: VideoSubcategoryBinding(),
    ),
    GetPage(
      name: AppRoutes.videoList,
      page: () => VideoListScreen(),
      binding: VideoListBinding(),
    ),
    GetPage(
      name: AppRoutes.videoPlayer,
      page: () => const VideoPlayerScreen(),
      binding: VideoPlayerBinding(),
    ),
  ];
}
