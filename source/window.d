module window;

import derelict.sdl2.sdl;
import derelict.sdl2.ttf;

class Window
{
    /// Game Information
    const char* gameName = "Tic Tac Toe";
    static int screenWidth = 1280;
    static int screenHeight = 800;
    int screenPositionY = 50;
    int screenPositionX = 50;

    // Intitalize window
    static SDL_Window* sdlWindow = null;
    static SDL_Renderer* renderer = null;
    static SDL_Renderer* textRenderer = null;

    this()
    {
        // Create a window
        sdlWindow = SDL_CreateWindow(gameName, screenPositionX,
                screenPositionY, screenWidth, screenHeight, 0);

        // Create Graphics Renderer
        renderer = SDL_CreateRenderer(sdlWindow, -1, SDL_RENDERER_ACCELERATED);
    }
}
