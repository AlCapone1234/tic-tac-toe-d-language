module source.app;

// Default 
import std.stdio;
import std.random;
import std.conv;
import core.thread;

// SDL2 
import derelict.sdl2.sdl;
import derelict.sdl2.image;

// Custom
import window;
import rectangle;
import image;
import vector2;

bool hasUserWon = false;

// Which spot the player presses, if Player presses a unoccupied spot it becomes claimed.
bool[9] player1Presses = [false];
bool[9] player2Presses = [false];

// Spot positions
Vector2 firstSquarePos = Vector2(385, 100);
Vector2 secondSquarePos = Vector2(385 + 230, 100);
Vector2 thirdSquarePos = Vector2(385 + 230 * 2, 100);
Vector2 fourthSquarePos = Vector2(385, 300);
Vector2 fifthSquarePos = Vector2(385 + 230, 300);
Vector2 sixthSquarePos = Vector2(385 + 230 * 2, 300);
Vector2 seventhSquarePos = Vector2(385, 475);
Vector2 eigthSquarePos = Vector2(385 + 230, 475);
Vector2 ninthSquarePos = Vector2(385 + 230 * 2, 475);

void main()
{
	auto rnd = Random(unpredictableSeed);

	// Get a random number
	auto randomNumber = uniform(1, 3, rnd);
	assert(1 <= randomNumber && randomNumber < 3);

	// Load the libraries
	DerelictSDL2.load();
	DerelictSDL2Image.load();

	// Create a new window
	window.Window gameWindow = new window.Window();

	// If window was not created
	if (gameWindow.sdlWindow == null)
	{
		writeln("Could not find a window!");
	}

	int mouseX, mouseY;

	/// Waits for the user to click, if it has clicked on the spot it takes it unless it is already claimed.
	void waitingForUserClick(int mouseX, int mouseY, int clickPosition1,
			int clickPosition2, int clickPosition3, int clickPosition4, int spot)
	{

		/// Changes the turn
		void changeTurn()
		{
			if (randomNumber == 1)
			{
				player1Presses[spot] = true;
				randomNumber = 2;
			}
			else if (randomNumber == 2)
			{
				player2Presses[spot] = true;
				randomNumber = 1;
			}
		}

		do
		{
			if (mouseY <= clickPosition1 && mouseY > clickPosition2 && mouseX >= clickPosition3
					&& mouseX <= clickPosition4 && !player1Presses[spot] && !player2Presses[spot])
			{

				changeTurn();
				writeln("Current player turn = " ~ to!string(randomNumber));
				writeln("Player 1 presses = " ~ to!string(player1Presses));
				writeln("Player 2 presses = " ~ to!string(player2Presses));
			}
		}
		while (0);
	}

	// Game loop
	while (true)
	{
		SDL_Event e;
		if (SDL_WaitEvent(&e))
		{
			if (e.type == SDL_QUIT)
			{
				break;
			}
		}

		// Keep track of the current mouse position
		SDL_GetMouseState(&mouseX, &mouseY);

		// Create the black background
		SDL_SetRenderDrawColor(gameWindow.renderer, 0, 0, 0, 255);
		SDL_RenderClear(gameWindow.renderer);

		// Game border

		rectangle.Rectangle topBar = new rectangle.Rectangle(gameWindow.screenWidth / 2 - 330,
				gameWindow.screenHeight / 2 - 350, 700, 25);

		rectangle.Rectangle bottomBar = new rectangle.Rectangle(gameWindow.screenWidth / 2 - 330,
				gameWindow.screenHeight / 2 + 200, 700, 25);

		rectangle.Rectangle leftBar = new rectangle.Rectangle(gameWindow.screenWidth / 2 - 330,
				gameWindow.screenHeight / 2 - 330, 25, 550);

		rectangle.Rectangle middleLeftBar = new rectangle.Rectangle(gameWindow.screenWidth / 2 - 100,
				gameWindow.screenHeight / 2 - 350, 25, 550);

		rectangle.Rectangle middleRightBar = new rectangle.Rectangle(gameWindow.screenWidth / 2 + 125,
				gameWindow.screenHeight / 2 - 350, 25, 550);

		rectangle.Rectangle rightBar = new rectangle.Rectangle(gameWindow.screenWidth / 2 + 350,
				gameWindow.screenHeight / 2 - 350, 25, 575);

		rectangle.Rectangle middleTopBar = new rectangle.Rectangle(gameWindow.screenWidth / 2 - 330,
				gameWindow.screenHeight / 2 - 160, 700, 25);

		rectangle.Rectangle middleBottomBar = new rectangle.Rectangle(
				gameWindow.screenWidth / 2 - 330, gameWindow.screenHeight / 2 + 20, 700, 25);

		void showPicture(bool[] playerPressArray, bool isX)
		{
			foreach (index, spot; playerPressArray)
			{
				if (spot)
				{
					switch (index)
					{
					case 0:
						image.Image temp = new image.Image(firstSquarePos.x, firstSquarePos.y, isX);
						break;
					case 1:
						image.Image temp = new image.Image(secondSquarePos.x,
								secondSquarePos.y, isX);
						break;
					case 2:
						image.Image temp = new image.Image(thirdSquarePos.x, thirdSquarePos.y, isX);
						break;
					case 3:
						image.Image temp = new image.Image(fourthSquarePos.x,
								fourthSquarePos.y, isX);
						break;
					case 4:
						image.Image temp = new image.Image(fifthSquarePos.x, fifthSquarePos.y, isX);
						break;
					case 5:
						image.Image temp = new image.Image(sixthSquarePos.x, sixthSquarePos.y, isX);

						break;
					case 6:
						image.Image temp = new image.Image(seventhSquarePos.x,
								seventhSquarePos.y, isX);
						break;
					case 7:
						image.Image temp = new image.Image(eigthSquarePos.x, eigthSquarePos.y, isX);
						break;
					case 8:
						image.Image temp = new image.Image(ninthSquarePos.x, ninthSquarePos.y, isX);
						break;
					default:
						break;
					}
				}
			}
		}

		showPicture(player1Presses, true);
		showPicture(player2Presses, false);

		// Checks if the user has clicked a square, if so the user gets the spot unless its claimed.
		if (SDL_GetMouseState(&mouseX, &mouseY) == 1 && !hasUserWon)
		{
			waitingForUserClick(mouseX, mouseY, 239, 75, 335, 539, 0);
			waitingForUserClick(mouseX, mouseY, 239, 75, 565, 764, 1);
			waitingForUserClick(mouseX, mouseY, 239, 75, 790, 989, 2);
			waitingForUserClick(mouseX, mouseY, 420, 265, 335, 539, 3);
			waitingForUserClick(mouseX, mouseY, 420, 265, 565, 764, 4);
			waitingForUserClick(mouseX, mouseY, 420, 265, 790, 989, 5);
			waitingForUserClick(mouseX, mouseY, 598, 445, 335, 539, 6);
			waitingForUserClick(mouseX, mouseY, 598, 445, 565, 764, 7);
			waitingForUserClick(mouseX, mouseY, 598, 445, 790, 989, 8);
		}

		void clearGameboard()
		{
			Thread.sleep(2.seconds);
			foreach (spot; player1Presses)
			{
				spot = false;
			}

			foreach (spot; player2Presses)
			{
				spot = false;
			}
		}

		void checkWin(bool[] Player, bool isX)
		{
			if ((Player[0] && Player[1] && Player[2]) || (Player[0]
					&& Player[3] && Player[6]) || (Player[1] && Player[4]
					&& Player[7]) || (Player[2] && Player[5] && Player[8])
					|| (Player[6] && Player[7] && Player[8]) || (Player[3]
						&& Player[4] && Player[5]) || (Player[2] && Player[4]
						&& Player[7]) || (Player[0] && Player[4] && Player[8]))
			{
				if (isX)
				{
					writeln("Player X has won!");
					hasUserWon = true;
				}
				else
				{
					writeln("Player O has won!");
					hasUserWon = true;
				}
			}
		}

		SDL_RenderPresent(gameWindow.renderer);
		checkWin(player1Presses, true);
		checkWin(player2Presses, false);
	}

	// Clean Up
	SDL_DestroyRenderer(Window.renderer);
	SDL_DestroyWindow(Window.sdlWindow);

	IMG_Quit();
	SDL_Quit();
}
