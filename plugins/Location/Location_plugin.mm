
#import <Foundation/Foundation.h>
#import "Location_plugin.h"
#import "Location_plugin_impl.h"
#include "core/config/engine.h"


// Godot 4.7's memnew() of a RefCounted returns a Ref<T>, not a raw pointer. Hold the
// instance in a Ref so it stays alive while registered as the "LocationPlugin" singleton;
// releasing the Ref on deinit frees it (replaces the old raw-pointer + memdelete).
static Ref<LocationPlugin> plugin;

void location_plugin_init() {
    NSLog(@"init Location plugin");
    plugin = memnew(LocationPlugin);
    Engine::get_singleton()->add_singleton(Engine::Singleton("LocationPlugin", plugin.ptr()));
}

void location_plugin_deinit() {
    NSLog(@"deinit Location plugin");
    plugin.unref();
}
