module rectangle;

import derelict.sdl2.sdl;
import window;

// Rectangle class for making the whole "gameboard"
class Rectangle
{
    SDL_Rect rect;

    this(int xPos, int yPos, int width, int height)
    {
        rect.x = xPos, rect.y = yPos, rect.w = width, rect.h = height;

        SDL_SetRenderDrawColor(Window.renderer, 255, 255, 255, 255);
        SDL_RenderFillRect(Window.renderer, &rect);
    }
}
