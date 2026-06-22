module macoswindowing.window;
import std.stdio, std.conv, std.string;

extern (C)
{
    void initializeApplication();
    void* createWindow(float width, float height, immutable(char)* title);
    void setupWindow(void* window);
    void activateApplication();
    void doTerminateOnCloseC(void* window, bool shouldTerminate);
    void pollEvents();
}

class Window
{
    void* window; // The window reference
    int width, height;
    string title;

    // Constructor should not be marked as `shared`
    shared this(int inWidth, int inHeight, string inTitle)
    {
        width = inWidth;
        height = inHeight;
        title = inTitle;
        initializeApplication(); // Safe, no threads involved here
    }

    // This function can be marked as shared, since it will be used for thread-safe window interaction
    shared void start()
    {
        title = format(title);
        window = cast(shared(void*)) createWindow(cast(float) width, cast(float) height, title.toStringz());
        setupWindow(cast(void*) window); // Cast to void* for window manipulation
        activateApplication();
    }

    // Shared getter methods
    shared float getWidth()
    {
        return width;
    }

    shared float getHeight()
    {
        return height;
    }

    shared void doTerminateOnClose(bool shouldTerminate)
    {
        doTerminateOnCloseC(cast(void*) window, shouldTerminate);
    }
}
