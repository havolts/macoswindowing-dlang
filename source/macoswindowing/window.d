//source/macoswindowing/window.d
module macoswindowing.window;
import std.stdio, std.conv, std.string;
import dmetal;

extern (C)
{
    void initializeApplication();
    void* createWindow(float width, float height, immutable(char)* title);
    void setupWindow(void* window);
    void activateApplication();
    void doTerminateOnCloseC(void* window, bool shouldTerminate);
    void pollEvents();
    void setView(void* window, void* view);
    void showWindow(void* window);
}
class Window
{
    void* window; // The window reference
    float width, height;
    shared this(int inWidth, int inHeight, string inTitle)
    {
        inTitle = format(inTitle);
        window = cast(shared(void*)) createWindow(cast(float) inWidth, cast(float) inHeight, inTitle.toStringz());
        initializeApplication(); // Safe, no threads involved here
        width = inWidth;
        height = inHeight;
    }

    // This function can be marked as shared, since it will be used for thread-safe window interaction
    shared void start()
    {
        setupWindow(cast(void*) window); // Cast to void* for window manipulation
        activateApplication();
    }

    shared void doTerminateOnClose(bool shouldTerminate)
    {
        doTerminateOnCloseC(cast(void*) window, shouldTerminate);
    }

    shared void setContentView(MTKView view)
    {
        setView(cast(void*) window, cast(void*) view);
    }

    shared void show()
    {
        showWindow(cast(void*) window);
    }
}
