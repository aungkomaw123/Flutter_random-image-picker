//
//  Generated file. Do not edit.
//

// clang-format off

#import "GeneratedPluginRegistrant.h"

#if __has_include(<flutter_gallery_saver/FlutterGallerySaverPlugin.h>)
#import <flutter_gallery_saver/FlutterGallerySaverPlugin.h>
#else
@import flutter_gallery_saver;
#endif

#if __has_include(<permission_handler/PermissionHandlerPlugin.h>)
#import <permission_handler/PermissionHandlerPlugin.h>
#else
@import permission_handler;
#endif

@implementation GeneratedPluginRegistrant

+ (void)registerWithRegistry:(NSObject<FlutterPluginRegistry>*)registry {
  [FlutterGallerySaverPlugin registerWithRegistrar:[registry registrarForPlugin:@"FlutterGallerySaverPlugin"]];
  [PermissionHandlerPlugin registerWithRegistrar:[registry registrarForPlugin:@"PermissionHandlerPlugin"]];
}

@end
