import 'package:analects/app/modules/widgets/widget_imports.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

class CustomDropdown<T> extends StatelessWidget {
  CustomDropdown({
    Key? key,
    required this.items,
    required this.onChanged,
    required this.label,
    this.selectedValue,
    this.width,
    this.hasSearch = false,
    this.hasLabel = false,
  }) : super(key: key);

  final List<DropdownMenuItem<T>> items;
  final String label;
  final T? selectedValue;
  final double? width;
  final T? Function(T?)? onChanged;
  final bool hasSearch;
  final bool hasLabel;

  final TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ??  200.w,
      height: 64.h,
      child: DropdownButtonHideUnderline(
        child: Stack(
          children: [
            Align(
              alignment: Alignment.bottomCenter,
              child: SizedBox(
                height: 62.h,
                child: DropdownButton2<T>(
                  isExpanded: true,
                  hint: Text(
                    label,
                    style: AppTypography.kMedium14.copyWith(
                        color: AppColors.kWhiteColor.withOpacity(.7),
                        ),
                  ),
                  items: items,
                  value: selectedValue,
                  onChanged: onChanged,
                  buttonStyleData: ButtonStyleData(
                    height: 66.h,
                    width: width ?? 200.w,
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    elevation: 0,
                    decoration: BoxDecoration(
                      color: AppColors.kPrimary1Color,
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                  ),
                  menuItemStyleData: MenuItemStyleData(
                    height: 46.h,
                    padding: EdgeInsets.symmetric(
                      horizontal: 40.w,
                    ),
                  ),
                  dropdownStyleData: DropdownStyleData(
                    maxHeight: 200.h,
                    width:  width ?? 200.w,
                    padding: null,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.r),
                      color: AppColors.kPrimary1Color,
                    ),
                    elevation: 4,
                    scrollbarTheme: ScrollbarThemeData(
                      radius: const Radius.circular(40),
                      thickness: MaterialStateProperty.all(6),
                      thumbVisibility: MaterialStateProperty.all(true),
                    ),
                  ),
                  autofocus: false,
                  style: const TextStyle(
                    fontSize: 14,
                  ),
                  dropdownSearchData: DropdownSearchData(
                    searchController: textEditingController,
                    searchInnerWidgetHeight: hasSearch ? 56.h : 0.h,
                    searchInnerWidget: hasSearch
                        ? Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 20.w,
                              vertical: 20.w,
                            ),
                            child: TextFormField(
                              controller: textEditingController,
                              autofocus: false,
                              style: AppTypography.kMedium14.copyWith(
                                color: AppColors.kWhiteColor.withOpacity(.7),
                              ),
                              decoration: InputDecoration(
                                isDense: true,
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 8,
                                ),
                                hintText: 'Search',
                                hintStyle: AppTypography.kMedium14.copyWith(
                                  color: AppColors.kWhiteColor.withOpacity(.7),),
                                enabledBorder: UnderlineInputBorder(
                                  borderRadius: BorderRadius.circular(20.r),
                                  borderSide:  BorderSide(color: AppColors.kWhiteColor.withOpacity(.3)),
                                ),
                                border: UnderlineInputBorder(
                                  borderRadius: BorderRadius.circular(20.r),
                                  borderSide: const  BorderSide(color: AppColors.kPrimary1Color),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderRadius: BorderRadius.circular(20.r),
                                  borderSide: const BorderSide(color: AppColors.kPrimary1Color),
                                ),
                              ),
                            ),
                          )
                        : const SizedBox(),
                    searchMatchFn: hasSearch
                        ? (item, searchValue) {
                            return (item.value.toString().toLowerCase().contains(searchValue.toLowerCase()));
                          }
                        : null,
                    // onMenuStateChange: hasSearch
                    //     ? (isOpen) {
                    //         if (!isOpen) {
                    //           textEditingController.clear();
                    //         }
                    //       }
                    //     : null,
                  ),
                ),
              ),
            ),
            if (selectedValue != null && hasLabel)
              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: EdgeInsets.only(left: 30.w),
                  child: Text(
                    label,
                    style: AppTypography.kMedium12.copyWith(
                        color: AppColors.kWhiteColor.withOpacity(.7),
                        fontSize: 10),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
