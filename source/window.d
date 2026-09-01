module window;

// This should be a generic window for all OSs.
// Should act as a Facade to hide different OSs from user.

class Window
{
    // Checks which OS is used
    // Once found, it acts as that OSs window.
    version(OSX)
    {
        this()
        {

        }
    }

}
