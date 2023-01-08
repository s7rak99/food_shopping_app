abstract class AdminStates {}

class AdminInitialStates extends AdminStates {}

class AdminGetUserLoadingStates extends AdminStates {}

class AdminGetUserSuccessStates extends AdminStates {}

class AdminGetUserErrorStates extends AdminStates {
  final String err;

  AdminGetUserErrorStates(this.err);
}

class AdminChangeBottomNavStates extends AdminStates {}

class AdminProductImagePickedSuccessStates extends AdminStates {}

class AdminProductImagePickedErrorStates extends AdminStates {}

class AdminProductImageDeletedStates extends AdminStates {}

class AdminAddProductLoadingStates extends AdminStates {}

class AdminAddProductSuccessStates extends AdminStates {}

class AdminAddProductErrorStates extends AdminStates {}

class AdminGetProductLoadingStates extends AdminStates {}

class AdminGetProductSuccessStates extends AdminStates {}

class AdminGetProductErrorStates extends AdminStates {}

class AdminUpdateErrorStates extends AdminStates {}

class AdminUploadInfoLoadingStates extends AdminStates {}

class AdminUploadInfoSuccessStates extends AdminStates {}

class AdminUploadInfoErrorStates extends AdminStates {}

class AdminProfileImagePickedSuccessStates extends AdminStates {}

class AdminProfileImagePickedErrorStates extends AdminStates {}

class AdminUpdateProductDetailsLoadingStates extends AdminStates {}

class AdminUpdateProductDetailsSuccessStates extends AdminStates {}

class AdminUpdateProductDetailsErrorStates extends AdminStates {}

class AdminGetOneProductLoadingStates extends AdminStates {}

class AdminGetOneProductSuccessStates extends AdminStates {}

class AdminGetOneProductErrorStates extends AdminStates {}

class AdminGetAllNotesLoadingStates extends AdminStates {}

class AdminGetAllNotesSuccessStates extends AdminStates {}

class AdminGetAllNotesErrorStates extends AdminStates {}

class AdminSendResponseSuccessStates extends AdminStates {}

class AdminSendResponseErrorStates extends AdminStates {}

