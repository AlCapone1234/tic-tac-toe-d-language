module image;

import derelict.sdl2.sdl;
import derelict.sdl2.image;

import std.stdio;

import window;

class Image
{
    SDL_Surface* surface = null;
    SDL_Texture* texture = null;
    SDL_Rect imageRect;

    int imageWidth = 100, imageHeight = 100;

    this(int positionX, int positionY, bool isX)
    {
        if (isX)
            surface = IMG_Load("res/X.png");
        else
            surface = IMG_Load("res/O.png");

        if (surface != null)
        {
            texture = SDL_CreateTextureFromSurface(Window.renderer, surface);
            SDL_FreeSurface(surface);

            imageRect.x = positionX;
            imageRect.y = positionY;
            imageRect.w = imageWidth;
            imageRect.h = imageHeight;

            SDL_RenderCopy(Window.renderer, texture, null, &imageRect);
        }
        else
        {
            writeln("Error: ", surface);
        }
    }

    void render()
    {
    }
}
