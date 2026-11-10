#import <Foundation/Foundation.h>

// Runs automatically when the dylib is loaded into a process.
__attribute__((constructor))
static void mylib_init(void) {
    NSLog(@"[MyLib] loaded into %@", [[NSBundle mainBundle] bundleIdentifier]);
}

// Example exported function callable from the host app.
__attribute__((visibility("default")))
int mylib_add(int a, int b) {
    return a + b;
}
