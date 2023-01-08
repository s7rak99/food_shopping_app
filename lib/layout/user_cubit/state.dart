abstract class ShopStates {}

class ShopInitialStates extends ShopStates {}

class ShopGetUserLoadingStates extends ShopStates {}

class ShopGetUserSuccessStates extends ShopStates {}

class ShopGetUserErrorStates extends ShopStates {
  final String err;

  ShopGetUserErrorStates(this.err);
}

class ShopGetProductLoadingStates extends ShopStates {}

class ShopGetProductSuccessStates extends ShopStates {}

class ShopGetProductErrorStates extends ShopStates {}

class ShopAddProductToCartSuccessStates extends ShopStates {}

class ShopAddProductToCartErrorStates extends ShopStates {}

class ShopGetCartLoadingStates extends ShopStates {}

class ShopGetCartSuccessStates extends ShopStates {}

class ShopAGetCartErrorStates extends ShopStates {}

class ShopCalcPriceState extends ShopStates {}

class ShopUpdateQuantitySuccessStates extends ShopStates {}

class ShopUpdateQuantityErrorStates extends ShopStates {}

class ShopDeleteSuccessStates extends ShopStates {}

class ShopDeleteErrorStates extends ShopStates {}

class UserNoteSuccessStates extends ShopStates {}

class UserNoteErrorStates extends ShopStates {}

class ShopGetNotificationLoadingStates extends ShopStates {}

class ShopGetNotificationSuccessStates extends ShopStates {}

class ShopGetNotificationErrorStates extends ShopStates {}

class ShopAddInvoiceLoadingStates extends ShopStates {}

class ShopAddInvoiceSuccessStates extends ShopStates {}

class ShopAddInvoiceErrorStates extends ShopStates {}

class ShopGetInvoiceLoadingStates extends ShopStates {}

class ShopGetInvoiceSuccessStates extends ShopStates {}

class ShopGetInvoiceErrorStates extends ShopStates {}

class ShopDeleteCartSuccessStates extends ShopStates {}

class ShopDeleteCartErrorStates extends ShopStates {}

class UserProfileImagePickedSuccessStates extends ShopStates {}

class UserProfileImagePickedErrorStates extends ShopStates {}

class UserUploadInfoLoadingStates extends ShopStates {}

class UserUploadInfoSuccessStates extends ShopStates {}

class UserUploadInfoErrorStates extends ShopStates {}

class changeThemeStates extends ShopStates {}

class changeThemeLoadingStates extends ShopStates {}
